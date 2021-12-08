package pl.monochromatic.dolphins.doctorclinic.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pl.monochromatic.dolphins.doctorclinic.models.dao.User
import pl.monochromatic.dolphins.doctorclinic.models.dto.LoginRequest
import pl.monochromatic.dolphins.doctorclinic.models.dto.RegisterRequest
import pl.monochromatic.dolphins.doctorclinic.services.UserService

@RestController
class UserController @Autowired constructor(
    private val userService: UserService
) {
    @GetMapping("/users")
    fun test(): ResponseEntity<List<User>> {
        val users = userService
            .getAllPatients()
        return ResponseEntity.ok(users)
    }

    @PostMapping("/login")
    fun login(@RequestBody loginRequest: LoginRequest): ResponseEntity<User> {
        val user = userService.login(loginRequest)
        if (user?.id != null)
            return ResponseEntity.ok(user)
        return ResponseEntity.badRequest().build()
    }

    @PostMapping("/register")
    fun register(@RequestBody registerRequest: RegisterRequest): ResponseEntity<User> {
        val createdUser = userService.register(registerRequest)
        createdUser.id?.let {
            return ResponseEntity.ok(createdUser)
        }
        return ResponseEntity.badRequest().build()
    }
}