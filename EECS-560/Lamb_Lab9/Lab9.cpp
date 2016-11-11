#include <string>
#include <iostream>
#include <fstream>
#include "MMHeap.h"

using namespace std;

int main()
{
  string input = "";
  int temp;
   MMHeap Heap{};
   Heap.BottomUp();

  // MENU LOOP
  do
    {
      // 1-insert
	if (input.compare("1")==0 || input.compare("insert")==0)
	  {
	    cout << endl << "Please insert the number that you want inserted in the heap" << endl;
	    int filler;
	    cin >> filler;
	    Heap.insert(filler);
	  }
	// 2-deletemin
	if (input.compare("2")==0 || input.compare("deletemin")==0)
	  {
	    Heap.deletemin();
	  }
	// 3-deletemax
	if (input.compare("3")==0 || input.compare("deletemax")==0)
	  {
	     Heap.deletemax();
	  }
	// 4-levelorder
	if (input.compare("4")==0 || input.compare("levelorder")==0)
	  {

	    Heap.levelorder();
	    // Queue qbie{Heap.root};
	    // while (!(qbie.isEmpty()))
	    //   {
	    // 	qbie.remove();
	    //   }
	  }
        cout << endl << "Please choose one of the following commands:\n1-insert\n2-deletemin\n3-deletemax\n4-levelorder\n5-end\n";
	cin >> input;
    }
  while ((input.compare("5") != 0)&&(input.compare("end")!=0));
}
