/**
 * Created by jeffli on 15-10-23.
 */
public class Position {

    private int x;
    private int y;
    private int degree;

    public Position(int x, int y, int degree) {
        this.x = x;
        this.y = y;
        this.degree = degree;
    }

    public Position moveForward() {

        int newX = this.x;
        int newY = this.y;

        if (this.degree == 90) {
            newX += 1;
        } else if(this.degree == 180) {
            newY -= 1;
        } else if(this.degree == 270) {
            newX -= 1;
        } else if(this.degree == 0) {
            newY += 1;
        }

        return new Position(newX, newY, this.getDegree());

    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getDegree() {
        return degree;
    }

    public void setDegree(int degree) {
        this.degree = degree;
    }

    public Position rotateLeft() {
        return new Position(this.x, this.y, 0);
    }
}
