package pl.monochromatic.dolphins.doctorclinic

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class DoctorClinicApplication

fun main(args: Array<String>) {
	runApplication<DoctorClinicApplication>(*args)
}
