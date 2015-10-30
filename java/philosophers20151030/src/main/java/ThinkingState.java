public class ThinkingState {
    private long startTime;
    public ThinkingState nextState;

    public ThinkingState(long startTime) {
        this.startTime = startTime;
    }

    public ThinkingState goToNextState() {
        return this;
    }
}
