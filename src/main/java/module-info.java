module com.example.javafxapp {
  requires javafx.controls;
  requires javafx.fxml;

  opens com.example.javafxapp to javafx.fxml;
  exports com.example.javafxapp;
  exports com.example.javafxapp.controllers;
  opens com.example.javafxapp.controllers to javafx.fxml;
  exports com.example.javafxapp.controllers.newControllers;
  opens com.example.javafxapp.controllers.newControllers to javafx.fxml;
}
