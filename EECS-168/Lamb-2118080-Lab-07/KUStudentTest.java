/* -----------------------------------------------------------------------------
 *
 * File Name:  KUStudentTest.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program tests the KUStudent class
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class KUStudentTest{
    public static void main (String[]Args){
	Scanner kb = new Scanner (System.in);
	KUStudent testguy = new KUStudent();
	System.out.println ("Please input the student's name (firstname lastname):");
	testguy.set_name(kb.next(),kb.next());
	System.out.println("Please input the student's KUID and department:");
	testguy.set_kuinfo(kb.next(),kb.next());
	System.out.println();
	testguy.writeOutput();
    }
}
