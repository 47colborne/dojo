public enum Direction {
    N, E, S, W;

    public Direction rotateClockWise() {
        return values()[(ordinal() + 1) % values().length];
    }

    public Direction rotateCounterClockWise() {
        return values()[(ordinal() + 3) % values().length];
    }
}
