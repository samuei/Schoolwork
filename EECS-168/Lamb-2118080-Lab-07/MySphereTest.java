/* -----------------------------------------------------------------------------
 *
 * File Name:  MySphereTest.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program tests the MySphere class.
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;

public class MySphereTest {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MySphere myBall = new  MySphere();
		int loop;
		loop = 1;
		while (loop > 0) {
		    System.out.println("Enter the diameter of the ball:");
	 	    Scanner kb = new Scanner (System.in);
    		    myBall.setDiameter (kb.nextDouble());
                    System.out.println("The diameter of the ball is " + myBall.getDiameter() );
                    double ballVolume = myBall.calculateVolume() ;
                    double ballSurface = myBall.calculateSurfaceArea() ;
        
                    System.out.printf("The volume is  %7.2f\n", ballVolume);
                    System.out.printf("The surface area is %7.2f\n", ballSurface);
		    System.out.println("Do you want to try another ball?");
		    System.out.println("Please enter 1 for Yes, 0 for No:");
		    loop = kb.nextInt();
		    }
		System.out.println("Goodbye!");
	}

}
