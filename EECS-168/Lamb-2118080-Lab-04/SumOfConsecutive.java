/*
 *  SumOfConsecutive
 *
 *  Created by Samuel Lamb 2118080
 *  Contact Email: samuei@gmail.com
 *  Description: Gives sum of integers between two inputs
 *  Date: 9/20/12
 * 
 */

import java.util.Scanner;

public class SumOfConsecutive
{
    public static void main(String[] args)
	{
	//Declare variables
	    int first, last, output, i;

	//Get input
	System.out.println("Welcome! This program calculates the summation of consecutive integers.");
	Scanner keyboard = new Scanner (System.in);
	System.out.println();
	System.out.println("Please input a positive integer as the initial value: ");
	first = keyboard.nextInt();
	System.out.println("Please input a positive integer as the end value: ");
	last = keyboard.nextInt();
	System.out.println();

	//Doing the math
	if (first<last) {
		output = first;
		for (i=first; i < last; i++) {
			output += output;
			};
		}
	else if (last>first) {
		output = last;
		for (i=last; i <first; i++) {
			output+= output;
			};
		}
	else {
		output = first;
		};

	//Output
	System.out.println("The summation is: "+output);
	}
}
