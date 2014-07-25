#ifndef KeyValuePair_H
#define KeyValuePair_H

// This is actually a very usable bit of code, or at least a very good concept.
template <class Key, class Value>
class KeyValuePair
{
private:
	Key k;
	Value v;
public:
	void SetK(Key newval);
	void SetV(Value newval);
	Value GetV();
	Key GetK();
};

#include "KeyValuePair.cpp"
#endif
