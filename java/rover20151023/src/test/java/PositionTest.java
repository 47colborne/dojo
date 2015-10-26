import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by jeffli on 15-10-23.
 */
public class PositionTest {

    private Position position;

    @Before
    public void setUp() throws Exception {
        position = new Position(0, 0, 0);
    }

    @Test
    public void testMoveForwardFromOrigin() {
        Position p = position.moveForward();
        assertEquals(0, p.getX());
        assertEquals(1, p.getY());
    }

    @Test
    public void testMoveForwardFromElsewhere() {
        Position oldPos = new Position(2,3,90);
        Position newPos = oldPos.moveForward();
        assertEquals(3, newPos.getX());
        assertEquals(3, newPos.getY());
    }

    @Test
    public void testRotateLeftAt90Degrees() {
        Position oldPos = new Position(0,0,90);
        Position newPos = oldPos.rotateLeft();
        assertEquals(0, newPos.getDegree());
    }


}