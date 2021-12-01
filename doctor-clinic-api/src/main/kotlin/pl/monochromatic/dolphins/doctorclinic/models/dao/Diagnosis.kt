package pl.monochromatic.dolphins.doctorclinic.models.dao

import com.fasterxml.jackson.annotation.JsonBackReference
import javax.persistence.*

@Entity
@Table(name = "diagnoses")
class Diagnosis(

    @Id
    @Column(name = "patient_id")
    val id: Int?,

    @OneToOne
    @MapsId
    @JsonBackReference
    @JoinColumn(name = "patient_id")
    val patient: User?,

    @Column(nullable = true)
    var result: Int? = null
)