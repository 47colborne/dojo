public class Rover {
    private Coordinates coordinates;
    private Direction direction;

    public Rover(Coordinates coordinates, Direction direction) {
        this.coordinates = coordinates;
        this.direction = direction;
    }

    public Coordinates getCoordinates() {
        return coordinates;
    }

    public Direction getDirection() {
        return direction;
    }

    public void turnLeft() {
        direction = direction.rotateCounterClockWise();
    }

    public void turnRight() {
        direction = direction.rotateClockWise();
    }

    public void move() {
        coordinates = coordinates.move(direction);
    }
}
