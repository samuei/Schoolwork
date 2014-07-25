/*
 *  OddSum
 *
 *  Created by Samuel Lamb 2118080
 *  Contact Email: samuei@gmail.com
 *  Description: Computes sum of odd integers
 *  Date: 9/20/12
 * 
 */

import java.util.Scanner;

public class OddSum
{
    public static void main(String[] args)
	{
	//Declaring variables
	int input, count, output;
	output = 1;
	count = 1;
	
	//Getting input
	System.out.println("Please input a positive integer:");
	Scanner keyboard = new Scanner (System.in);
	input = keyboard.nextInt();

	//Calculating output
	while (count < input) {
		count += 2;
		output += count;
		}

	//Output
	System.out.println("The summation is: "+output);
	}
}
