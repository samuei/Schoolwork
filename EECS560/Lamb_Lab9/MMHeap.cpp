#include <math.h>
#include <iostream>

using namespace std;

MMHeap::MMHeap()
{
  // Heap[0] holds the size of the array.
  Heap[0] = 0;
}

MMHeap::~MMHeap()
{

}

// For building from file.
void MMHeap::BottomUp()
{
  // BUILD HEAP
  ifstream infile("data.txt");
  cout << "data.txt elements: ";
  int temp;
  while (infile >> temp)
    {
      cout << temp << " ";
      Heap[0]+=1;
      Heap[Heap[0]] = temp;
    }
  for (int i = Heap[0]; i >=1;i--)
    {
      Trickledown(i);
    }
  cout << endl << ".........................................................." << endl;
}

// Used in build/delete?
void MMHeap::Trickledown(int i)
{
  if(i<=Heap[0])
    {
      // if int(log2(i))%2=0, min level.
      if(int(log2(i))%2 == 0)
	{
	  Trickledownmin(i);
	}
      else
	{
	  Trickledownmax(i);
	}
    }
}

void  MMHeap::Trickledownmin(int i)
{
  // Checks if i has any children
  if (Heap[0] >= 2*i)
    {
      // Begins by assuming the first child is the smallest
      int m = 2*i;
      // Checks for second child
      if (Heap[0] >= (2*i)+1)
	{
	  // m becomes the index of the min of the children;
	  if (Heap[m] > Heap[(2*i)+1])
	    {
	      m = (2*i)+1;
	    }
	  // Checks for second child's children
	  if (Heap[0] >= (4*i)+2)
	    {
	      // m becomes min(m,3rd grandchild of i)
	      if (Heap[m] > Heap[(4*i)+2])
		{
		  m = (4*i)+2;
		}
	      // Checks for second child's second child
	      // (I think there's a prophecy about this...)
	      if (Heap[0] >= (4*i)+3)
		{
		  // m becomes min(m,4th grandchild of i)
		  if (Heap[m] > Heap[(4*i)+3])
		    {
		      m = (4*i)+3;
		    }
		}
	    }
	}
      // Checks for first child's children
      if (Heap[0] >= 4*i)
	{
	  // m becomes min(m, 1st grandchild of i)
	  if (Heap[m] > Heap[4*i])
	    {
	      m = 4*i;
	    }
	  // checks for first child's second child
	  if (Heap[0] >= (4*i)+1)
	    {
	      // m becomes min(m, 2nd grandchild of i)
	      if (Heap[m] > Heap[(4*i)+1])
		{
		  m = (4*i)+1;
		}
	    }
	}
      // m now holds the index of the smallest of the children/grandchildren of Heap[i]
      // Is m a grandchild of i?
      if (m>=(4*i))
	{
	  if (Heap[m] < Heap[i])
	    {
	      int temp = Heap[m];
	      Heap[m] = Heap[i];
	      Heap[i] = temp;
	      if (Heap[m] > Heap[m/2])
		{
		  int temp = Heap[m];
		  Heap[m] = Heap[m/2];
		  Heap[m/2] = temp;
		}
	      Trickledownmin(m);
	    }
	}
      else // If not, it's a child of i
	{
	  if (Heap[m] < Heap[i])
	    {
	      int temp = Heap[m];
	      Heap[m] = Heap[i];
	      Heap[i] = temp;
	    }
	}
    }
}

void MMHeap::Trickledownmax(int i)
{
  // Checks if i has any children
  if (Heap[0] >= 2*i)
    {
      // Begins by assuming the first child is the max
      int m = 2*i;
      // Checks for second child
      if (Heap[0] >= (2*i)+1)
	{
	  // m becomes the index of the max of the children;
	  if (Heap[m] < Heap[(2*i)+1])
	    {
	      m = (2*i)+1;
	    }
	  // Checks for second child's children
	  if (Heap[0] >= 2*((2*i)+1))
	    {
	      // m becomes index of max(m,second child's first child)
	      if (Heap[m] < Heap[2*((2*i)+1)])
		{
		  m = 2*((2*i)+1);
		}
	      // Checks for second child's second child
	      if (Heap[0]>=(2*((2*i)+1))+1)
		{
		  // m becomes index of max(m,second child's second child)
		  if (Heap[m] > Heap[(2*((2*i)+1))+1])
		    {
		      m = (2*((2*i)+1))+1;
		    }
		}
	    }
	}
      // Checks for first child's children
      if (Heap[0] >= 4*i)
	{
	  // checks for first child's second child
	  if (Heap[0] >= (4*i)+1)
	    {
	      // m becomes max
	      if (Heap[m] < Heap[(4*i)+1])
		{
		  m = (4*i)+1;
		}
	    }
	  // m becomes max
	  if (Heap[m] < Heap[4*i])
	    {
	      m = 4*i;
	    }
	}
      // m now holds the index of the max of the children/grandchildren of Heap[i]
      // Is m a grandchild of i?
      if (m>=(4*i))
	{
	  if (Heap[m] > Heap[i])
	    {
	      int temp = Heap[m];
	      Heap[m] = Heap[i];
	      Heap[i] = temp;
	      if (Heap[m] < Heap[m/2])
		{
		  int temp = Heap[m];
		  Heap[m] = Heap[m/2];
		  Heap[m/2] = temp;
		}
	      Trickledownmax(m);
	    }
	}
      else // If not, it's a child of i
	{
	  if (Heap[m] > Heap[i])
	    {
	      int temp = Heap[m];
	      Heap[m] = Heap[i];
	      Heap[i] = temp;
	    }
	}
    }
}

