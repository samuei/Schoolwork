#ifndef Translator_H
#define Translator_H
#include "TranslationTable.h"

class Translator
{
private:
	string input;
	ifstream files;
public:
	Translator(char* filename);
};

#include "Translator.cpp"

#endif
