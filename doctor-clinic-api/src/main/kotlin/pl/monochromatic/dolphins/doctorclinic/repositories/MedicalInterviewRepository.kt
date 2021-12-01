package pl.monochromatic.dolphins.doctorclinic.repositories

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import pl.monochromatic.dolphins.doctorclinic.models.dao.MedicalInterview

@Repository
interface MedicalInterviewRepository: JpaRepository<MedicalInterview, Int>