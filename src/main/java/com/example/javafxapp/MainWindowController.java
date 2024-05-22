package com.example.javafxapp;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.fxml.FXMLLoader;

import java.io.IOException;

public class MainWindowController {

  @FXML
  private Button button1;

  @FXML
  private Label messageLabel;

  @FXML
  private Button button2;

  @FXML
  private void handleButton1Action() {
    messageLabel.setText("Button clicked!");
  }

  @FXML
  private void handleButton2Action() {
    try {
      FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/demo2/NewWindow.fxml"));
      Parent root = fxmlLoader.load();
      Stage newStage = new Stage();
      newStage.setTitle("New Window");
      newStage.setScene(new Scene(root, 200, 100));
      newStage.show();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  @FXML
  private void handleButton3Action() {
    try {
      FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/demo3/Newest.fxml"));
      Parent root = fxmlLoader.load();
      Stage newStage = new Stage();
      newStage.setTitle("Newest");
      newStage.setScene(new Scene(root, 200, 100));
      newStage.show();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

}
