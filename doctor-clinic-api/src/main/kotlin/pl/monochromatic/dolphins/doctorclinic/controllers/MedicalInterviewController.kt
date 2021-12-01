package pl.monochromatic.dolphins.doctorclinic.controllers

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import pl.monochromatic.dolphins.doctorclinic.models.dao.MedicalInterview
import pl.monochromatic.dolphins.doctorclinic.services.MedicalInterviewService

@RestController
@RequestMapping("/medical-interviews")
class MedicalInterviewController @Autowired constructor(
    private val medicalInterviewService: MedicalInterviewService
){
    @PostMapping
    fun analyzeMedicalInterview(@RequestBody medicalInterview: MedicalInterview) {
        medicalInterviewService.analyzeMedicalInterview(medicalInterview)
    }
}