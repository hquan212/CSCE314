/*
 * Robert Quan
 * HW5 CSCE 314
 * 622005281
 */
package gameshow;

import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author rquan
 */
public class GameShow {
    
        private static int score = 0;
        public static String answer;
    
    public static void main(String[] args) throws InterruptedException, Exception {
        // TODO code application logic here
        
        
        printQuestion m1 = new printQuestion();
        reader_Thread m2 = new reader_Thread();
        Timer_Thread m3 = new Timer_Thread();
        
        m1.start();
        m2.start();
        m2.join();
        
        m1.start();
        m2.start();
        
        m3.start();
        
        m1.join();
        m2.join();
        m3.join();

    }

    
    public static class Game{
        
        

    
        public static int getScore(){
            return score;
        }

        public static void setScore(int in) {
            score = in;
        }
    }

    public static class printQuestion extends Thread {

        @Override
        public void run() {

        Scanner reader = new Scanner(System.in);
        
        System.out.println("Welcome to the Game Show!");   
        System.out.println("Answer Question Number 1:");   
        System.out.println("What is the Capitol of France?");
        
        answer = reader.nextLine();
         
        System.out.println("Answer Question Number 2:");   
        System.out.println("What color is the sky?");
        
        answer = reader.nextLine();
        
        System.out.println("Answer Question Number 3:");   
        System.out.println("How old am I?");
        
        answer = reader.nextLine();
        
        }
    }
    
    public static class reader_Thread extends Thread {

        @Override
        public void run() {
            switch(answer){
                case "Paris" : 
                case "blue":
                    System.out.println("You are right!");
                    break;
                case "23":
                    System.out.println("You win");
                    break;
                default :
                    System.out.println("Wrong!");
                    
            }
        }
    }
        
        public static class Timer_Thread extends Thread {

        @Override
        public void run() {
            try {
                Thread.sleep(10000);
                System.out.println("TIMEOUT");
            } catch (InterruptedException ex) {
                Logger.getLogger(GameShow.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
        
}

