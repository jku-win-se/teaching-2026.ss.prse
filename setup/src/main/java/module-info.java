module at.jku.se {
    requires javafx.controls;
    requires javafx.fxml;

    opens at.jku.se to javafx.fxml;
    opens at.jku.se.controller to javafx.fxml;

    exports at.jku.se;
    exports at.jku.se.model;
    exports at.jku.se.controller;
}