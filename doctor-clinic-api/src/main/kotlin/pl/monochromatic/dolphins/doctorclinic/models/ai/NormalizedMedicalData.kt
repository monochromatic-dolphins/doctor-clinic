package pl.monochromatic.dolphins.doctorclinic.models.ai

data class NormalizedMedicalData(
    val pregnancies: Double,
    val glucose: Double,
    val bloodPressure: Double,
    val skinThickness: Double,
    val insulin: Double,
    val bmi: Double,
    val diabetesFunction: Double,
    val age: Double,
    val outcome: Double
)
