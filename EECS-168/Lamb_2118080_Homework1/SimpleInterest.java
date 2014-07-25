/**
*	File Name: SimpleInterest.java 
*	Author: Samuel Lamb
*        KUID: 2118080
*	Email Address: samuei@ku.edu 
*	Homework Assignment Number: 1 
*	Description: This code calculates simple interest 
*	Last Changed: 9/12/12 
*/	
import java.util.Scanner;

public class SimpleInterest
{
	public static void main(String[] args)
	{
		//Variable:
		final double InterestRate = 0.075;
		double principle, time, interestAmount;
		
		//Keyboard inputs:
		Scanner keyboard = new Scanner (System.in);
		System.out.println("Enter the principle:");
		principle = keyboard.nextDouble();
		System.out.println("Enter the number of years:");
		time = keyboard.nextDouble();
		
		//MATH!
		interestAmount = InterestRate * principle * time;

		//Outputs the interest
		System.out.println("Simple interest is $"+interestAmount+".");
	}
}
