// Samuel Lamb
// 2118080
#include <iostream>
#include "LinkedList.cpp"
#include "OHash.h"


using namespace std;

// Standard Constructor - Do not use
Hash::Hash()
{

}

// Preferred Constructor
Hash::Hash(int x)
{
  table = new LinkedList[x];
  size = x;

}

// Destructor
Hash::~Hash()
{
}

// Insert
void Hash::insert(int x)
{
  int hash = x%size;
  table[hash].insert(x, table[hash]);
}

// Remove
void Hash::remove(int x)
{
  int hash = x%size;
  table[hash].erase(x, table[hash]);
}

// Print
void Hash::print()
{
  for(int i = 0; i < size; i++){
    cout << i << ": ";
    table[i].print();
  }
}

// Hash
int Hash::hash(int x)
{
  return (x%size);
}

// Find
bool Hash::find(int x)
{
  int hash = x%size;
  // LinkedList's Find function returns nullptr if x is not in the list.
  // Therefore, if Find returns nullptr, x is not in the list.
  // So, if comparing that to nullptr returns true, x is not in the list, and I return the opposite (and vice versa).
  return (table[hash].find(x,table[hash]) != nullptr);
}
