/**	File Name: Age.java
*	Author: Samuel Lamb
*        KUID: 2118080
*	Email Address: samuei@ku.edu 
*	Homework Assignment Number: Lab 3
*	Description: Defines categories based on age
*	Last Changed: 9/8/12
*/

import java.util.Scanner;
public class Age
{

	public static void main(String[] args)
	{
	//Declaring the age and age token for later
	    String ageToken;
	    double age;

	//Setting up the keyboard and asking for an input
	Scanner keyboard = new Scanner(System.in);
	System.out.println("Enter your age:");

	//Storing that input
	age = keyboard.nextDouble();

	//Using the age input to determine the age token
	if (age>=65) {
	    ageToken = "senior citizen";
		}
	else {if (age>=20) {
	    ageToken = "adult";
		}
	    else {if (age>=13) {
	    ageToken = "teenager";
		}
		else {if (age>3) {
	    ageToken = "child";
		}
		    else {if (age>1) {
	    ageToken = "toddler";
		}
	else {
	    ageToken = "baby";
	};};};};};

	//Returning the person's age category via the age token
	System.out.println("You are a "+ageToken+".");
	}
}
