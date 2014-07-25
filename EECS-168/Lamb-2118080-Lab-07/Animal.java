/* -----------------------------------------------------------------------------
 *
 * File Name:  Animal.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program defines the Animal class.
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
public class Animal {
    String animalType, animalSound;
    public void setType (String Type) {
	animalType = Type;
    };
    public String getType() {
	return animalType;
    };
    public void setSound (String Sound) {
	animalSound = Sound;
    };
    public String getSound(){
	return animalSound;
    };
}
