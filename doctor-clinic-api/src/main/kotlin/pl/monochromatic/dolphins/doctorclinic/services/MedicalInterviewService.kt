package pl.monochromatic.dolphins.doctorclinic.services

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochromatic.dolphins.doctorclinic.ai.KnnService
import pl.monochromatic.dolphins.doctorclinic.models.ai.MedicalData
import pl.monochromatic.dolphins.doctorclinic.models.dao.MedicalInterview

@Service
class MedicalInterviewService @Autowired constructor(
    private val userService: UserService,
    private val knnService: KnnService
) {
    fun analyzeMedicalInterview(medicalInterview: MedicalInterview): MedicalInterview? {
        val medicalData = medicalInterview.toMedicalData()
        medicalData?.let { mdData ->
            val outcome = knnService.analyze(mdData)
            val user = medicalInterview.patient?.id?.let { userId -> userService.getUser(userId) }
            user?.let {
                user.diagnosis?.result = outcome
                user.medicalInterview?.age = medicalInterview.age
                user.medicalInterview?.pregnancy = medicalInterview.pregnancy
                user.medicalInterview?.glucose = medicalInterview.glucose
                user.medicalInterview?.bloodPressure = medicalInterview.bloodPressure
                user.medicalInterview?.skinThickness = medicalInterview.skinThickness
                user.medicalInterview?.insulin = medicalInterview.insulin
                user.medicalInterview?.bmi = medicalInterview.bmi
                user.medicalInterview?.diabetesPedigree = medicalInterview.diabetesPedigree
                user.medicalInterview?.doctor = medicalInterview.doctor
                userService.updateUser(it)
            }

        }
        return null
    }
}

private fun MedicalInterview.toMedicalData(): MedicalData? {
    val ageCopy = this.age
    val pregnancyCopy = this.pregnancy
    val glucoseCopy = this.glucose
    val bloodPressureCopy = this.bloodPressure
    val skinThicknessCopy = this.skinThickness
    val insulinCopy = this.insulin
    val bmiCopy = this.bmi
    val diabetesPedigreeCopy = this.diabetesPedigree

    return if (pregnancyCopy != null && glucoseCopy != null && bloodPressureCopy != null && skinThicknessCopy != null &&
        insulinCopy != null && bmiCopy != null && diabetesPedigreeCopy != null && ageCopy != null)
        MedicalData(
            pregnancies = pregnancyCopy,
            glucose = glucoseCopy,
            bloodPressure = bloodPressureCopy,
            skinThickness = skinThicknessCopy,
            insulin = insulinCopy,
            bmi = bmiCopy,
            diabetesFunction = diabetesPedigreeCopy,
            age = ageCopy,
            outcome = 0
        )
    else
        null
}