import org.amshove.kluent.shouldEqual
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.it

internal class MainTest : Spek({
    it("does something") {
        1 + 1 shouldEqual 2
    }
})
