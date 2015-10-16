import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.*;

public class RoverTest {

    private Rover rover;

    @Before
    public void setUp() throws Exception {
       rover = new Rover(2, 3, Direction.N);
    }

    @Test
    public void moveForwardNorth() {
        rover.moveForward();
        assertEquals(4, rover.getY());
    }

    @Test
    @Ignore
    public void moveForwardEast() {
        rover = new Rover(2, 3, Direction.E);
        rover.moveForward();
        assertEquals(3, rover.getX());
    }

    @Test
    public void turnLeft() {
        rover.turnLeft();
        assertEquals(Direction.W, rover.getDirection());
    }

}