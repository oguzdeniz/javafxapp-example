# This is a ProGuard configuration file.

# Specify the version of ProGuard to be used by the plugin
# This setting is within the pom.xml now, but good to remember

# Input and output jars are specified in the pom.xml plugin config.

# Basic ProGuard options
-dontshrink    # Do not shrink the code
-dontoptimize  # Do not optimize the code

# Suppress warnings about missing dependencies/classes.
# Be cautious with this; warnings might indicate real issues.
-dontwarn
-ignorewarnings

# Keep application entry point
# Replace com.example.javafxapp with your actual package if different
-keep public class com.example.javafxapp.MainApp {
    public static void main(java.lang.String[]);
}

-keep class com.example.javafxapp.controllers.MainWindowController {
    public void handleButton2Action(...); # Use actual parameters if any, otherwise just '();' for no args
    *; # Keep all members in this class as a broader test
}

# Keep JavaFX Application lifecycle classes and methods
-keep public class * extends javafx.application.Application {
    public <init>();
    public void start(javafx.stage.Stage);
}

# Keep FXML controllers and their members
# Adjust 'com.example.javafxapp.controller.*' to your controller package(s)
-keepclasseswithmembers public class com.example.javafxapp.controller.* {
    @javafx.fxml.FXML *;
    public *; # Keep all public members in controllers
}

# Keep any class members annotated with @FXML across the application
-keep class * {
    @javafx.fxml.FXML *;
}

# Keep all classes that are resource bundles (for localization)
-keep class * extends java.util.ResourceBundle { *; }

# Keep necessary JavaFX classes and methods potentially used via reflection
# These rules are broad and might need to be refined if they cause issues or don't keep enough
-keepnames class javafx.** { *; } # Keep names of JavaFX classes themselves
-keepclassmembers class javafx.** { *; } # Keep members (fields, methods) of JavaFX classes

# Keep enums and their members
-keep enum * { *; }
-keepclassmembers enum * { *; }

# Keep essential attributes needed by the JVM and reflection
-keepattributes *Annotation* # Keep all annotations
-keepattributes Signature    # Keep generic type signatures
-keepattributes InnerClasses # Keep information about inner classes
-keepattributes EnclosingMethod # Keep information about enclosing methods (for anonymous classes etc.)

# Add any other specific keep rules needed by your application below this line
# For example, rules for third-party libraries that use reflection
# -keep class com.mycompany.mylib.** { *; }
