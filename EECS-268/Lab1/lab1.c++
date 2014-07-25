#include <iostream>
#include <fstream>
#include <string>
using namespace std;

// Declarations! Don't you love 'em?
int CountChecks(char* filename, int x);
void CheckandWrite(char* infile, char* outfile, int numchecks, string checks[]);
string Check(string toCheck, string checks[], int numchecks, bool& openpar);

// The Main function. Home Office. HQ. The big M.
int main(int argc, char* argv[])
{
	int numchecks;

	// Finds out how big our array of keywords needs to be
	numchecks = CountChecks(argv[2], numchecks);

	// Basically establishes our array of keywords
	string checks[numchecks];
	int passes = 0;
	string item;
	ifstream inp(argv[2]);
	// Takes the whitespace-delimited list of terms to check against and puts them into the checks array
	while (inp >> item)
	{
		checks[passes]=item;
		passes++;
	}
	inp.close();

	// works out whether to write or cout, and sends it off to the workshop
	if (argc == 3)
	{
		char* coutnull = "coutnull";
		CheckandWrite(argv[1], coutnull, numchecks, checks);
	}
	else
	{
		CheckandWrite(argv[1], argv[3], numchecks, checks);
	}
	
	// finishes up
	return 0;
}

// This function sets up the numchecks variable, which will be the array index for the checks list
int CountChecks(char* filename, int x)
{
	x = 0;
	string item;
	ifstream inp(filename);
	// Takes the whitespace-delimited list of terms to check against and counts them
	while (inp >> item)
	{
		x+=1;
	}
	inp.close();
	return x;
}

// CheckandWrite establishes the openpar boolean, sets up file read/write, passes each value to the Check function, then writes its output
void CheckandWrite(char* infile, char* outfile, int numchecks, string checks[])
{
	bool openpar = false;
	string item;
	string outfileS(outfile);
	ifstream inp(infile);
	// The coutnull keyword makes the program output to the console instead of to a file
	if (outfileS.compare("coutnull") == 0)
	{
		while (inp >> item)
		{
		cout << " ";
		cout << Check(item, checks, numchecks, openpar);
		}
	}
	// otherwise, we proceed as normal
	else
	{
		ofstream outp (outfile,ofstream::binary);
		while (inp >> item)
		{
		outp << " ";
		outp << Check(item, checks, numchecks, openpar);
		}
		outp.close();
	}
	inp.close();
}

// Checks is the workhorse of this program. It checks each whitespace-delineated string against HTML tags, our checks array, and even tries to adjust for punctuation (see below for limitations)
string Check(string toCheck, string checks[], int numchecks, bool& openpar)
{
	string checked;

	// This covers guidelines 2 and 3, making sure all <p> tags are closed before opening a new one or closing the body
	if (toCheck.compare("<p>") == 0 && openpar == true)
	{
		return "</p> <p>";
	}
	else if (toCheck.compare("</body>") == 0 && openpar == true)
	{
		openpar = false;
		return "</p> </body>";
	}
	else if (toCheck.compare("<p>") == 0 && openpar == false)
	{
		openpar = true;
		return "<p>";
	}

	// This loop checks the word against our list, and appends <i> tags as necessary
	for (int i = 0; i < numchecks; i++)
	{
		// This compares the text to each list member
		if (toCheck.compare(checks[i]) == 0)
		{
			checked = "<i>"+toCheck+"</i>";
			return checked;
		}
		// This compares all but the last character of the text, which allows this function to account for a single character of punctuation. This implementation is not ideal for a number of reasons (for example, if "lose" is a checks term, "loser" will be partially italicized, but "losers" will not), but there's no avoiding that without dedicated, professional textual analysis code that is far outside the scope of this lab
		else if (checks[i].compare(toCheck.substr(0,toCheck.length()-1)) == 0)
		{
			checked = "<i>"+toCheck.substr(0,toCheck.length()-1)+"</i>"+toCheck.substr(toCheck.length()-1,1);
			return checked;
		}
	}

	// if nothing matches, Check spits the original value back out. No muss, no fuss.
	return toCheck;
}
