data class Frame(val roll1: Int, private val roll2: Int, private val roll3: Int = 0) {
    val score = roll1 + roll2 + roll3

    val isStrike = roll1 == 10
    val isSpare = roll1 != 10 && score == 10
}

fun calculateScore(frames: List<Frame>): Int {
    var totalScore = 0

    frames.forEachIndexed { index, frame ->
        val bonus = when {
            frame.isSpare -> frames[index + 1].roll1

            frame.isStrike && index != frames.lastIndex ->
                if (frames[index + 1].isStrike) {
                    frames[index + 1].roll1 + frames[index + 2].roll1
                } else {
                    frames[index + 1].score
                }

            else -> 0
        }

        totalScore += frame.score + bonus
    }

    return totalScore
}
