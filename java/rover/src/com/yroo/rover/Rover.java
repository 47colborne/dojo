package com.yroo.rover;

import java.util.HashMap;
import java.util.Map;

public class Rover {
    private static final Map<String, Integer> DIRECTION_TO_DEGREES = new HashMap<String, Integer>();
    private static final Map<Integer, String> DEGREES_TO_DIRECTION = new HashMap<Integer, String>();

    static {
        createDirectionMapping();
        createDegreeMapping();
    }

    private static void createDirectionMapping() {
        DIRECTION_TO_DEGREES.put("N", 0);
        DIRECTION_TO_DEGREES.put("E", 90);
        DIRECTION_TO_DEGREES.put("S", 180);
        DIRECTION_TO_DEGREES.put("W", 270);
    }

    private static void createDegreeMapping() {
        DEGREES_TO_DIRECTION.put(0, "N");
        DEGREES_TO_DIRECTION.put(90, "E");
        DEGREES_TO_DIRECTION.put(180, "S");
        DEGREES_TO_DIRECTION.put(270, "W");
    }

    private int degrees;
    private int x;
    private int y;

    public Rover(String direction, int x, int y) {
        this.degrees = DIRECTION_TO_DEGREES.get(direction);
        this.x = x;
        this.y = y;
    }

    public String getDirection() {
        return DEGREES_TO_DIRECTION.get(degrees);
    }

    public void setDirection(String direction) {
        this.degrees = DIRECTION_TO_DEGREES.get(direction);
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public void move() {
        if (getDirection().equals("E")) {
            this.x += 1;
        } else if (getDirection().equals("S")) {
            this.y -= 1;
        } else if (getDirection().equals("W")) {
            this.x -= 1;
        } else if (getDirection().equals("N")) {
            this.y += 1;
        }
    }

    public void turnLeft() {
        degrees -= 90;
        if (degrees < 0) degrees += 360;
    }
}
