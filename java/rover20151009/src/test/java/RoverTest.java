import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * Created by jeffli on 15-10-09.
 */
public class RoverTest {

    private Rover rover;

    @Before
    public void setUp() throws Exception {
        rover = new Rover (1, 2, Direction.NORTH);
    }

    @Test
    public void testMoveForward() {
        rover.move();

        assertEquals(rover.getX(), 1);
        assertEquals(rover.getY(), 3);
        assertEquals(rover.getDegree(), 0);
    }

    @Test
    public void testRightTurn() {
        rover.turn(90);

        assertEquals(rover.getX(), 1);
        assertEquals(rover.getY(), 2);
        assertEquals(rover.getDegree(), 90);
    }

    @Test
    public void testOverRightTurn() {
        rover.turn(900);

        assertEquals(rover.getDegree(),180);
    }

    @Test
    public void testLeftTurn() {
        rover.turn(-90);

        assertEquals(270, rover.getDegree());
    }

    @Test
    public void testOverLeftTurn() {
        rover.turn(-900);

        assertEquals(180, rover.getDegree());
    }

    @Test
    public void turnRightAndMove(){
        rover.turn(90);
        rover.move();
        assertEquals(rover.getX(), 2);
        assertEquals(rover.getY(), 2);
    }

    @Test
    public void turnRightTwiceAndMove(){
        rover.turn(180);
        rover.move();
        assertEquals(rover.getX(), 1);
        assertEquals(rover.getY(), 1);
    }

    @Test
    public void turnLeftAndMove(){
        rover.turn(-90);
        rover.move();
        assertEquals(rover.getX(), 0);
        assertEquals(rover.getY(), 2);
    }

}