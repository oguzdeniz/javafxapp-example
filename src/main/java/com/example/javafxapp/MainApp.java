package com.example.javafxapp;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MainApp extends Application {

  @Override
  public void start(Stage primaryStage) throws Exception {
    FXMLLoader loader = new FXMLLoader(getClass().getResource("/demo1/MainWindow.fxml"));
    Parent root = loader.load();
    primaryStage.setTitle("Main Window");
    primaryStage.setScene(new Scene(root, 300, 200));
    primaryStage.show();
  }

  public static void main(String[] args) {
    launch(args);
  }
}
