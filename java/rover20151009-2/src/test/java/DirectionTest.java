import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class DirectionTest {
    @Test
    public void rotateClockWise() {
        assertEquals(Direction.E, Direction.N.rotateClockWise());
        assertEquals(Direction.S, Direction.E.rotateClockWise());
        assertEquals(Direction.W, Direction.S.rotateClockWise());
        assertEquals(Direction.N, Direction.W.rotateClockWise());
    }

    @Test
    public void rotateCounterClockWise() {
        assertEquals(Direction.W, Direction.N.rotateCounterClockWise());
        assertEquals(Direction.S, Direction.W.rotateCounterClockWise());
        assertEquals(Direction.E, Direction.S.rotateCounterClockWise());
        assertEquals(Direction.N, Direction.E.rotateCounterClockWise());
    }
}
