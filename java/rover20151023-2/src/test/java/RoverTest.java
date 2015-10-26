import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class RoverTest {
    @Mock
    Coordinates coordinates;
    @Mock
    Coordinates newCoordinates;
    @Mock
    Direction direction;
    @Mock
    Direction newDirection;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void turnLeftRotatesCounterClockwise() {
        when(direction.rotateCounterClockWise()).thenReturn(newDirection);

        Rover rover = new Rover(coordinates, direction);
        rover.turnLeft();

        verify(direction).rotateCounterClockWise();
        assertEquals(newDirection, rover.getDirection());
    }

    @Test
    public void turnRightRotatesClockwise() {
        when(direction.rotateClockWise()).thenReturn(newDirection);

        Rover rover = new Rover(coordinates, direction);
        rover.turnRight();

        verify(direction).rotateClockWise();
        assertEquals(newDirection, rover.getDirection());
    }

    @Test
    public void moveMovesToNewCoordinatesInDirection() {
        Rover rover = new Rover(coordinates, direction);
        rover.move();

        verify(coordinates).move(direction);
        assertEquals(newCoordinates, rover.getCoordinates());
    }
}