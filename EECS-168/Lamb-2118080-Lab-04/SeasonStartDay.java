/*
 *  SeasonStartDay
 *
 *  Created by Samuel Lamb 2118080
 *  Contact Email: samuei@ku.edu
 *  Description: Tells you what day seasons start this year
 *  Date: 9/20/12
 * 
 */
import java.util.Scanner;
public class SeasonStartDay {

	public static void main(String[] args) {
		//Create variables
		int season;
		season = -5;
		Scanner keyboard = new Scanner(System.in);
		
		//Get input
		do {
			System.out.println("Enter 0 for Spring");
			System.out.println("Enter 1 for Summer");
			System.out.println("Enter 2 for Fall");
			System.out.println("Enter 3 for Winter");
			System.out.println();
			System.out.println("*Enter the season:");
			season = keyboard.nextInt();
			System.out.println("---------------------");
			System.out.println();
		}
		while (season<0 || season>3);
		
		//Give output
		if (season == 0) {
			System.out.println("The start of Spring will be Tuesday, March 20, 2012.");
		}
		else if (season == 1) {
			System.out.println("The start of Summer will be Wednesday, June 20, 2012.");
		}
		else if (season == 2) {
			System.out.println("The start of Fall will be Saturday, September 22, 2012.");
		}
		else if (season == 3) {
			System.out.println("The start of Winter will be Friday, December 21, 2012.");
		}
		else {
			System.out.println("Error: Season not found.");
			System.out.println("This shouldn't be possible!");
			System.out.println("Please email samuei@ku.edu and tell me how you did that.");
		}
	}

}
