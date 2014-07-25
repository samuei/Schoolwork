/*	File Name: Fighter.java
*	Author: Samuel Lamb 
*        KUID: 2118080
*	Email Address: samuei@ku.edu 
*	Homework Assignment Number: Homework #3 
*	Description: Defines the Fighter class for use in Fight.java 
*	Last Changed: 10/19/12
*/

import java.util.Scanner;
import java.util.Random;

public class Fighter {
	public String name;
	private int blood_points;
	private int defense_level;
	private int attack_level;
	
	// Input is the constructor method, doing all the work of defining a new Fighter object
	public void input() {
		
		// I decided to preset these values for looping purposes
		defense_level = 100;
		attack_level = 100;
		Scanner kb = new Scanner (System.in);
		System.out.println("Please give a name for fighter:");
		name = kb.next();
		System.out.println("How many blood points does "+name+" have?");
		blood_points = kb.nextInt();

		// This loop validates the blood points input
		while (blood_points > 50) {
			System.out.println("Blood points should be less than or equal to 50. Please re-enter:");
			blood_points = kb.nextInt();
			};

		// This loop asks for the attack/defense levels, and the sub-loops validate the inputs
		while (defense_level+attack_level > 50) {
			System.out.println("What is "+name+"'s defense level?");
			defense_level = kb.nextInt();
			while (defense_level < 1) {
				System.out.println("Defense level should be greater than or equal to 1. Please re-enter:");
				defense_level = kb.nextInt();
				}
			System.out.println("What is "+name+"'s attack level?");
			attack_level = kb.nextInt();
			while (attack_level < 1) {
				System.out.println("Attack level should be greater than or equal to 1. Please re-enter:");
				attack_level = kb.nextInt();
				}
			if (defense_level+attack_level>50) {
				System.out.println("Attack and defense should add up to less than 50.");
				System.out.println("It's just not fair, otherwise.");
				};
			};
		};

	// Attack performs an attack, and reports to the caller whether the opponent was defeated
	public boolean attack(Fighter opponent) {
		Random randomNum = new Random();
		double hitroll=randomNum.nextDouble();

		// The hitroll variable determines whether the attack connects or misses vs the opponent's defense
		if (hitroll>(10/opponent.defense_level)) {
			System.out.println(name+" attacks "+opponent.name+" but misses. "+opponent.name+" has "+opponent.blood_points+" blood points left.");
			return false;
			}
		
		//If it connects, the damroll variable determines how much damage it did
		else {
			double damroll = randomNum.nextDouble()*attack_level;
			if (damroll%1>0) {
				damroll+=1;
				};
			opponent.blood_points-=(int)damroll;
			
			// This section checks to see if that damage is enough to defeat the opponent
			if (opponent.blood_points > 0) {
			    System.out.println(name+" hits "+opponent.name+". "+opponent.name+" loses "+(int)damroll+" blood points, and has "+opponent.blood_points+" left.");
				return false;
				}
			else {
				System.out.println(name+" hits "+opponent.name+". "+opponent.name+" loses "+(int)damroll+" blood points. "+opponent.name+" is defeated!");
				return true;
				}
		}
	}
}
