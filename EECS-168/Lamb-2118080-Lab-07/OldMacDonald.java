/* -----------------------------------------------------------------------------
 *
 * File Name:  OldMacDonald.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program defines OldMacDonald objects.
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
public class OldMacDonald {
    private String animal;
    private String sound;
    public String getAnimal (){
	return animal;
    };
    public void setAnimal (Animal userinput){
	animal = userinput.getType();
	sound = userinput.getSound();
    };
    public void sing (){
	System.out.println("Old MacDonald had a farm, EE-I-EE-I-O");
	System.out.println("And on that farm he had a "+animal+" EE-I-EE-I-O");
	System.out.println("With a "+sound+"-"+sound+" here, and a "+sound+"-"+sound+" there,");
	System.out.println("Here a "+sound+", there a "+sound+", everywhere a "+sound+"-"+sound+",");
	System.out.println("Old MacDonald had a farm, EE-I-EE-I-O");
    }
}
