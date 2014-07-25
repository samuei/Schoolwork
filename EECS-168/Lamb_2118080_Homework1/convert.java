/**
*	File Name: convert.java 
*	Author: Samuel Lamb
*        KUID: 2118080
*	Email Address: samuei@ku.edu 
*	Homework Assignment Number: 1 
*	Description: Converts dollars into pounds, yen, or yuan 
*	Last Changed: 9/12/12 
*/	
import java.util.Scanner;

public class convert
{
	public static void main(String[] args)
	{
		//variables
		int currencyChoice;
		double dollars, result;
		String currencyName;

		//keyboard setup
		Scanner keyboard = new Scanner (System.in);

		//Amount input and currency selection
		System.out.println("Enter the US dollar amount:");
		dollars = keyboard.nextDouble();
		System.out.println("Choose one of the following countries:");
		System.out.println("  1. England");
		System.out.println("  2. Japan");
		System.out.println("  3. China");
		currencyChoice = keyboard.nextInt();

		//currency conversion and name assignment
		switch (currencyChoice) {
			case 1:
			currencyName = "British Pounds";
			result = dollars*0.63;
			break;
			case 2:
			currencyName = "Japanese Yen";
			result = dollars*78.5;
			break;
			case 3:
			currencyName = "Chinese Yuan";
			result = dollars*6.36;
			break;
			default:
			System.out.println("You've broken my program! How dare you!");
			currencyName = "BROKEN";
			result = 0;
			break;
			}

		//output
		System.out.println(dollars+"dollars is equal to " + result +" "+ currencyName +".");
	}
}
	
