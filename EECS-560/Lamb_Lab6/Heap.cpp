using namespace std;

Heap::Heap()
{
  for (int i = 0;i<500;i++)
    {
      Arr[i] = -1;
    }
  counter = 0;
  int temp;
  ifstream infile("data.txt");
  cout << "data.txt elements : ";
  while (infile >> temp)
    {
      cout << temp << " ";
      Arr[counter] = temp;
      counter++;
    }
  for(int i = (ceil((counter-1)/5)-1); i >= 0; i--)
    {
     heapify(i);
    }
  cout << endl << "....................." << endl;
}

Heap::~Heap()
{
}

// x is the index, not the value.
int Heap::heapify(int x)
{
  // Leaves are already heapified
  if (Arr[5*x+1] == -1)
    {
      return x;
    }
  int child1 = heapify(5*x+1);
  int smallest = child1;
  if(Arr[5*x+2] != -1)
    {
      int child2 = heapify(5*x+2);
      if(Arr[child2] < Arr[child1])
	{
	  smallest = child2;
	}
      if(Arr[5*x+3] != -1)
	{
	  int child3 = heapify(5*x+3);
	  if(Arr[child3] < Arr[smallest])
	    {
	      smallest = child3;
	    }
	  if(Arr[5*x+4] != -1)
	    {
	      int child4 = heapify(5*x+4);
	      if(Arr[child4] < Arr[smallest])
		{
		  smallest = child4;
		}
	      if(Arr[5*x+5] != -1)
		{
		  int child5 = heapify(5*x+5);
		  if(Arr[child5] < Arr[smallest])
		    {
		      smallest = child5;
		    }
		}
	    }
	}
    }
  if (Arr[smallest] < Arr[x])
    {
      int value = Arr[x];
      Arr[x] = Arr[smallest];
      Arr[smallest] = value;
      heapify(smallest);
    }
  return x;
}

void Heap::insert(int x)
{
  int parent = (int)((counter - 1) / 5);
  int current = counter;
  bool done = false;
  while (!done)
    {
      if (x < Arr[parent])
	{
	  if (current == parent)
	    {
	      Arr[current] = x;
	      done = true;
	    }
	  else
	    {
	      Arr[current] = Arr[parent];
	      current = parent;
	      parent = (int)((parent-1)/5);
	    }
	}
      else
	{
	  Arr[current] = x;
	  done = true;
	}
    }
  counter++;
}

void Heap::deletemin()
{
  // This prevents breaking the code by deleting min when there's no heap
  if(Arr[0] != -1)
    {
      Arr[0] = Arr[counter-1];
      Arr[counter-1] = -1;
      counter--;
      int cur = 0;
      int curchl = 1;
      while (Arr[curchl] != -1)
	{
	  int smallest = curchl;
	  for(int i = 1; i<=5;i++)
	    {
	      if ((Arr[curchl+i] < Arr[smallest]) && (Arr[curchl+i] != -1))
		{
		  smallest  = curchl+i;
		}
	    }
	  int temp = Arr[cur];
	  Arr[cur] = Arr[smallest];
	  Arr[smallest] = temp;
	  cur = smallest;
	  curchl = cur*5 + 1;
	}
    }
}

void Heap::deletemax()
{
  int max = (int)((counter-1)/5)+1;
  int current = max;
  while (current < counter)
    {
      if (Arr[current] > Arr[max])
	{
	  max = current;
	}
      current++;
    }
  Arr[max] = Arr[counter-1];
  Arr[counter-1] = -1;
  counter--;
}

void Heap::remove(int x)
{
  // if there are duplicates, remove all of them
  int current = counter-1;
  while (current >= 0)
    {
      while (Arr[current] == x)
	{
	  Arr[current] = Arr[counter-1];
	  Arr[counter-1] = -1;
	  counter--;
	}
      heapify(current);
      current--;
    }
}

void Heap::levelorder()
{
  cout << "Level order:" << endl;
  int current = 0;
  int childofcur = 1;
  while (Arr[current]>0)
    {
      if (current == childofcur)
	{
	  cout << endl;
	  childofcur = (5*current)+1;
	}
      cout << Arr[current] << " ";
      if ((current % 5 == 0) && (current + 1 != childofcur) && (Arr[current+1]>0))
	{
	  cout << "- ";
	}
      current++;
    }
  cout << endl;
}
