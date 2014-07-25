//Samuel Lamb 2118080
//samuei@ku.edu

import java.io.*;
import java.util.Scanner;

public class NoiseReduction {
public static void main (String[] args) {
    String filename = "input.txt";
	PrintWriter outputStream = null;
	Scanner inputStream = null;
	String[] inputstring = new String[3];
	String[] outputstring = new String[3];
	int count = 0;
	int[] noise = new int[3];

	try {
	    inputStream = new Scanner(new File (filename));
	}
	catch (Exception e) {
		System.out.println("Error opening input.txt!");
		System.exit(0);
		}

	//Here I parse the input into a string, with the count variable keeping track of what line it's on
	while (inputStream.hasNextLine()) {
		inputstring[count] = inputStream.nextLine();
		count++;
		}

	//Now that I have 3 strings for 3 lines, I need to clean them! This block turns the input string into a character array, burns away the non-alpha characters, while simultaneously condensing the alpha characters into 3 more strings
	try {
		for (int i = 0; i < 3; i++) {
		    outputstring[i] = "";
		    noise[i]=0;
		    char[] arr = inputstring[i].toCharArray();
		    for (int j = 0; j < arr.length; j++) {
			boolean needsPurging = true;
			for (int k = 0; k < 26; k++) {
			    if ( (int)arr[j] == (97+k) || (int) Character.toLowerCase(arr[j]) == ((int) 97+k)) {
				needsPurging = false;
			    }
			}
			if (!needsPurging) {
			    outputstring[i] = outputstring[i].concat(Character.toString(arr[j])); 
			}
			else {
			    noise[i]++;
			}
		    }
		}
	}
	catch (Exception e) {
	    System.out.println("Error: "+e.getCause()+"!");
		System.exit(0);
		}
	
	//This just outputs the strings and the counter for how many characters were removed, and we're done! Yay!
	try {
		outputStream = new PrintWriter("output.txt");
		BufferedWriter out = new BufferedWriter(outputStream);
		for (int i = 0; i < 3; i++) {
			out.write(outputstring[i]+"("+noise[i]+")\n");
			}
		out.close();
		}
	catch (IOException e)
	{
		System.out.println("Error opening output.txt!");
		System.exit(0);
		}
}	
}
