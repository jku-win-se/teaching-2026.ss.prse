package at.jku.se.model;

/**
 * A simple click counter.
 */
public class Counter {

    private int count;

    public Counter() {
        this.count = 0;
    }

    public int getCount() {
        return count;
    }

    public void increment() {
        count++;
    }

    public void reset() {
        count = 0;
    }

    @Override
    public String toString() {
        return String.valueOf(count);
    }
}