package com.yroo.rover;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class RoverTest {
    private Rover rover;

    @Before
    public void setUp() {
        rover = new Rover("N", 12, 3);
    }

    @Test
    public void moveFacingNorth() {
        rover.move();
        assertEquals("should move up the y-axis", 4, rover.getY());
    }

    @Test
    public void moveFacingEast() {
        rover.setDirection("E");
        rover.move();
        assertEquals("should move up the x-axis", 13, rover.getX());
    }

    @Test
    public void moveFacingSouth() {
        rover.setDirection("S");
        rover.move();
        assertEquals("should move up the y-axis", 2, rover.getY());
    }

    @Test
    public void moveFacingWest() {
        rover.setDirection("W");
        rover.move();
        assertEquals("should move up the x-axis", 11, rover.getX());
    }

    @Test
     public void turnLeftFromNorth() {
        rover.turnLeft();
        assertEquals("should turn left", "W", rover.getDirection());
    }

    @Test
     public void turnLeftFromEast() {
        rover.setDirection("E");
        rover.turnLeft();
        assertEquals("should turn left", "N", rover.getDirection());
    }

    @Test
     public void turnLeftFromSouth() {
        rover.setDirection("S");
        rover.turnLeft();
        assertEquals("should turn left", "E", rover.getDirection());
    }

    @Test
    public void turnLeftFromWest() {
        rover.setDirection("W");
        rover.turnLeft();
        assertEquals("should turn left", "S", rover.getDirection());
    }
}