package pl.monochromatic.dolphins.doctorclinic.initializers

import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.stereotype.Component
import pl.monochromatic.dolphins.doctorclinic.ai.KnnService
import pl.monochromatic.dolphins.doctorclinic.models.ai.MedicalData
import pl.monochromatic.dolphins.doctorclinic.models.enums.MedicalDataHeader

@Component
class KnnInitializer @Autowired constructor(
    private val knnService: KnnService
) : ApplicationRunner {
    override fun run(args: ApplicationArguments?) {
        val reader = this.javaClass.classLoader.getResourceAsStream("db-init/diabetes.csv").bufferedReader()
        val csvParser = CSVParser(
            reader, CSVFormat.Builder.create(CSVFormat.DEFAULT)
                .setDelimiter(',')
                .setHeader(MedicalDataHeader::class.java)
                .setSkipHeaderRecord(true)
                .build()
        )
        for (csvRecord in csvParser) {
            val medicalData = MedicalData(
                pregnancies = csvRecord.get(MedicalDataHeader.Pregnancies).toInt(),
                glucose = csvRecord.get(MedicalDataHeader.Glucose).toInt(),
                bloodPressure = csvRecord.get(MedicalDataHeader.BloodPressure).toInt(),
                skinThickness = csvRecord.get(MedicalDataHeader.SkinThickness).toInt(),
                insulin = csvRecord.get(MedicalDataHeader.Insulin).toInt(),
                bmi = csvRecord.get(MedicalDataHeader.BMI).toDouble(),
                diabetesFunction = csvRecord.get(MedicalDataHeader.DiabetesPedigreeFunction).toDouble(),
                age = csvRecord.get(MedicalDataHeader.Age).toInt(),
                outcome = csvRecord.get(MedicalDataHeader.Outcome).toInt()
            )
            knnService.addToDataSet(medicalData)
        }
        knnService.initialize()
    }

}