/* -----------------------------------------------------------------------------
 *
 * File Name:  CubeString.java
 * Author: Samuel Lamb samuei@ku.edu
 * KUID: 2118080
 * Assignment:   EECS-168 Homework 2
 * Description:  This program will create a plane of asterisks depending on user input.
 * Date: 10/4/2012
 * ---------------------------------------------------------------------------- */

import java.util.Scanner;

public class CubeString {
	public static void main(String[] args) {
	    // Here are my variables and keyboard input
	    int loop, loop2, loop3;
	    Scanner kb = new Scanner(System.in);
	    
	    // Get input string from user
	    System.out.println("Enter a string:");
	    String word = new String(kb.next());
	    System.out.println();

	    // Now comes the fun part.
	    // The loop iterates string.length times, prints the string from
	    // its line number to the end, then prints from the beginning to
	    // its line number. Vertical sync is automatic.
	    for (loop=0;loop<word.length();loop++) {
	        for (loop2=loop;loop2<word.length();loop2++) {
		    System.out.print(word.charAt(loop2)+" ");
		};
		for (loop3=0;loop3<loop;loop3++) {
		    System.out.print(word.charAt(loop3)+" ");
		};
	        System.out.println();
		// emacs keeps messing with my indentation, so if this part
	        // is indented funny, it wasn't me. Sorry.
				 }
	}
}
