/* -----------------------------------------------------------------------------
 *
 * File Name:  TestOldMacDonald.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program tests the OldMacDonald class.
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class TestOldMacDonald{
    public static void main(String[] Args) {
	Scanner kb = new Scanner (System.in);
	System.out.println("Please enter a kind of animal:");
	Animal testAnimal = new Animal ();
	OldMacDonald singingTest = new OldMacDonald();
	testAnimal.setType(kb.next());
	System.out.println("Please enter the noise a "+testAnimal.getType()+" makes:");
	testAnimal.setSound(kb.next());
	singingTest.setAnimal(testAnimal);
	singingTest.sing();
    }
}
