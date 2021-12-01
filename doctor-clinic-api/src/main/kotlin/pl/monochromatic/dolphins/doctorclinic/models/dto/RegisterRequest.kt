package pl.monochromatic.dolphins.doctorclinic.models.dto

data class RegisterRequest(
    val login: String,
    var password: String,
    val name: String,
    val surname: String
)
