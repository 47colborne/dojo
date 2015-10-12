/**
 * Created by jeffli on 15-10-09.
 */

enum Direction {
    NORTH(0), EAST(90), SOUTH(180), WEST(270);

    int degree;
    Direction(int d) {
        degree = d;
    }
    int showDegree() {
        return degree;
    }
}

public class Rover {
    private int x;
    private int y;
    private int degree;


    public Rover(int x, int y, int degree) {
        this.x = x;
        this.y = y;
        this.degree = degree;
    }

    public Rover(int x, int y, Direction direction) {
        this.x = x;
        this.y = y;
        this.degree = direction.showDegree();
    }

    public void move() {
        if (degree == Direction.EAST.showDegree()) {
            x += 1;
        }
        else if (degree == Direction.SOUTH.showDegree()) {
            y -= 1;
        }
        else if (degree == Direction.WEST.showDegree()) {
            x -= 1;
        }
        else {
            y += 1;
        }
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int getDegree() {
        return degree;
    }

    public void turn(int degrees) {
        int turned_degrees = degrees % 360;
        if (degrees < 0) {
            turned_degrees += 360;
        }
        this.degree += turned_degrees;
    }
}
