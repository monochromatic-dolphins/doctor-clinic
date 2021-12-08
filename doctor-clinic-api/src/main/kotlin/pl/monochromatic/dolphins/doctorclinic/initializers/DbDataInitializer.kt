package pl.monochromatic.dolphins.doctorclinic.initializers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.stereotype.Component
import pl.monochromatic.dolphins.doctorclinic.models.dao.User
import pl.monochromatic.dolphins.doctorclinic.models.enums.Role
import pl.monochromatic.dolphins.doctorclinic.services.DiagnosisService
import pl.monochromatic.dolphins.doctorclinic.services.MedicalInterviewService
import pl.monochromatic.dolphins.doctorclinic.services.UserService
import kotlin.math.log

@Component
class DbDataInitializer @Autowired constructor(
    private val userService: UserService,
    private val diagnosisService: DiagnosisService,
    private val medicalInterviewService: MedicalInterviewService,
) : ApplicationRunner {

    override fun run(args: ApplicationArguments?) {
        userService.createUsers(
            User(
                id = null,
                name = "Szymon",
                surname = "Lipiec",
                login = "slipiec",
                password = "admin",
                role = Role.DOCTOR,
            ),
            User(
                id = null,
                name = "Julia",
                surname = "Iskierka",
                login = "jiskierka",
                password = "123",
                role = Role.PATIENT
            )
        )
    }
}