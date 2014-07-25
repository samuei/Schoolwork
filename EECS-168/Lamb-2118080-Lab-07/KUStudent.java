/* -----------------------------------------------------------------------------
 *
 * File Name:  KUStudent.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program defines the KUStudent class.
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class KUStudent {
    private String stud_fname, stud_lname, stud_kuid, stud_dpt;
    Scanner k = new Scanner (System.in);
    public void set_name(String fname, String lname){
	stud_fname = fname;
	stud_lname = lname;
    };
    public void set_kuinfo (String kuid, String dpt){
	stud_kuid = kuid;
	stud_dpt = dpt;
    };
    public void writeOutput(){
	System.out.println("Student: "+stud_fname+" "+stud_lname);
	System.out.println("KUID: "+stud_kuid);
	System.out.println("Department: "+stud_dpt);
    };
}
