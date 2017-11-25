import org.amshove.kluent.shouldEqual
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.it

internal class MainTest : Spek({
    it("scores a simple single frame") {
        val frames = listOf(Frame(1, 2))

        calculateScore(frames) shouldEqual 3
    }

    it("scores a spare frame") {
        val frames = listOf(Frame(5, 5), Frame(1, 2))
        calculateScore(frames) shouldEqual 11 + 3
    }

    it("scores a strike frame") {
        val frames = listOf(Frame(10, 0), Frame(1, 2))
        calculateScore(frames) shouldEqual 13 + 3
    }

    it("scores consecutive strike frames") {
        val frames = listOf(Frame(10, 0), Frame(10, 0), Frame(1, 2))
        calculateScore(frames) shouldEqual 21 + 13 + 3
    }

    it("scores a final strike frame") {
        val frames = listOf(Frame(10, 10, 10))
        calculateScore(frames) shouldEqual 30
    }
})
