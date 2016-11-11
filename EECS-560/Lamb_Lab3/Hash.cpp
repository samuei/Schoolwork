// Samuel Lamb
// 2118080
#include <iostream>
#include "Hash.h"


using namespace std;

// Standard Constructor - Do not use
Hash::Hash()
{

}

// Preferred Constructor
Hash::Hash(int x, bool quadratic)
{
  table = new int[x];
  flag = new bool[x];
  for (int i = 0; i < x; i++)
    {
      table[i] = -1;
      flag[i] = false;
    }
  size = x;
  if (quadratic){
    quad = true;
  }
  else {
    quad = false;
  }
}

// Destructor
Hash::~Hash()
{
}

// Insert
void Hash::insert(int x)
{
  int hashnum = x % size;
  if (!this->isFull())
    {
      if (!this->contains(x))
	{
	  if (table[hashnum] == -1)
	    {
	      table[hashnum] = x;
	      flag[hashnum] = false;
	    }
	  else {
	    this->recinsert(x, 1);
	  }
	}
      else
	{
	  cout << "Duplicate elements cannot be inserted."<<endl;
	}
    }
  else
    {
      cout << "Cannot insert element. Table full."<<endl;
    }
}

// recinsert - internal method for recursive insertion (which sounds dirty)
void Hash::recinsert(int x, int i)
{
  // Can insertion be done?
  if (i <= size)
    {
      int hashnum;
      // Insert quadratically?
      if (quad)
	{
	  hashnum = (x + (i*i))%size;
	}
      // Insert linearly?
      else
	{ 
	  hashnum = (x+i)%size;
	}
      while(hashnum >= size)
	{
	  hashnum -= size;
	}
      if (table[hashnum] == -1)
	{
	  table[hashnum] = x;
	  flag[hashnum] = false;
	}
      else 
	{
	  recinsert(x, (i+1));
	}
    }
  else 
    {
      cout << "Cannot insert element."<<endl;
    }
}



// remove
void Hash::remove(int x)
{
	/* It took me a while to realize I could just use the hash function for this, but I think it's faster and cleaner this way.
	*	I thought about refactoring the insert code to use that, too, but I think it works alright as-is. */
	int hashnum = this->hash(x);
      if (table[hashnum] == x)
		{
		  table[hashnum] = -1;
		  flag[hashnum] = true;
		}
	  else
	  {
		  cout << x << " is not in the table." << endl;
	  }

}



// Print
void Hash::print()
{
  for(int i = 0; i < size; i++){
    cout << i << ": " << table[i] << " flag =";
    if (flag[i])
      {
	cout << "true";
      }
    else 
      {
	cout << "false";
      }
    cout << endl;
  }
}

// hash
int Hash::hash(int x)
{

		int i = 0;
		bool done = false;
		// Decided to do this here, rather than farm to yet another recursive function.
		while (!done)
			{
			 int hashnum;
			 // Quadratic hash
			 if (quad)
				{
				hashnum = (x + (i*i))%size;
				}
			// Linear hash
			else
				{
				hashnum = (x + i)%size;
				}

			 // This means the element is not in the table.
			 if ((table[hashnum] == -1) && (flag[hashnum] == false))
			 {
				 return -1;
			 }

			// Successful return!
			if (table[hashnum] == x)
				{
				return hashnum;
				}

			if (i > size)
				{
				// This also means that the element isn't in the table
				return -1;
				}
			else
				{
				i++;
				}
			}

		// Shouldn't ever run, but just for funsies, let's be safe.
		return -1;

}

// isFull
bool Hash::isFull()
{
  bool full = true;
  for (int i = 0; i<size; i++)
    {
      if (table[i] == -1)
	{
	  full = false;
	  break;
	}
    }
  return full;
}

// contains
bool Hash::contains(int x)
{
	if (this->hash(x) == -1)
	{
		return false;
	}
	else
	{
		return true;
	}
}
