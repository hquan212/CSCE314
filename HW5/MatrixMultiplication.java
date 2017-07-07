
/* Assignment 5, CSCE-314
-- Section: 500
-- Student Name: Robert Quan
-- UIN: 622005281
-- */

/**
 *
 * @author rquan
 */

public class MatrixMultiplication {

	static double[][] a = new double[2000][2000];
	static double[][] b = new double[2000][2000];
	static double[][] c = new double[2000][2000];

    public static class Thread1 extends Thread {

        @Override
        public void run() {
            int m = a.length;
            int n = b[0].length;
            int k = (a.length) / 4;

            for (int i = 0; i <= k; i++) {
                for (int j = 0; j < n; j++) {
                    for (int l = 0; l < b.length; l++) {
                        c[i][j] = c[i][j] + a[i][l] * b[l][j];
                    }
                }
            }
        }
    }

    public static class Thread2 extends Thread {

        @Override
        public void run() {
            int m = a.length;
            int n = b[0].length;
            int k = (a.length) / 2+1;
            int s = ((a.length) /4)+1;

            for (int i = s ; i < k; i++) {
                for (int j = 0; j < n; j++) {
                    for (int l = 0; l < b.length; l++) {
                        c[i][j] = c[i][j] + a[i][l] * b[l][j];
                    }
                }
            }
        }
    }
     public static class Thread3 extends Thread {

        @Override
        public void run() {
            int m = a.length;
            int n = b[0].length;
            int k = ((3*(a.length))/4)+ 1;
            int s = (a.length) / 2 + 1;

            for (int i = s ; i < k; i++) {
                for (int j = 0; j < n; j++) {
                    for (int l = 0; l < b.length; l++) {
                        c[i][j] = c[i][j] + a[i][l] * b[l][j];
                    }
                }
            }
        }
    }
      public static class Thread4 extends Thread {

        @Override
        public void run() {
            int m = a.length;
            int n = b[0].length;
            int k = ((3*(a.length))/4)+ 1;

            for (int i = k ; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    for (int l = 0; l < b.length; l++) {
                        c[i][j] = c[i][j] + a[i][l] * b[l][j];
                    }
                }
            }
        }
    }
 
      
      public static void SingleMM() {       //Single thread time
          
            for (int i = 0 ; i < a.length; i++) {
                for (int j = 0; j < a[0].length; j++) {
                    for (int l = 0; l < a[0].length; l++) {
                        c[i][j] = a[i][l] * b[l][j];
                    }
                }
            }
          
      }
      
        public static void displayMatrix(double[][] c) throws Exception {
            int rows = c.length;
            int cols = c[0].length;
           System.out.println("rows   " + rows + "      columns     " + cols);

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                System.out.print(c[i][j] + "    ");

            }
            System.out.println();
        }


    }

	public static void main(String[] args) throws InterruptedException, Exception {

	for (int i = 0; i < a.length; i++){
      		for(int j = 0; j < a[0].length; j++){
        		a[i][j] = 1;
			b[i][j] = 2;
      		}
    	}



	    	long startTime = System.currentTimeMillis();
    		Thread1 m1 = new Thread1();
        	Thread2 m2 = new Thread2();
        	Thread3 m3 = new Thread3();
        	Thread4 m4 = new Thread4();
        	m1.start();
        	m2.start();
        	m3.start();
        	m4.start();
                
        	m1.join();
        	m2.join();
        	m3.join();
        	m4.join();
    		long endTime = System.currentTimeMillis();	
	
      System.out.println("\nParallel time with "
      + Runtime.getRuntime().availableProcessors() + 
      " processors is " + (endTime - startTime) + " milliseconds");
	
        
       //displayMatrix(c);
       
      startTime = System.currentTimeMillis();
        SingleMM(); 
        endTime = System.currentTimeMillis();
        System.out.println("\nSequential time is " +
      (endTime - startTime) + " milliseconds");
       
        }
}


