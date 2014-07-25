/* -----------------------------------------------------------------------------
 *
 * File Name:  ServiceCharge.java
 * Author: Samuel A. Lamb
 * 	Email: samuei@ku.edu
 *	KU ID: 2118080
 * Assignment:   EECS-168 Lab 2
 * Description:  Assesses service charges for cashing checks
 * Date: 9/12/12
 *
 ---------------------------------------------------------------------------- */

import java.util.Scanner;

public class ServiceCharge
{
	public static void main(String[] Args)
	{
	//variable declaration
	double check, charge;	

	//user input
	Scanner keyboard = new Scanner(System.in);
	System.out.println("How much was that check for?");
	check = keyboard.nextDouble();
	System.out.println("Oh, boy.");

	//math
	if (check>0 && check<=10) {
		charge = 1;
		}
	else if (check<=100) {
		charge = check*0.10;
		}
	    else if (check<=1000) {
		charge = 5+(check*0.05);
		}
	else {
		charge = 40+(check*0.01);
	};

	//output
	System.out.println("Your service charge will be $"+charge+".");
	}
}
