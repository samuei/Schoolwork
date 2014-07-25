import java.util.Scanner;
public class Rearranging_Cartons {
    public static void main(String[]args){
	Scanner kb = new Scanner(System.in);
	int n, steps;
	int[] real, ideal;
	steps = 0;
	
	System.out.println("Input n:");
	n = kb.nextInt();
	real = new int[n];
	ideal = new int[n];
	System.out.println("Input the current order:");
	for (int i = 0; i < n; i++){
	    real[i] = kb.nextInt();
	}
	System.out.println("Input the expected order:");
       	for (int i = 0; i < n; i++){
	    ideal[i] = kb.nextInt();
	}
	for (int i = 0; i < n; i++){
	    while (real[i] != ideal[i]) {
		for (int j = i+1; j < n; j++){
		    if (real[j] == ideal[i]) {
			int value = real[j-1];
			real[j-1] = real[j];
			real[j] = value;
			steps += 1;
		    }
		}
	    }
	}
	System.out.println("Number of steps:");
	System.out.println(steps);
    }
}
