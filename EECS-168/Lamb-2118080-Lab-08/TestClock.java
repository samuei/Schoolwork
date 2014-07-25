/* -----------------------------------------------------------------------------
 *
 * File Name: TestClock.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 8
 * Description:  This constructs two clocks, adds their times, and ticks it 10 times
 * Date: 10/18/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class TestClock {
    public static void main(String[] Args) {
    Clock clock1 = new Clock();
    Clock clock2 = new Clock();
    Scanner kb = new Scanner(System.in);

    // This establishes clock 1
    System.out.println("Enter the Seconds:");
    clock1.setClock(kb.nextInt());
    System.out.println(clock1.getHours()+":"+clock1.getMinutes()+":"+clock1.getSeconds());
    System.out.println();

    // this establishes clock 2
    System.out.println("Enter the seconds for another Clock:");
    clock2.setClock(kb.nextInt());
    System.out.println(clock2.getHours()+":"+clock2.getMinutes()+":"+clock2.getSeconds());
    System.out.println();

    // this adds the clocks
    System.out.println("The current clock time:");
    clock1.addClock(clock2);
    System.out.println(clock1.getHours()+":"+clock1.getMinutes()+":"+clock1.getSeconds());
    System.out.println();

    // This ticks the clock 10 times
    System.out.println("The next ten ticks of the clock:");
    for (int i = 0; i<10; i++) {
	clock1.tick();
	System.out.println(clock1.getHours()+":"+clock1.getMinutes()+":"+clock1.getSeconds());
    };
}
}
