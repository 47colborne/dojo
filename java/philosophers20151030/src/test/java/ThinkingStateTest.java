import org.junit.Test;
import org.mockito.Mockito;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

public class ThinkingStateTest {

    private ThinkingState state = new ThinkingState(100);
    private Simulation sim = Mockito.mock(Simulation.class);

    @Test
    public void shouldReturnItselfIfNotEnoughTimeHasPassed() {
        when(sim.getTime()).thenReturn(101L);
        assertEquals(state, state.goToNextState());
    }

//    @Test
//    public void shouldReturnNextState() {
//        when(sim.getTime()).thenReturn(500L);
//        assertTrue(state.goToNextState() instanceof HungryState);
//    }

}