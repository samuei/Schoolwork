/* -----------------------------------------------------------------------------
 *
 * File Name: LoneSum.java
 * Author: Samuel Lamb
 * 	KU ID: 2118080
 * Assignment:   EECS-168 Homework 1
 * Description: Finds the sum from user inputs, minus duplicates 
 * Date: 9/11/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class LoneSum
//Aw, LoneSum, I'll be your friend. Eh? Eh? Get it? No? Alright, then.
{
	public static void main(String[] args)
	{
		//Variables (names specified on the wiki. You can't count off
		//for following instructions!)
	    int a, b, c, sum;

		//Getting input from user
		Scanner keyboard = new Scanner(System.in);
		System.out.println("Hey, give me a number.");
		a = keyboard.nextInt();
		System.out.println("Good, good. Now another.");
		b = keyboard.nextInt();
		System.out.println("Thanks. One more for the road?");
		c = keyboard.nextInt();

		//Doing the math
		if (a!=b && b!=c && a!=c) {
			sum = a+b+c;
			}
		else if (a!=b && b==c) {
			sum = a;
			}
		else if (a==b && b!=c) {
			sum = c;
			}
		else if (a==c && a!=b) {
			sum = b;
			}
		else {
			sum = 0;
			}

		//Output
		System.out.println("The sum, minus repeats, is "+sum+".");
	}
}
