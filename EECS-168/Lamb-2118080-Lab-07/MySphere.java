/* -----------------------------------------------------------------------------
 *
 * File Name:  MySphere.java
 * Author: Samuel Lamb 2118080
 * Assignment:   EECS-168 Lab 7
 * Description:  This program defines the MySphere class.
 * Date: 10/11/12
 *
 ---------------------------------------------------------------------------- */
public class MySphere {
    
    //Define the constant PI.
    private final double PI = 3.141592;
    //The MySphere class has one instance variable; diameter
    public double diameter;
            
    //The MySphere class has four methods
    public void setDiameter( double newDiameter ) {
        diameter = newDiameter ;
    }
        
   public double getDiameter() {
        return diameter ;
    }
    
    public double calculateVolume() {
         double volume = 0.0;
         volume = (4.0/3)*PI*Math.pow((diameter/2),3) ;
         return volume ;
    }
        
    public double calculateSurfaceArea() {
         double surfaceArea = 0.0;
         surfaceArea = 4*PI*Math.pow((diameter/2),2) ;
         return surfaceArea ;
    }
}
