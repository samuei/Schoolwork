/* -----------------------------------------------------------------------------
 *
 * File Name: Students.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 11
 * Description:  Defines Students class for use elsewhere
 * Date: 11/8/12
 *
 ---------------------------------------------------------------------------- */
public class Students {

    // variable city
    public int ID;
    public String name;

    // Gets the name and number of students
    public void readInput(String namein, int IDin){
	name = namein;
	ID = IDin;
    }

    // Outputs values
    public void Output(){
	System.out.println(ID+" "+name);
    }
}
