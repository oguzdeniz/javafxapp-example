# This is a ProGuard configuration file for a JavaFX application using Maven Shade.

# Input and output jars are specified in the pom.xml plugin configuration.
# The primary input is the JAR produced by the maven-shade-plugin.
# Library jars (JDK and JavaFX modules) are also specified in the pom.xml plugin configuration using <libs>.
# These libraries are needed for analysis but are not obfuscated or included in the output JAR by ProGuard.

# Basic ProGuard options
# -dontshrink: Do not remove unused classes, fields, and methods.
# -dontoptimize: Do not optimize the bytecode.
# We are REMOVING these to enable shrinking and optimization for better obfuscation and smaller size.
# By removing these, ProGuard will perform shrinking, optimization, and obfuscation by default.
#-dontshrink
-dontoptimize

# -dontpreverify: Often not needed for modern desktop JVMs (JDK 6+).
# -preverify: Explicitly enable preverification if VerifyError occurs.
# We are leaving this commented out as the build succeeded without it.
#-dontpreverify
#-preverify

# Suppress warnings about missing dependencies/classes.
# These can be noisy when shading and dealing with complex dependencies like JavaFX.
# Be cautious with this; warnings *can* indicate real issues in your build setup or dependencies.
# These can be noisy when shading, so keeping them for now.
-dontwarn
-ignorewarnings

# Keep application entry point
# Keeps the main application class and its main method so the JAR can be executed by 'java -jar'.
# Replace 'com.example.javafxapp.MainApp' with the actual fully qualified name of your main class.
-keep public class com.example.javafxapp.MainApp {
    public static void main(java.lang.String[]);
}

# Keep JavaFX Application lifecycle classes and methods
# Keeps any class that extends javafx.application.Application and its essential methods (constructor, start).
# Necessary for the JavaFX runtime to find and launch your application's entry point.
-keep public class * extends javafx.application.Application {
    public <init>(); # Keep the public no-arg constructor (using literal angle brackets for .pro file)
    public void start(javafx.stage.Stage);
}

# Keep FXML controllers:
# This is split into two rules to ensure both the class name AND specific members are kept.

# Rule 1: Keep the class name of all controller classes.
# This is crucial so FXMLLoader can find the controller class by name as specified in the FXML file's fx:controller attribute.
# Replace 'com.example.javafxapp.controller.*' with the actual package(s) where your FXML controllers are located.
# The wildcard '*' at the end matches all classes in that package.
-keepnames class com.example.javafxapp.controller.*

# Rule 2: Keep members of controller classes needed by FXMLLoader.
# Keeps the public no-arg constructor (used by FXMLLoader for instantiation) and any fields/methods annotated with @javafx.fxml.FXML (used for UI element injection and event handling).
-keep public class com.example.javafxapp.controller.* {
    public <init>(); # Keep the public no-arg constructor (using literal angle brackets for .pro file)
    @javafx.fxml.FXML *; # Keep all members (fields/methods) annotated with @FXML
}

# Keep any class members annotated with @FXML across the application
# This rule was uncommented as it resolved a runtime issue.
# It ensures that any member (field or method) annotated with @FXML is kept, regardless of its class location.
-keep class * { @javafx.fxml.FXML *;}


# Keep all classes that are Resource Bundles (for localization)
# Necessary if your application loads localized strings or resources using java.util.ResourceBundle.
-keep class * extends java.util.ResourceBundle { *; }


# Keep necessary internal JavaFX classes and methods potentially used via reflection
# These rules are often needed when bundling JavaFX with shade or similar tools, especially with modular JDKs.
# They help prevent ProGuard from obfuscating or removing internal classes that JavaFX uses dynamically at runtime.

# Keeping the names and members of all javafx.** classes (broad rule).
# Note: With <libs> configured in pom.xml pointing to the JavaFX JMODs, some of these might be redundant or can be refined for more aggressive obfuscation of non-essential parts of JavaFX if desired (advanced).
-keepnames class javafx.** { *; }
-keepclassmembers class javafx.** { *; }

# Keep internal com.sun.javafx classes and their members (broad rule).
# This rule helps ProGuard understand the hierarchy of internal JavaFX components during analysis.
-keepnames class com.sun.javafx.** { *; }
-keepclassmembers class com.sun.javafx.** { *; }

# Keep specific internal JavaFX implementation packages
# These rules target packages known to contain classes involved in low-level rendering, font handling,
# toolkit interactions, effects, and graphics primitives, which are often problematic for static analysis during optimization.
-keep class com.sun.javafx.font.** { *; }
-keep class com.sun.prism.** { *; }
-keep class com.sun.javafx.tk.** { *; }
-keep class com.sun.scenario.effect.** { *; }
-keep class com.sun.marlin.** { *; }


# Keep enums and their members
# Necessary if your application uses enum types.
-keep enum * { *; }
-keepclassmembers enum * { *; }


# Keep essential attributes needed by the JVM and reflection
# These attributes are crucial for runtime behavior, reflection, annotations, debugging, and other bytecode analysis tools.
-keepattributes *Annotation* # Keep all annotations (including @FXML, @Override, etc.)
-keepattributes Signature    # Keep generic type signatures (important for reflection on generic types)
-keepattributes InnerClasses # Keep information about inner and anonymous classes
-keepattributes EnclosingMethod # Keep information about enclosing methods (important for anonymous classes)
-keepattributes SourceFile,LineNumberTable # Keep source file and line number information (very useful for debugging obfuscated stack traces)


# Add any other specific keep rules needed by your application below this line.
# This is often the most iterative part - adding rules based on runtime errors or specific library requirements.
# Common scenarios requiring additional rules:
# - Classes accessed dynamically by name strings (e.g., Class.forName("..."), ServiceLoader).
# - Classes needed for serialization (java.io.Serializable).
# - Classes or methods used by third-party libraries via reflection (e.g., JSON libraries like Jackson, dependency injection frameworks).
# - Native methods (often require specific -keep rules).
# - Callback methods invoked by native code or external systems.

# Example: If you use a library 'com.mycompany.mylib' that uses reflection heavily:
#-keep class com.mycompany.mylib.** { *; }

# Consult documentation for any third-party libraries you use, as they often have ProGuard configuration requirements.
