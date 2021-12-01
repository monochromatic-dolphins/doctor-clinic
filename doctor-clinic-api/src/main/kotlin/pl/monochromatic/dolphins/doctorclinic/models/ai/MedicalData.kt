package pl.monochromatic.dolphins.doctorclinic.models.ai

data class MedicalData(
    val pregnancies: Int,
    val glucose: Int,
    val bloodPressure: Int,
    val skinThickness: Int,
    val insulin: Int,
    val bmi: Double,
    val diabetesFunction: Double,
    val age: Int,
    val outcome: Int
)
