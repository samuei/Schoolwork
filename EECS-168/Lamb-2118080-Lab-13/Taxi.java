import java.util.Scanner;
public class Taxi{
    public static void main(String[] args) {
	int number;
	int[] possiblenums;
	Scanner kb = new Scanner (System.in);

	System.out.println("Enter integer:");
	number = kb.nextInt();
	possiblenums = new int[number];
	for (int i = 1; i < number; i++){
	    possiblenums[i] = i;
	}
	System.out.println();
	for (int i = 0; i < number; i++) {
	    for (int j = 0; j < number; j++) {
		for (int k = 0; k < number; k++) {
		    for (int l = 0; l < number; l++) {
			if (i != j && i != k && i != l && j != k && j != l && k !=l){
			if (((i*i*i)+(j*j*j)) == ((k*k*k)+(l*l*l)))
			    System.out.println(i+" "+j+" "+k+" "+l);
			}
		    }
		}
	    }
	}
    }
}
