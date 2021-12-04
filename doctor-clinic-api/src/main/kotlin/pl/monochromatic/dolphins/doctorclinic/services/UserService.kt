package pl.monochromatic.dolphins.doctorclinic.services

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochromatic.dolphins.doctorclinic.models.dao.Diagnosis
import pl.monochromatic.dolphins.doctorclinic.models.dao.MedicalInterview
import pl.monochromatic.dolphins.doctorclinic.models.dao.User
import pl.monochromatic.dolphins.doctorclinic.models.dto.LoginRequest
import pl.monochromatic.dolphins.doctorclinic.models.dto.RegisterRequest
import pl.monochromatic.dolphins.doctorclinic.models.enums.Role
import pl.monochromatic.dolphins.doctorclinic.repositories.UserRepository
import pl.monochromatic.dolphins.doctorclinic.security.RsaEncryptor

@Service
class UserService @Autowired constructor(
    private val userRepository: UserRepository,
    private val rsaEncryptor: RsaEncryptor,
) {
    fun createUser(user: User): User {
        val encodedPassword = user.password?.let { rsaEncryptor.encrypt(it) }
        user.password = encodedPassword
        return when (user.role) {
            Role.DOCTOR -> userRepository.save(user)
            Role.PATIENT -> {
                // Create User's diagnosis
                val userDiagnosis = Diagnosis(
                    id = user.id,
                    patient = user
                )
                // Create User's medical interview
                val userMedicalInterview = MedicalInterview(
                    id = user.id,
                    patient = user
                )
                // Attach to User
                user.diagnosis = userDiagnosis
                user.medicalInterview = userMedicalInterview
                // Save and return
                return userRepository.save(user)
            }
        }
    }

    fun createUsers(vararg users: User) = users.forEach { createUser(it) }

    fun getAllPatients(): List<User> = userRepository.findAllByRole(Role.PATIENT)

    fun login(loginRequest: LoginRequest): User? {
        val user = userRepository.findByLogin(loginRequest.login)
        return if (loginRequest.password == user?.password?.let { rsaEncryptor.decrypt(it) })
            user
        else
            null
    }

    fun register(registerRequest: RegisterRequest): User {
        return createUser(
            User(
                name = registerRequest.name,
                surname = registerRequest.surname,
                login = registerRequest.login,
                password = registerRequest.password,
                role = Role.PATIENT
            )
        )
    }

    fun getUser(id: Int) = userRepository.getById(id)

    fun updateUser(user: User) = userRepository.save(user)
}