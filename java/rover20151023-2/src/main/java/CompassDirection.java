public enum CompassDirection implements Direction {
    N, E, S, W;

    @Override
    public Direction rotateClockWise() {
        return values()[(ordinal() + 1) % values().length];
    }

    @Override
    public Direction rotateCounterClockWise() {
        return values()[(ordinal() + 3) % values().length];
    }
}

