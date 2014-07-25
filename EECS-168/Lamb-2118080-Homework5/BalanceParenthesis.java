//Samuel Lamb 2118080
//samuei@ku.edu

import java.io.*;
import java.util.Scanner;

public class BalanceParenthesis {
public static void main (String[] args) {
    String filename = "input.txt";
	Scanner inputStream = null;
	String inputstring = new String (" ");
	char[] arr;
	int arrlength, oparen, obrack;
	boolean uhoh = false;
	
	//Reading the file
	try {
	    inputStream = new Scanner(new File (filename));
		}
	catch (Exception e) {
		System.out.println("Error opening input.txt!");
		System.exit(0);
		}

	//Rather than deal with multiple lines, I decided to just stuff it all into one string. It'd be dirty if I needed to display anything from the file, but since I don't, who cares?
	while (inputStream.hasNextLine()) {
		inputstring = inputstring.concat(inputStream.nextLine());
		}

	//Here, I output the file to a char array (arr), and give its length a variable so the loop won't eat as much memory. I start the open parentheses and brackets variables.
	arr = inputstring.toCharArray();
	arrlength = arr.length;
	oparen = 0;
	obrack = 0;

	//This loop goes through each character. If the character is an open paren or an open bracket, it increments the corresponding variable. If it's a closing paren or bracket, the variable is decremented. To account for closing paren/brackets that come before their corresponding opener, the uhoh boolean is set.
	for (int i = 0; i < arrlength; i++) {
		if (arr[i] == '(') {
			oparen++;
			}
		else if (arr[i] == '[') {
			obrack++;
			}
		else if (arr[i] == ')' && oparen > 0) {
			oparen--;
			}
		else if (arr[i] == ']' && oparen > 0) {
			obrack--;
			}
		else if (arr[i] == ']' || arr[i] == ')') {
			uhoh = true;
			}
		}

	//Here is the output. If both variables are zero and the uhoh variable didn't find any screw-ups in the order, the input was balanced. Otherwise, it was on. Magic!
	if (obrack == 0 && oparen == 0 && !uhoh) {
		System.out.println("Balanced");
		}
	else {
		System.out.println("Not Balanced");
		}
}	
}
