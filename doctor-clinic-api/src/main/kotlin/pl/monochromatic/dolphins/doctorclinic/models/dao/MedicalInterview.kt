package pl.monochromatic.dolphins.doctorclinic.models.dao

import com.fasterxml.jackson.annotation.JsonBackReference
import javax.persistence.*

@Entity
@Table(name = "medical_interviews")
class MedicalInterview(

    @Id
    @Column(name = "patient_id")
    val id: Int?,

    @OneToOne
    @MapsId
    @JsonBackReference
    @JoinColumn(name = "patient_id")
    val patient: User?,

    var pregnancy: Int? = null,
    var glucose: Int? = null,
    var bloodPressure: Int? = null,
    var skinThickness: Int? = null,
    var insulin: Int? = null,
    var bmi: Double? = null,
    var diabetesPedigree: Double? = null,
    var age: Int? = null,

    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = true)
    var doctor: User? = null
)