// Used in insert?
void  MMHeap::Bubbleup(int i)
{
  // if int(log2(i))%2=0, min level.
  if(int(log2(i))%2 == 0)
    {
      if (i>1 && Heap[i]>Heap[i/2])
	{
	  int temp = Heap[i];
	  Heap[i] = Heap[i/2];
	  Heap[i/2] = temp;
	  Bubbleupmax(i/2);
	}
      else
	{
	  Bubbleupmin(i);
	}
    }
  else
    {
      if(i>1 && Heap[i]<Heap[i/2])
	{
	  int temp = Heap[i];
	  Heap[i] = Heap[i/2];
	  Heap[i/2] = temp;
	  Bubbleupmin(i/2);
	}
      else
	{
	  Bubbleupmax(i);
	}
    }
}

void MMHeap::Bubbleupmin(int i)
{
  if (i > 3)
    {
      if (Heap[i] < Heap[int(int(i/2)/2)])
	{
	  int temp = Heap[i];
	  Heap[i] = Heap[int(int(i/2)/2)];
	  Heap[int(int(i/2)/2)] = temp;
	  Bubbleupmin(int(int(i/2)/2));
	}
    }
}

void MMHeap::Bubbleupmax(int i)
{
  if (i > 3)
    {
      if (Heap[i] > Heap[int(int(i/2)/2)])
	{
	  int temp = Heap[i];
	  Heap[i] = Heap[int(int(i/2)/2)];
	  Heap[int(int(i/2)/2)] = temp;
	  Bubbleupmax(int(int(i/2)/2));
	}
    }
}

void MMHeap::levelorder()
{
  int level = 1;
  for(int i = 1; i <= Heap[0]; i++)
    {
      if(i >= 2*level)
	{
	  cout << endl;
	  level = level*2;
	}
      cout << Heap[i] << " ";
    }
}

void MMHeap::deletemax()
{
  if(Heap[0] == 0)
    {
      return;
    }
  else if(Heap[0] == 1)
    {
      Heap[0] = 0;
      return;
    }
  else
    {
      int m = 2;
      if(Heap[0] >=3)
	{
	  if (Heap[2] < Heap[3])
	    {
	      m = 3;
	    } 
	}
      Heap[m] = Heap[Heap[0]];
      Heap[0]-=1;
      Trickledown(m);
    }
}

void MMHeap::deletemin()
{
  // Make sure there's other stuff besides just the min.
  if (Heap[0] > 1)
    {
      // Alright, got that? Now, if there's only one other thing...
      if (Heap[0] == 2)
	{
	  Heap[1] = Heap[2];
	  Heap[0] -= 1;
	  return;
	}
      // Ok. If that's not the case, find the smallest child/grandchild.
      int s = 2;
      int j = Heap[0];
      if(Heap[0] >= 7)
	{
	  j = 7;
	}
      for (int i = 3; i <= j;i++)
	{
	  if (Heap[i] < Heap[s])
	    {
	      s = i;
	    }
	}
      // Ok. Heap[s] is what we wanted, there.
      // Compare the last element x in H with s:
      if (Heap[Heap[0]] <= Heap[s])
	{
	  // If x<s, x becomes the root and we're done.
	  Heap[1] = Heap[Heap[0]];
	  Heap[0]-=1;
	}
      else
	{
	  // Otherwise, s becomes root and it's complicated.
	  Heap[1] = Heap[s];
	  // Case: s is a child of r. Slot x in and we're done.
	  if(s<4)
	    {
	      Heap[s] = Heap[Heap[0]];
	      Heap[0]-=1;
	    }
	  // Case: s is a grandchild of r.
	  else
	    {
	      // Case: x < Parent(s). Trickledown.
	      if(Heap[Heap[0]] <= Heap[s/2])
		{
		  Heap[s] = Heap[Heap[0]];
		  Heap[0]-=1;
		  Trickledown(s);
		}
	      else
		{
		  Heap[s] = Heap[s/2];
		  Heap[s/2] = Heap[Heap[0]];
		  Heap[0]-=1;
		  Trickledown(s);
		}
	    }
	}
    }
  else
    {
      // Yeah, if there's 1 or fewer, just empty the thing.
      Heap[0] = 0;
    }
}

void MMHeap::insert(int x)
{
  Heap[0] +=1;
  Heap[Heap[0]] = x;
  Bubbleup(Heap[0]);
}
