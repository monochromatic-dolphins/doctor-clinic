package pl.monochromatic.dolphins.doctorclinic.repositories

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import pl.monochromatic.dolphins.doctorclinic.models.dao.User
import pl.monochromatic.dolphins.doctorclinic.models.enums.Role

@Repository
interface UserRepository: JpaRepository<User, Int> {
    fun findByLogin(login: String): User?

    fun findAllByRole(role: Role): List<User>
}