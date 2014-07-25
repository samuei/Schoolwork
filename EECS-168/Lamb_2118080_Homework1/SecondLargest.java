/* -----------------------------------------------------------------------------
 *
 * File Name: SecondLargest.java
 * Author: Samuel Lamb
 * 	KU ID: 2118080
 * Assignment:   EECS-168 Homework 1
 * Description: Finds the second-largest number from user inputs 
 * Date: 9/11/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class SecondLargest
{
	public static void main(String[] args)
	{
		//Variables
		int first, second, third, result;

		//User input
		Scanner keyboard = new Scanner(System.in);
		System.out.println("Alright, give me a number:");
		first = keyboard.nextInt();
		System.out.println("Good. Now another:");
		second = keyboard.nextInt();
		System.out.println("Excellent. Last one:");
		third = keyboard.nextInt();
		System.out.println("Thanks. Now, let me blow your mind!");

		//Picking the right one
		if (first>=second && second>=third) {
			result = second;
			}
		else if (first>=third && third>=second) {
			result = third;
			}
		else if (second>=first && first>=third) {
			result = first;
			}
		else if (second>=third && third>=first) {
			result = third;
			}
		else if (third>=first && first>=second) {
			result = first;
			}
		else if (third>=second && second>=first) {
			result = second;
			}
		else {
		    result = 0;
		}

		//Output
		System.out.println("The second-largest of those numbers?");
		    System.out.println("That would be "+result+".");
	}
}
