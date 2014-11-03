#include "iostream"
#include "Heap.h"

using namespace std;

int main()
{
  string input = "-1";
  Heap heap{};

  
  do
    {
      if ((input.compare("1")==0)||(input.compare("insert")==0))
	{
	  // INSERT
	  cout << "Please insert the number that you want to be inserted in the heap\n";
	  int temp;
	  cin >> temp;
	  heap.insert(temp);
	}
      else if ((input.compare("2")==0)||(input.compare("deletemin")==0))
	{
	  // DELETEMIN
	  heap.deletemin();
	}
      else if ((input.compare("3")==0)||(input.compare("deletemax")==0))
	{
	  // DELETEMAX
	  heap.deletemax();
	}
      else if ((input.compare("4")==0)||(input.compare("remove")==0))
	{
	  // REMOVE
	  cout << "Please insert the number that you want to be remove from the heap\n";
	  int temp;
	  cin >> temp;
	  heap.remove(temp);
	}
      else if ((input.compare("5")==0)||(input.compare("levelorder")==0))
	{
	  // LEVELORDER
	  heap.levelorder();
	}
      cout << "Please choose one of the following commands:\n1- insert\n2- deletemin\n3- deletemax\n4- remove\n5- levelorder\n6- exit\n";
      cin >> input;
    }
  while ((input.compare("6")!=0) && (input.compare("exit")!=0));
}
