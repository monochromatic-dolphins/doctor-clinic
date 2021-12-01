package pl.monochromatic.dolphins.doctorclinic.models.dto

data class LoginRequest(
    val login: String,
    var password: String
)