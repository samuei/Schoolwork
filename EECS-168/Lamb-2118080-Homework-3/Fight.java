/*	File Name: Fight.java
*	Author: Samuel Lamb 
*        KUID: 2118080
*	Email Address: samuei@ku.edu 
*	Homework Assignment Number: Homework #3
*	Description:  Creates two fighters and pits them in mortal combat for your amusement.
*	Last Changed: 10/19/12 
*/

import java.util.Scanner;
import java.util.Random;

public class Fight {
	public static void main (String[] args) {
		int i;
		Random random = new Random();
		double initiative = random.nextDouble();
		Fighter fighter1 = new Fighter();
		Fighter fighter2 = new Fighter();

		// The initiative modifier determines who goes first. Rather than assigning each fighter a separate
		// score and comparing, I decided to simply have one random number that decides who will fight first
		// before the player has even named them.
		if (initiative >= 0.5) {
			fighter1.input();
			fighter2.input();
			}
		else {
			fighter2.input();
			fighter1.input();
			};
		System.out.println();
		System.out.println(fighter1.name+" will attack first.");

		// Now begins the actual fight. The loop iterates until there is a victor or the 10th round.
		for (i=0; i<10;i++) {
			System.out.println("ROUND "+(i+1));
			
			// Here is the victory check. It should print the attack, and break the loop on victory.
			if (fighter1.attack(fighter2)) {
				i=50;
				continue;
				}
			else if (fighter2.attack(fighter1)) {
				i=50;
				continue;
				};
			};
		if (i<=30) {
		    System.out.println("These two went 10 rounds! We have a tie.");
		};
	}
}
