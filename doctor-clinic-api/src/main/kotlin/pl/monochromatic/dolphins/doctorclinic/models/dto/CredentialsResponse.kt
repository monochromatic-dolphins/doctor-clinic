package pl.monochromatic.dolphins.doctorclinic.models.dto

import pl.monochromatic.dolphins.doctorclinic.models.enums.Role

data class CredentialsResponse(
    val userId: Int,
    val role: Role
)