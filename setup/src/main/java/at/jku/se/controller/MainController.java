package at.jku.se.controller;

import at.jku.se.model.Counter;
import javafx.fxml.FXML;
import javafx.scene.control.Label;

/**
 * Controller for the Counter view.
 */
public class MainController {

    @FXML private Label countLabel;

    private final Counter counter = new Counter();

    @FXML
    public void initialize() {
        countLabel.setText(counter.toString());
    }

    @FXML
    private void onIncrement() {
        counter.increment();
        countLabel.setText(counter.toString());
    }

    @FXML
    private void onReset() {
        counter.reset();
        countLabel.setText(counter.toString());
    }
}