/* -----------------------------------------------------------------------------
 *
 * File Name:  AsciiArt.java
 * Author: Samuel Lamb samuei@ku.edu
 * KUID: 2118080
 * Assignment:   EECS-168 Homework 2
 * Description:  This program will create a plane of asterisks depending on user input.
 * Date: date the program was last modified
 * ---------------------------------------------------------------------------- */

import java.util.Scanner;

public class AsciiArt {
	public static void main(String[] args) {
		// Here are my variables and keyboard input
		int selection, loop;
		Scanner kb = new Scanner(System.in);

		// Here's the user selection menu
		System.out.println("Choose one of the following patterns by typing the corresponding number:");
		System.out.println("1) 5x5 Grid");
		System.out.println("2) Checker Board");
		System.out.println("3) Reverse Diagonal");
		selection = kb.nextInt();
		
		// Now that we've got the input, here comes the if-else loop, starting with 1.
		// For each if statement, a for loop will be started to generate the selected image.
		if (selection == 1) {
			for (loop=0;loop<5;loop++) {
				System.out.println(loop + " * * * * *");
				};
			}
		else if (selection == 2) {
			for (loop=0;loop<5;loop++) {
				if (loop % 2 == 0) {
					System.out.println(loop + " *   *   *");
					}
				else {
					System.out.println(loop + "   *   *");
					};
				};
			}
		else if (selection == 3) {
			for (loop=0;loop<5;loop++) {
				System.out.print(loop + " ");
				if (loop == 0) {
					System.out.println("        *");
					}
				else if (loop == 1) {
					System.out.println("      *");
					}
				else if (loop == 2) {
					System.out.println("    *");
					}
				else if (loop == 3) {
					System.out.println("  *");
					}
				else {
					System.out.println("*");
					};
				}
		}
		else {
			System.out.println("That is not one of the options I gave you.");
			System.out.println("Please reload and try again.");
			};
		};
	}
