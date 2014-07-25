/* -----------------------------------------------------------------------------
 *
 * File Name: BasketBall.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 8
 * Description:  This constructs a BasketBall class and defines its methods
 * Date: 10/18/12
 *
 ---------------------------------------------------------------------------- */
public class BasketBall {
    public String team1;
    public String team2;
    private int score1;
    private int score2;
    private boolean isOver = false;

    // These methods involve scoring
    public void onePoint(String team) {
	if (team.compareTo(team1)==0)
	    score1+=1;
	else
	    score2+=1;
    };

    public void twoPoint(String team) {
	if (team.compareTo(team1)==0)
	    score1+=2;
	else
	    score2+=2;
    };

    public void threePoint(String team) {
	if (team.compareTo(team1)==0)
	    score1+=3;
	else
	    score2+=3;
    };


    // This returns the score of a selected team
    public int getScore(int team) {
	if (team == 1)
	    return score1;
	else
	    return score2;
    };

    // This method allows scoring
    public void setScore(String team, int points) {
	if (team.compareTo(team1)==0) {
	    if (points == 1) {
		onePoint(team1);
	    }
	    else if (points == 2) {
		twoPoint(team1);
	    }
	    else if (points == 3) {
		threePoint(team1);
	    }
	    else {
		System.out.println("You can only score 1, 2, or 3 points.");
	    };
	}
	else if (team.compareTo(team2)==0) {
	    if  (points == 1) {
		onePoint(team2);
	    }
	    else if (points == 2) {
		twoPoint(team2);
	    }
	    else if (points == 3) {
		threePoint(team2);
	    }
	    else {
		System.out.println("You can only score 1, 2, or 3 points.");
	    };
	}
	else {
	    System.out.println("Which team scored?");
	};
    };

    
    // this method lets the program decide the game is over
    public void toggleStatus() {
	if (isOver) {
	    isOver = false;
	}
	else {
	    isOver = true;
	};
    };
    
    // This tells the program the game is over
    public boolean getStatus() {
	return isOver;
    };

    // This method returns the team that is winning
    public String getWinningTeam() {
	if (score1>score2) {
	    return team1;
	}
	else if (score2>score1) {
	    return team2;
	}
	else {
	    return "GAMETIED";
	}
    };
}
