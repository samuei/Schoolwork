#include <iostream>
#include <fstream>
#include <string>
#include "TranslationTable.h"
using namespace std;

// This constructor takes in a stream by reference, takes the first thing it finds as an int (non-integer values are...not recommended), and allocates an array (of length 'index', where index is the previously-acquired int) KeyValuePairs that corresponds to the values that follow. Incorrectly formatted inputs will cause errors, so the input file must be formatted exactly right.
template<class Key, class Value>
	TranslationTable<Key, Value>::TranslationTable(ifstream &is)
	{
		is >> index;
		KeyPairs = new KeyValuePair<Key, Value>[index];
		for (int i = 0; i < index; i++)
		{
			is >> buffkey;
			KeyPairs[i].SetK(buffkey);
			is >> buffval;
			KeyPairs[i].SetV(buffval);
		}
	}

// The sole method of this class takes an input of the Key type and compares it against the Keys it has stored in its array. If it finds a match, it will return the corresponding value associated with that particular key.
template<class Key, class Value>
	Value TranslationTable<Key, Value>::decode(Key a)
	{
		for (int i = 0; i < index; i++)
		{
			if (KeyPairs[i].GetK() == a)
			{
				return KeyPairs[i].GetV();
			}
		}
		// This should never need to be used, but it can't hurt to be sure.
		return 0;
	}
