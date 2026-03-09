package at.jku.se;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

/**
 * Click Counter — Setup Verification App.
 */
public class App extends Application {

    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(
                App.class.getResource("main-view.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 350, 300);
        stage.setTitle("SE-Praktikum Setup Verification");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}