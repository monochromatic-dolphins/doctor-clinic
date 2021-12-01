package pl.monochromatic.dolphins.doctorclinic

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import pl.monochromatic.dolphins.doctorclinic.security.RsaEncryptor

@SpringBootTest
class RsaEncryptorTest {

    @Autowired
    private lateinit var rsaEncryptor: RsaEncryptor

    @Test
    fun isValidEncodedAndDecoded() {
        val message = "This is test message"
        val encodedMessage = rsaEncryptor.encrypt(message)
        val decryptedMessage = rsaEncryptor.decrypt(encodedMessage)
        Assertions.assertEquals(message, decryptedMessage)
    }
}