#include <string>
using namespace std;

// Standard setter method for the Value part
	template<class Key, class Value>	
	void KeyValuePair<Key, Value>::SetK(Key newval)
	{
	k = newval;
	}

// Standard setter method for the Key part
	template<class Key, class Value>
	void KeyValuePair<Key, Value>::SetV(Value newval)
	{
	v = newval;
	}

// Standard getter method for the Value part
	template<class Key, class Value>
	Value KeyValuePair<Key, Value>::GetV()
	{
	return v;
	}

// Standard getter method for the Key part
	template<class Key, class Value>
	Key KeyValuePair<Key, Value>::GetK()
	{
	return k;
	}
