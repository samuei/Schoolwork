/* -----------------------------------------------------------------------------
 *
 * File Name: LineEditor.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Homework 4
 * Description:  This is the utility class for the TestEditor class.
 * Date: 11/10/12
 *
 ---------------------------------------------------------------------------- */

public class LineEditor {
	private char[] text = new char[100];
    public int textlength, j;
	
	// inserts a string at the specified location
	public void insert_text (String dummy, int loc) {
	textlength += dummy.length();
	int difference = dummy.length();
        j = 0;
	for (int i = textlength; i >= loc-1; i--) {
		text[i+difference] = text[i];
		}
	for (int i = loc-1; j < difference; i++) {
		text[i] = dummy.charAt(j);
		j++;
		}
	}
	
	// removes text between two points (inclusive)
	public void delete_text (int start, int end) {
	int difference = end - start + 1;
	textlength = textlength - difference+1;
	for (int i = start-1; i < textlength; i++) {
		 text[i] = text[i+difference];
		}
	}

	// replaces text between two points with user-inputed alternative
	public void replace_text (String dummy, int start, int end) {
	int newsize = dummy.length();
	int oldsize = (end - start) + 1;
	int difference = newsize - oldsize;
	textlength = textlength + difference;
        for (int i = textlength; i > end-1; i--) {
	    text[i+difference] = text[i];
       	}
	j = 0;
	for (int i = start-1; j <= difference; i++) {
		text[i] = dummy.charAt(j);
		j++;
		}
	}

	// Sets the text to a user-defined string
	public void set_text (String dummy) {
	textlength = dummy.length();
	for (int i = 0; i < textlength; i++) {
		text[i] = dummy.charAt(i);
		}
	}

	// Returns a character from the string.
	public char get_char (int loc) {
	return text[loc];
	}

}
