import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class DirectionTest {
    @Test
    public void rotateClockWise() {
        assertEquals(CompassDirection.E, CompassDirection.N.rotateClockWise());
        assertEquals(CompassDirection.S, CompassDirection.E.rotateClockWise());
        assertEquals(CompassDirection.W, CompassDirection.S.rotateClockWise());
        assertEquals(CompassDirection.N, CompassDirection.W.rotateClockWise());
    }

    @Test
    public void rotateCounterClockWise() {
        assertEquals(CompassDirection.W, CompassDirection.N.rotateCounterClockWise());
        assertEquals(CompassDirection.S, CompassDirection.W.rotateCounterClockWise());
        assertEquals(CompassDirection.E, CompassDirection.S.rotateCounterClockWise());
        assertEquals(CompassDirection.N, CompassDirection.E.rotateCounterClockWise());
    }
}
