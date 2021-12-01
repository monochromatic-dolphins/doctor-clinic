package pl.monochromatic.dolphins.doctorclinic.ai

import org.springframework.stereotype.Service
import pl.monochromatic.dolphins.doctorclinic.models.ai.MedicalData
import pl.monochromatic.dolphins.doctorclinic.models.ai.NormalizedMedicalData
import pl.monochromatic.dolphins.doctorclinic.models.ai.ValueRange
import pl.monochromatic.dolphins.doctorclinic.models.enums.MedicalDataHeader
import kotlin.math.pow
import kotlin.math.sqrt

@Service
class KnnService {

    private val dataSet = mutableListOf<MedicalData>()
    private val normalizationMap = mutableMapOf<MedicalDataHeader, ValueRange>()
    private val normalizedDataSet = mutableListOf<NormalizedMedicalData>()

    fun addToDataSet(medicalData: MedicalData) {
        this.dataSet.add(medicalData)
    }

    fun initialize() {
        createNormalizationMap()
        normalizeValues()
    }

    fun analyze(medicalData: MedicalData): Int {
        val normalizedData = medicalData.normalized()
        val sortedKnnSet = normalizedDataSet.map { it to distance(normalizedData, it) }.sortedBy { it.second }
        var positive = 0
        var negative = 0
        sortedKnnSet.take(5).forEach{ if (it.first.outcome == 0.0) negative++ else positive++}
        return if (negative > positive) 0 else 1
    }

    private fun MedicalData.normalized() = NormalizedMedicalData(
        pregnancies = normalizeValue(MedicalDataHeader.Pregnancies, this.pregnancies),
        glucose = normalizeValue(MedicalDataHeader.Glucose, this.glucose),
        bloodPressure = normalizeValue(MedicalDataHeader.BloodPressure, this.bloodPressure),
        skinThickness = normalizeValue(MedicalDataHeader.SkinThickness, this.skinThickness),
        insulin = normalizeValue(MedicalDataHeader.Insulin, this.insulin),
        bmi = normalizeValue(MedicalDataHeader.BMI, this.bmi),
        diabetesFunction = normalizeValue(
            MedicalDataHeader.DiabetesPedigreeFunction,
            this.diabetesFunction
        ),
        age = normalizeValue(MedicalDataHeader.Age, this.age),
        outcome = normalizeValue(MedicalDataHeader.Outcome, this.outcome),
    )

    private fun createNormalizationMap() = MedicalDataHeader.values().forEach { createRangesForMedicalData(it) }

    private fun normalizeValues() {
        dataSet.forEach { medicalData ->
            normalizedDataSet.add(medicalData.normalized())
        }
    }

    private fun normalizeValue(medicalDataHeader: MedicalDataHeader, value: Double): Double {
        val range = normalizationMap[medicalDataHeader]
        if (range != null) {
            return normalizeToRange(range.min, range.max, 0.0, 100.0, value)
        }
        return 0.0
    }

    private fun normalizeValue(medicalDataHeader: MedicalDataHeader, value: Int): Double {
        val range = normalizationMap[medicalDataHeader]
        if (range != null) {
            return normalizeToRange(range.min, range.max, 0.0, 100.0, value.toDouble())
        }
        return 0.0
    }

    private fun createRangesForMedicalData(medicalDataHeader: MedicalDataHeader) {
        val simpleDataSet = dataSet.map {
            when (medicalDataHeader) {
                MedicalDataHeader.Pregnancies -> it.pregnancies.toDouble()
                MedicalDataHeader.Glucose -> it.glucose.toDouble()
                MedicalDataHeader.BloodPressure -> it.bloodPressure.toDouble()
                MedicalDataHeader.SkinThickness -> it.skinThickness.toDouble()
                MedicalDataHeader.Insulin -> it.insulin.toDouble()
                MedicalDataHeader.BMI -> it.bmi
                MedicalDataHeader.DiabetesPedigreeFunction -> it.diabetesFunction
                MedicalDataHeader.Age -> it.age.toDouble()
                MedicalDataHeader.Outcome -> it.outcome.toDouble()
            }
        }
        val min = simpleDataSet.minOrNull()
        val max = simpleDataSet.maxOrNull()
        if (min != null && max != null)
            normalizationMap[medicalDataHeader] = ValueRange(min, max)
        else
            throw RuntimeException("Something went wrong :)")
    }

    private fun normalizeToRange(oldMin: Double, oldMax: Double, newMin: Double, newMax: Double,
                                 value: Double): Double {
        val oldRange = oldMax - oldMin
        val newRange = newMax - newMin
        return (((value - oldMin) * newRange) / oldRange) + newMin
    }

    private fun distance(a: NormalizedMedicalData, b: NormalizedMedicalData) = sqrt(
        (a.pregnancies - b.pregnancies).pow(2) +
                (a.glucose - b.glucose).pow(2) +
                (a.bloodPressure - b.bloodPressure).pow(2) +
                (a.skinThickness - b.skinThickness).pow(2) +
                (a.insulin - b.insulin).pow(2) +
                (a.bmi - b.bmi).pow(2) +
                (a.diabetesFunction - b.diabetesFunction).pow(2) +
                (a.age - b.age).pow(2)
    )

}