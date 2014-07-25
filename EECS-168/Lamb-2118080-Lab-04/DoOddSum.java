/*
 *  DoOddSum
 *
 *  Created by Samuel Lamb 2118080
 *  Contact Email: samuei@gmail.com
 *  Description: Computes sum of odd integers
 *  Date: 9/20/12
 * 
 */

import java.util.Scanner;

public class DoOddSum
{
    public static void main(String[] args)
	{
	//Declaring variables
	int input, count, output;
	output = 0;
	count = 1;
	
	//Getting input
	System.out.println("Please input a positive integer:");
	Scanner keyboard = new Scanner (System.in);
	input = keyboard.nextInt();

	//Calculating output
	do {
		output += count;
		count += 2;
		}
	while (count <= input);

	//Output
	System.out.println("The summation is: "+output);
	}
}
