/* -----------------------------------------------------------------------------
 *
 * File Name: SelectionSortTest.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 11
 * Description:  Generates random numbers and Selection Sorts them
 * Date: 11/8/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
import java.util.Random;

public class SelectionSortTest{
public static void main(String[] args) {

    //Here are my variables and Scanner.
    int i, j, k, b;
      int minIndex, tmp;
      int[] arr = new int[10];
      int n = arr.length;
      Scanner kb = new Scanner(System.in);
      Random random = new Random();

      //This generates the numbers
      System.out.println("* Generating 10 random integers in range (0,100):");
      for (b = 0; b < n; b++) {
	  arr[b] = random.nextInt(100);
	  System.out.print(arr[b]+" ");
      }
      System.out.println();
      

      // Here's the sorting algorithm, mostly copied from the example
      System.out.println("* Sorted numbers:");
      for (i = 0; i < n ; i++) {
            minIndex = i ;

            for (j = i + 1; j < n; j++)
            {      if (arr[j] < arr[minIndex])
                        minIndex = j ;
            } 
            if (minIndex != i) {
                  tmp = arr[i];
                  arr[i] = arr[minIndex] ;
                  arr[minIndex] = tmp ;
            }
	    System.out.print("Round "+(i+1)+": ");
	    for (k = 0; k<10; k++) {
		System.out.print(arr[k]+" ");
	    }
	    System.out.println();
      }

      System.out.println("Done.");
}
}
