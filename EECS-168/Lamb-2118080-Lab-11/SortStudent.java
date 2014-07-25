/* -----------------------------------------------------------------------------
 *
 * File Name: SortStudent.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 11
 * Description:  Creates Students objects from user input and sorts them by name and ID number
 * Date: 11/8/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
import java.text.Collator;

public class SortStudent{
    public static void main(String[] args){
	int numOfStu;
	Students[] student;
        Scanner kb = new Scanner(System.in);

	// Getting array size
	System.out.println("Enter the number of students:");
	numOfStu = kb.nextInt();
	student = new Students[numOfStu];

	// Getting array values
	for (int i = 0; i < numOfStu; i++) {
	    System.out.println("Enter student's name and id number: ");
	    student[i] = new Students();
	    student[i].readInput(kb.next(), kb.nextInt());
	}

       	System.out.println("*Sort by name:");
	bubbleSort(student, 1);
        //output by name
	for (int i = 0; i < numOfStu; i++) {
	    student[i].Output();
	}

        System.out.println("*Sort by id:");	
	bubbleSort(student, 0);
        //output by number
	for (int i = 0; i < numOfStu; i++) {
	    student[i].Output();
	}

    }


    public static void bubbleSort(Students[] arrb, int sortType){
      boolean swapped = true;
      int j = 0;
      Students tmp;

      // ID sorting
      if (sortType == 0) {
      while (swapped) {
            swapped = false ;
            j++;

            //Compare the first and the second and so on...                                    
            for (int i = 0; i < arrb.length - j; i++) {  
                  if ( arrb[i].ID>arrb[i+1].ID ) {
		      // swaps them if they're not sorted properly
		      tmp = arrb[i];
		      arrb[i] = arrb[i+1];
		      arrb[i+1] = tmp;
                        swapped = true ;
                  }
            }                
      }
      }

      // String Sorting
      else {
	  Collator coll = Collator.getInstance();
	  while (swapped) {
	      swapped = false ;
	      j++;

	      //Compare the first and the second and so on...                                    
	      for (int i = 0; i < arrb.length - j; i++) {  
                  if (coll.compare(arrb[i].name, arrb[i+1].name) > 0 ) {
		      // swaps them if they're not sorted properly
		      tmp = arrb[i];
		      arrb[i] = arrb[i+1];
		      arrb[i+1] = tmp;
                        swapped = true ;
                  }
            }                
      }
      }


    }
}
