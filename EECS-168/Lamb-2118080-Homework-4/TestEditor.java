/* -----------------------------------------------------------------------------
 *
 * File Name: TestEditor.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Homework 4
 * Description:  This program allows users to modify strings in various ways
 * Date: 11/10/12
 *
 ---------------------------------------------------------------------------- */

import java.util.Scanner;

public class TestEditor{
	public static void main(String[] args) {
	
	// variable declarations
	Scanner kb = new Scanner(System.in);
	int selection = 0;
	int start, end;
	String dummy;
	LineEditor text = new LineEditor();

	// Asks for the initial string
	System.out.println("+++++++ LineEditor starts... +++++++");
	System.out.println();
	System.out.println("* Write the text you want (maximum length: 100):");

	// Initial string length check
	dummy = new String(kb.next());
	while (dummy.length() > 100) {
		System.out.println("* Operation failed: You exceeded the maximum length.");
		System.out.println("* Write the text you want (maximum length: 100):");
		dummy = kb.next();
		};

	// Sets the initial string
	text.set_text(dummy);

	// Menu interface
	do {
		System.out.println();
		System.out.println("--------------------------------------");
		System.out.println();
		System.out.println("* Choose the menu:");
		System.out.println("1. Insert");
		System.out.println("2. Delete");
		System.out.println("3. Replace");
		System.out.println("4. Quit");
		selection = kb.nextInt(); 

		// Menu sanity check
		while (selection > 4 || selection < 0) {
			System.out.println("Was that one of the options? NO!");
			System.out.println();
			System.out.println("--------------------------------------");
			System.out.println();
			System.out.println("* Choose the menu:");
			System.out.println("1. Insert");
			System.out.println("2. Delete");
			System.out.println("3. Replace");
			System.out.println("4. Quit");
			selection = kb.nextInt();
			};
		
		// Insertion code (Heh. Insertion.)
		if (selection == 1) {
			System.out.println();
			System.out.println("* Enter the starting position:");
			start = kb.nextInt();

			// Insertion point sanity check
			while (start > text.textlength+1 || start < 1) {
				System.out.println("You're just being difficult.");
				System.out.println("Try a value that makes sense:");
				start = kb.nextInt();
				}
			System.out.println();
			System.out.println("* Enter the text you want to insert:");
			dummy = kb.next();

			// Insertion string sanity check
			while (dummy.length() + text.textlength > 100) {
				System.out.println("* Operation failed: You exceeded the maximum length.");
				System.out.println("*Enter the text you want to insert:");
				dummy = kb.next();
				};
			text.insert_text (dummy, start);
			System.out.println();
			for (int i = 0; i < text.textlength; i++) {
			    System.out.print(text.get_char(i));
				}
			}

		// Deletion code
		else if (selection == 2) {
			System.out.println();
			System.out.println("* Enter the starting and ending position for deletion.");
			start = kb.nextInt();
			end = kb.nextInt();

			// Deletion point sanity check
			while (start > text.textlength+1 || start < 1 || end > text.textlength+1 || end < start) {
				System.out.println("You're just being difficult.");
				System.out.println("Try values that make sense:");
				start = kb.nextInt();
				end = kb.nextInt();
				}
			text.delete_text (start, end);
			System.out.println();
			for (int i = 0; i < text.textlength; i++) {
			    System.out.print(text.get_char(i));
				}
			}

		// Replacement code
		else if (selection == 3) {
			System.out.println();
			System.out.println("* Enter the starting and ending position:");
			start = kb.nextInt();
			end = kb.nextInt();
			
			// Replacement point sanity check
			while (start > text.textlength+1 || start < 1 || end > text.textlength+1 || end < start) {
				System.out.println("You're just being difficult.");
				System.out.println("Try a value that makes sense:");
				start = kb.nextInt();
				end = kb.nextInt();
				}
			System.out.println();
			System.out.println("* Enter the text you want to replace:");
			dummy = kb.next();

			// Replacement string sanity check
			while ((dummy.length() - (end - start)) + text.textlength > 100) {
				System.out.println("* Operation failed: You exceeded the maximum length.");
				System.out.println("*Enter the text you want to insert:");
				dummy = kb.next();
				};
			text.replace_text (dummy, start, end);
			System.out.println();
			for (int i = 0; i < text.textlength; i++) {
			    System.out.print(text.get_char(i));
				}
			}

		}
	// Quit code
	while (selection !=4);
	System.out.println("Good bye!");
	}
}
