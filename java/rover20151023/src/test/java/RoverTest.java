import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import static org.junit.Assert.assertEquals;


/**
 * Created by jeffli on 15-10-23.
 */
public class RoverTest {

    private Rover rover;
    private Position defaultPos;

    @Before
    public void setUp() throws Exception {
        defaultPos = Mockito.mock(Position.class);
        rover = new Rover(defaultPos);
    }

    @Test
    public void testMoveForward() {
        rover.moveForward();
        verify(defaultPos).moveForward();
    }
}