#include <iostream>
#include <fstream>
#include <string>
#include "Translator.h"
using namespace std;

Translator::Translator(char* filename)
{
// This section begins by opening the stream passed from the caller, then immediately establishing two TranslationTables that are hard-coded to be in string/int and int/string format, respectively. Improperly-formatted input files will cause errors.
	ifstream files (filename);
	TranslationTable<string, int> table1(files);
	TranslationTable<int, string> table2(files);

// Now that the keys have been fed in, the program takes each individual part of the actual message and runs them through the first table. When a hit is found, it passes that value to the second table, which in turn runs through its inventory, and sends back *its* value. The resulting decoded word is then output to the terminal window.
	while (files >> input)
	{
		cout << table2.decode(table1.decode(input));
// Just for the sake of aesthetics, I've made sure that the words won't run together. It's the little things, you know?
		cout << " ";
	}
	files.close();
}
