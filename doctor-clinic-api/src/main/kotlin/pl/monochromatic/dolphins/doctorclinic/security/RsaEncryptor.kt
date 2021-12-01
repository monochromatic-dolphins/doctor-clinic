package pl.monochromatic.dolphins.doctorclinic.security

import org.springframework.stereotype.Service
import java.nio.charset.StandardCharsets
import java.security.KeyPairGenerator
import java.util.*
import javax.crypto.Cipher

@Service
class RsaEncryptor {

    private val encryptCipher: Cipher
    private val decryptCipher: Cipher
    private val base64Encoder = Base64.getEncoder();
    private val base64Decoder = Base64.getDecoder();

    init {
        val generator = KeyPairGenerator.getInstance("RSA")
        generator.initialize(2048)
        val keyPair = generator.genKeyPair()
        val publicKey = keyPair.public
        val privateKey = keyPair.private
        encryptCipher = Cipher.getInstance("RSA")
        encryptCipher.init(Cipher.ENCRYPT_MODE, publicKey)
        decryptCipher = Cipher.getInstance("RSA")
        decryptCipher.init(Cipher.DECRYPT_MODE, privateKey)
    }

    fun encrypt(text: String): String {
        val encoded = encryptCipher.doFinal(text.toByteArray())
        return encodeBase64ToString(encoded)
    }

    fun decrypt(text: String): String {
        val decryptedBytes = decryptCipher.doFinal(decodeBase64ToByteArray(text))
        return String(decryptedBytes, StandardCharsets.UTF_8)
    }

    private fun encodeBase64ToString(byteArray: ByteArray): String {
        return base64Encoder.encodeToString(byteArray)
    }

    private fun decodeBase64ToByteArray(text: String): ByteArray {
        return base64Decoder.decode(text)
    }

}