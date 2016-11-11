#include <iostream>
#include <fstream>
#include <string>
#include "operation.h"

using namespace std;

int main()
{
  int Regs[32];
  float FP[32];
  float Mem[125];
  int instrcount = 0;
  // I am making the decision that I'm only doing the first 500 commands.
  // You want more than that, you can alter the code yourself.
  operation Code[500];
  // Set all registers to default of 0.
  for(int i = 0; i < 32;i++)
    {
      Regs[i] = 0;
      FP[i] = 0;
    }
  for(int j = 0; j < 125;j++)
    {
      Mem[j] = 0;
    }

  // Program begins!
  cout << "EECS 645 Programming Project"<<endl
       <<"Samuel Lamb"<<endl
       <<"2118080"<<endl<<endl
       <<"Please name the input file: "<<endl;
  string filename;
  cin >> filename;


  ifstream infile{};
  infile.open(filename);
  string input;
  infile >> input;

  // input should now contain "I-REGISTERS"
  // Nobody cares about that string, so we move forward.
  infile >> input;


  // input now contains the next line, either "FP-REGISTERS" or the first I-register.
  // Loop will run for all integer registers
  while (input.compare("FP-REGISTERS")!=0)
    {
      // strip useless R
      int cur = stoi(input.substr(1));
      infile >> input;
      // infile now contains Regs[cur]
      Regs[cur] = stoi(input,nullptr,10);
      // Now, so does Regs[cur]
      // advance to next line, check loop condition
      infile >> input;
    }
  // input should now contain "FP-REGISTERS"
  infile >> input;


  // Loop will run for all floating point registers
  while (input.compare("MEMORY")!=0)
    {
      // strip useless F
      int cur = stoi(input.substr(1));
      infile >> input;
      // infile now contains FP[cur]
      FP[cur] = stof(input,nullptr);
      // Now, so does FP[cur]
      // advance to next line, check loop condition
      infile >> input;
    }
  // input should now contain "MEMORY"
  infile >> input;


  // Loop will run for all memory locations
  while(input.compare("CODE")!=0)
    {
      int cur = stoi(input);
      infile >> input;
      // infle now contains Mem[cur]
      // which could, as in the example, be an int, but screw it. It's gonna be a float.
      Mem[cur] = stof(input,nullptr);
      // Now, so does Mem[cur]
      // advance to next line, check loop condition
      infile >> input;
    }
  // input should now contain "CODE"


  // Loop will run for the rest of the file
  while(infile>>input)
    {
      // This is how I strip those universally unnecessary commas from the code
      if(input.back() == ',')
	{
	  input.pop_back();
	}
      Code[instrcount].op = input;
      infile >> input;
      if(input.back() == ',')
	{
	  input.pop_back();
	}
      Code[instrcount].destination = input;
      infile >> input;
      if(input.back() == ',')
	{
	  input.pop_back();
	}
      Code[instrcount].operand1 = input;
      // Everything but loads and stores has another operand a-comin'
      if (Code[instrcount].op.compare("L.D")!=0 && Code[instrcount].op.compare("S.D")!= 0)
	{
	  infile >> input;
	  Code[instrcount].operand2 = input;
	}

      // Here's where I process timing
      // First instruction gets all the best stuff
      if(instrcount == 0)
	{
	  Code[0].IF = 1;
	  Code[0].ID = 2;
	  Code[0].EXbeg = 3;
	  if(Code[0].op.compare("L.D")==0 || Code[0].op.compare("S.D")==0)
	    {
	      Code[0].EXend = 3;
	    }
	  else if (Code[0].op.compare("ADD.D")==0 || Code[0].op.compare("SUB.D")==0)
	    {
	      Code[0].EXend = 6;
	    }
	  else if (Code[0].op.compare("MUL.D")==0)
	    {
	      Code[0].EXend = 9;
	    }
	}
      else
	{
	  // Subsequent instructions have a harder life
	  Code[instrcount].IF = Code[instrcount-1].ID;
	  Code[instrcount].ID = Code[instrcount].IF + 1;
	  // Check for data dependencies
	  for(int i = 0; i < instrcount; i++)
	    {
	      if(Code[i].destination.compare(Code[instrcount].operand1)==0 || 
		 Code[i].destination.compare(Code[instrcount].operand2)==0 || 
		 Code[i].destination.compare(Code[instrcount].destination)==0)
		{
		  if (Code[i].EXbeg == Code[i].EXend)
		    {
		      Code[instrcount].ID = Code[i].EXend+1;
		    }
		  else
		    {
		      Code[instrcount].ID = Code[i].EXend;
		    }
		}
	    }
	  if(Code[instrcount].ID < (Code[instrcount].IF +1))
	    {
	      Code[instrcount].ID = Code[instrcount].IF + 1;
	    }

	  Code[instrcount].EXbeg = Code[instrcount].ID + 1;

	  int offset;
	  if(Code[instrcount].op.compare("L.D")==0 || Code[instrcount].op.compare("S.D")==0)
	    {
	      offset = 0;
	    }
	  else if (Code[instrcount].op.compare("ADD.D")==0 || Code[instrcount].op.compare("SUB.D")==0)
	    {
	      offset = 3;
	    }
	  else if (Code[instrcount].op.compare("MUL.D")==0)
	    {
	      offset = 6;
	    }
	  Code[instrcount].EXend = Code[instrcount].EXbeg + offset;
	}

      instrcount++;
      if(instrcount > 500)
	{
	  cout << "Code too long. Truncating at 500 instructions.";
	  instrcount = 500;
	  break;
	}
    }
   infile.close();
  /* Ok. Everything from the input file is read.
   *
   * "You may assume that the input data file does not contain any errors"
   * Oh, I will. I will.*/

   for(int i = 0; i < instrcount; i++)
     {
       if(Code[i].op.compare("S.D")==0)
	 {
	   int offsett = stoi(Code[i].destination.substr(0,Code[i].destination.find_first_of("(")));
	   // tempreg will say something like "R2)"
	   string tempreg = Code[i].destination.substr(Code[i].destination.find_first_of("R") + 1);
	   // Remove the ")"
	   tempreg.pop_back();
	   // Turn it into an integer
	   int index = stoi(tempreg,nullptr);
	   Mem[offsett+Regs[index]] = stof(Code[i].operand1.substr(1),nullptr);
	 }
       if(Code[i].op.compare("L.D")==0)
	 {
	   int offsett = stoi(Code[i].operand1.substr(0,Code[i].operand1.find_first_of("(")));
	   // tempreg will say something like "R2)"
	   string tempreg = Code[i].operand1.substr(Code[i].operand1.find_first_of("R") + 1);
	   // Remove the ")"
	   tempreg.pop_back();
	   // Turn it into an integer
	   int index = stoi(tempreg,nullptr);
	   FP[stoi(Code[i].destination.substr(1),nullptr)] = Mem[offsett+Regs[index]];
	 }
       if(Code[i].op.compare("SUB.D")==0)
	 {
	   float op2 = FP[stoi(Code[i].operand2.substr(1),nullptr)];
	   float op1 = FP[stoi(Code[i].operand1.substr(1),nullptr)];
	   FP[stoi(Code[i].destination.substr(1),nullptr)] = op1 - op2;
	 }
       if(Code[i].op.compare("ADD.D")==0)
	 {
	   float op2 = FP[stoi(Code[i].operand2.substr(1),nullptr)];
	   float op1 = FP[stoi(Code[i].operand1.substr(1),nullptr)];
	   FP[stoi(Code[i].destination.substr(1),nullptr)] = op1 + op2;
	 }
       if(Code[i].op.compare("MUL.D")==0)
	 {
	   float op2 = FP[stoi(Code[i].operand2.substr(1),nullptr)];
	   float op1 = FP[stoi(Code[i].operand1.substr(1),nullptr)];
	   FP[stoi(Code[i].destination.substr(1),nullptr)] = op1 * op2;
	 }
     }

   // Begin output.

   // Timing output:
   cout << "Please name the timing output file: "<<endl;
   cin >> filename;
   ofstream outfile{};
   outfile.open(filename); 
   // Top row is just I#1 etc.
   outfile << "       "; // 7 spaces
   for(int i = 1; i <= instrcount;i++)
     {
       string count = "I#"+to_string(i)+"   ";
       outfile << count.substr(0,6);
     }
   outfile << endl;
   int cycle = 1;
   while(cycle <= (Code[instrcount-1].EXend+2))
     {
       outfile << "c#" << cycle << "   ";
       if (cycle < 10)
	 {
	   outfile << " ";
	 }
       for(int i = 0;i<instrcount;i++)
	 {
	   // I'm convinced there's a more elegant way to do this.
	   // I do not care.
	   if(cycle == Code[i].IF)
	     {
	       outfile << "IF" << "    ";
	     }
	   else if(cycle > Code[i].IF && cycle < Code[i].ID)
	     {
	       outfile << "stall" << " ";
	     }
	   else if(cycle == Code[i].ID)
	     {
	       outfile << "ID" << "    ";
	     }
	   else if(cycle >= Code[i].EXbeg && cycle <= Code[i].EXend)
	     {
	       /* I'm not doing a by-operation counting-variable runaround just so that this can
		* say A1 A2 or M1 M2. It adds nothing but hassle. */
	       outfile << "EX" << "    ";
	     }
	   else if(cycle == Code[i].EXend + 1)
	     {
	       outfile << "MEM" << "   ";
	     }
	   else if(cycle == Code[i].EXend + 2)
	     {
	       outfile << "WB" << "    ";
	     }
	   else
	     {
	       outfile << "      ";
	     }
	 }
       outfile << endl;
       cycle++;
     }
   outfile.close();


   // Register output:
   cout << "Please name the register output file: " << endl;
   cin >> filename;
   outfile.open(filename);
   for (int i = 0; i < 32; i++)
     {
       if(FP[i] != 0.0)
	 {
           string reg = "F"+to_string(i)+"   ";
	   outfile << reg.substr(0,5);
	 }
     }
   outfile << endl;
   for (int i = 0; i < 32; i++)
     {
       if(FP[i] != 0.0)
       {
	 // Floats are stupid, so these values end up rounded off funky.
	 // This is C++'s fault, not mine.
         string reg = to_string(FP[i])+ "     ";
	 outfile << reg.substr(0,4) << " ";
       }
     }
   outfile.close();
}
