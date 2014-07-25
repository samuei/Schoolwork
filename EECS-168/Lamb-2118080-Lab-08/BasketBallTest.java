/* -----------------------------------------------------------------------------
 *
 * File Name: BasketBallTest.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 8
 * Description:  This plays a fun game. Aren't you excited?
 * Date: 10/18/12
 *
 ---------------------------------------------------------------------------- */
import java.util.Scanner;
public class BasketBallTest {
    public static void main (String[] Args) {
	Scanner kb = new Scanner(System.in);
	String scoreTeam;
	String tieCheck = new String("GAMETIED");
	BasketBall bball = new BasketBall();
	System.out.println("Welcome Basketball Fans!!");
	System.out.println();
	System.out.println("Enter a team:");
	bball.team1 = kb.next();
	System.out.println("Enter their opponent:");
	bball.team2 = kb.next();
	
	// this loop essentially plays the game, so long as the game's status
	// isn't over
	while (bball.getStatus() == false) {
	    System.out.println();
	    System.out.println("Enter a score");
	    bball.setScore(kb.next(), kb.nextInt());
	    System.out.println(bball.team1+": "+bball.getScore(1)+", "+bball.team2+": "+bball.getScore(2));
	    
	    // This section checks to see if the game should be over
	    if (bball.getScore(1) >= 10 || bball.getScore(2) >= 10) {
		bball.toggleStatus();
	    };
	    if (bball.getStatus()) {
		    System.out.println("The "+bball.getWinningTeam()+" have won!!");
		};
	    }

	// this part checks if the game is tied.
	    else if (tieCheck.compareTo(bball.getWinningTeam())==0) {
		System.out.println("The game is tied!");
		System.out.println("The suspense is killing me!");
	    }
	
	// this part tells you who is winning
	    else {
		System.out.println("The "+bball.getWinningTeam()+" are winning.");
		System.out.println();
	    };
	};
    };
}
