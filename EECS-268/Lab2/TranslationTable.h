#ifndef TranslationTable_H
#define TranslationTable_H
#include "KeyValuePair.h"


template <class Key, class Value>
class TranslationTable
{
private:
	int index;
	KeyValuePair<Key, Value>* KeyPairs;
	Key buffkey;
	Value buffval;
public:
	TranslationTable(ifstream &is);
	Value decode(Key a);
};

#include "TranslationTable.cpp"

#endif
