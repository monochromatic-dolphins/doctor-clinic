package pl.monochromatic.dolphins.doctorclinic.models.dao

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonManagedReference
import com.fasterxml.jackson.annotation.JsonProperty
import pl.monochromatic.dolphins.doctorclinic.models.enums.Role
import javax.persistence.*

@Entity
@Table(name = "users")
class User(

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Int? = null,

    val name: String,

    val surname: String,

    val login: String,

    @Column(length = 512)
    var password: String,

    val role: Role,

    @OneToOne(mappedBy = "patient", cascade = [CascadeType.PERSIST], optional = true)
    @JsonManagedReference
    @PrimaryKeyJoinColumn
    var medicalInterview: MedicalInterview? = null,

    @OneToOne(mappedBy = "patient", cascade = [CascadeType.PERSIST], optional = true)
    @PrimaryKeyJoinColumn
    @JsonManagedReference
    var diagnosis: Diagnosis? = null
)