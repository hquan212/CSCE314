
/*-- Assignment 4, CSCE-314
-- Section: 500
-- Student Name: Robert Quan
-- JavaFX Basics*/

package controlcircle;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Stage;
import javafx.scene.layout.Pane;

/**
 *
 * @author rquan
 * This program tests the functions and 
 * demos the uses of JavaFx
 * NOTE must have JavaFX files to run,
 * I used Netbeans
 */
public class ControlCircle extends Application {
    private CirclePane circlePane1 = new CirclePane();	//Create two CirclePanes
    private CirclePane circlePane2 = new CirclePane();
    
    @Override
    public void start(Stage primaryStage) {
        
        HBox hBox = new HBox();
        hBox.setSpacing(100);
        hBox.setAlignment(Pos.CENTER);
        Button btEnlarge = new Button("First");
        Button btShrink = new Button("Second");
        hBox.getChildren().add(btEnlarge);
        hBox.getChildren().add(btShrink);
        
        btEnlarge.setOnAction(new EnglargeHandler());
        btShrink.setOnAction(new ShrinkHandler());
        
        BorderPane borderPane = new BorderPane();
        borderPane.setLeft(circlePane1);
        borderPane.setRight(circlePane2);
        borderPane.setBottom(hBox);
        BorderPane.setAlignment(hBox, Pos.CENTER);
        
        Scene scene = new Scene(borderPane,300,250);
        primaryStage.setTitle("ControlCircle"); // Set the stage title
        primaryStage.setScene(scene); // Place the scene in the stage
        primaryStage.show(); // Display the stage
     
        
    }
    
    
    class EnglargeHandler implements EventHandler<ActionEvent> {
        @Override
        public void handle(ActionEvent e) {
            circlePane1.enlarge();
            circlePane2.shrink();
        }
    }
    
    class ShrinkHandler implements EventHandler<ActionEvent> {
        @Override
        public void handle(ActionEvent e) {
            circlePane1.shrink();
            circlePane2.enlarge();
        }
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}

class CirclePane extends StackPane{
    private Circle circle = new Circle(50);
    

    
    public CirclePane(){
        getChildren().add(circle);
        circle.setStroke(Color.BLACK);
        circle.setFill(Color.WHITE);
    }
    
    public void enlarge(){
        circle.setRadius(circle.getRadius()+(0.1*circle.getRadius()*Math.random()));
        circle.setFill(Color.color(Math.random(), Math.random(), Math.random()));
    }
    
    public void shrink(){
        circle.setRadius(circle.getRadius()> 2 ? 
        circle.getRadius()-(0.1*circle.getRadius()*Math.random()) : circle.getRadius());
        circle.setFill(Color.color(Math.random(), Math.random(), Math.random()));
    }
}

