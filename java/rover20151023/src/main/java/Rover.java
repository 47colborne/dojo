/**
 * Created by jeffli on 15-10-23.
 */
public class Rover {
    private Position position;

    public Rover(Position position) {
        this.position = position;
    }

    public void moveForward() {
        this.position = this.position.moveForward();
    }
}
