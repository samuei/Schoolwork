/* -----------------------------------------------------------------------------
 *
 * File Name: Clock.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 8
 * Description:  This constructs a clock class and defines its methods
 * Date: 10/18/12
 *
 ---------------------------------------------------------------------------- */
public class Clock {
    private int hours;
    private int minutes;
    private int seconds;

    
    // The setclock method takes raw seconds and spits out a usable time
    public void setClock(int secondsM) {
	int hh, mm, ss;
	hh = secondsM/3600;
	mm = (secondsM-(hh*3600))/60;
	ss = secondsM-(hh*3600)-(mm*60);
	for (int i =0; hh>=24; ) {
	    hh-=24;
	};
	
	this.setHours(hh);
	this.setMinutes(mm);
	this.setSeconds(ss);
    };

    // This method sets the hours
    public void setHours(int hour) {
	hours = hour;
    };

    // This method sets the minutes
    public void setMinutes(int minute) {
        minutes = minute;
    };

    // This method sets the seconds
    public void setSeconds(int second) {
        seconds = second;
    };

    // These methods return time bits
    public int getHours() {
	return hours;
    };
    public int getMinutes() {
	return minutes;
    };
    public int getSeconds() {
	return seconds;
    };

    // tick advances the clock one second, and sanitizes the values
    public void tick() {
	seconds++;
	for (int s=0; seconds>=60; ) {
	    seconds -= 60;
	    minutes++;
	    for (int m=0; minutes>=60; ) {
		minutes -= 60;
		hours++;
		    for (int i=0; hours>=24; ) {
			hours -= 24;
		    };
	    };
	};
    };

    // this method adds a second clock's time to the current clock's time
    public void addClock(Clock c) {
	seconds += c.seconds;
       	for (int s=0; seconds>=60; ) {
       	    seconds -= 60;
	    minutes++;
       	    for (int m=0; minutes>=60; ) {
		minutes -= 60;
	       	hours++;
	        for (int i=0; hours>=24; ) {
		    hours -= 24;
	      	    };
       	    };
       	};
	minutes += c.minutes;
	if (minutes>=60) {
	    minutes -= 60;
	    hours++;
	    for (int i=0; hours>=24; ) {
		hours -= 24;
	        };
	};
	hours += c.hours;
        for (int i=0; hours>=24; ) {
       	    hours -= 24;
	    };
    };
}
