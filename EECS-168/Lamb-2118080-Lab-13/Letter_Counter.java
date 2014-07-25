import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.FileWriter;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.File;

public class Letter_Counter {
    public static void main(String[] args){

	String filename;
	Scanner inputStream = null;
	Scanner outputStream = null;
	Scanner kb = new Scanner (System.in);

	System.out.println("Enter a filename:");
	filename = kb.next();
	try
	    {
		inputStream = new Scanner(new File (filename));
	    }
	catch (Exception e){
	    System.err.println("Error: "+e.getMessage());
	    System.exit(0);
	}
	try {
       	FileWriter fstream = new FileWriter("Output.txt");
	BufferedWriter out = new BufferedWriter(fstream);
	String wholefile = " ";
   	while(inputStream.hasNextLine())
       	    {
		wholefile = new String (wholefile.concat(inputStream.nextLine()));
       	    }
	wholefile = new String (wholefile.toUpperCase());
	out.write("The file contains the following letters:");
	for (int inc = (int) 'A'; inc <= ((int) 'Z'); inc++){
	    int q = 0;
	    for (int j = 0; j < wholefile.length(); j++) {
		if (wholefile.charAt(j) == (char) inc)
		    q += 1;
	    }
	    out.write("\n"+(char) inc+": "+q);
	}
       	out.close();
	}
	catch (IOException e) {
	    System.out.println("IO Error.");
	    System.exit(0);
	}
       	System.out.println("Output.txt created.");
    }
}
