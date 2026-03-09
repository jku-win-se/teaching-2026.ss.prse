package at.jku.se.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for {@link Counter}.
 */
class CounterTest {

    private Counter counter;

    @BeforeEach
    void setUp() {
        counter = new Counter();
    }

    @Test
    @DisplayName("should start at zero")
    void startsAtZero() {
        assertEquals(0, counter.getCount());
    }

    @Test
    @DisplayName("should increment by one")
    void incrementByOne() {
        counter.increment();
        assertEquals(1, counter.getCount());
    }

    @Test
    @DisplayName("should increment multiple times")
    void incrementMultiple() {
        counter.increment();
        counter.increment();
        counter.increment();
        assertEquals(3, counter.getCount());
    }

    @Test
    @DisplayName("should reset to zero")
    void resetToZero() {
        counter.increment();
        counter.increment();
        counter.reset();
        assertEquals(0, counter.getCount());
    }

    @Test
    @DisplayName("should reset when already zero")
    void resetFromZero() {
        counter.reset();
        assertEquals(0, counter.getCount());
    }

    @Test
    @DisplayName("should increment after reset")
    void incrementAfterReset() {
        counter.increment();
        counter.reset();
        counter.increment();
        assertEquals(1, counter.getCount());
    }

    @Test
    @DisplayName("toString should return count as string")
    void toStringReturnsCount() {
        assertEquals("0", counter.toString());
        counter.increment();
        assertEquals("1", counter.toString());
    }
}