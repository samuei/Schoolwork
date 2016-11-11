// Samuel Lamb
// 2118080
#include <string>
#include <fstream>
#include <sstream>
#include <cstddef>
#include "Hash.cpp"
#include <iostream>

using namespace std;

int main(){
  ifstream infile;
  infile.open("data.txt");
  char x[10];
  int y;
// First int is the size of the hash table.
  infile.getline(x,10,' ');
  istringstream iss1(x);
  iss1 >> y;
  Hash hash(y, true);
  Hash hash2(y, false);
  cout << "file: " << y;
   while(!infile.getline(x,10,' ').eof()){
     istringstream iss(x);
     iss >> y;
     cout << " " << y;
     hash.insert(y);
	 hash2.insert(y);
   }
   cout << endl << "output for quadratic:" << endl;
  infile.close();
  hash.print();
  hash.remove(26);
  cout << endl<<"//remove(26);"<<endl;
  hash.print();
  hash.insert(36);
  hash.insert(42);
  cout <<endl<< "//insert(36); insert(42);"<<endl;
  hash.print();

  cout<<endl<<"//contains(26) ";
  if(hash.contains(26))
    {
      cout<<"26 is in the table at index "<<hash.hash(26);
    }
  else
    {
      cout << "26 is not in the table ";
    }
  cout<<"contains(36) ";
  if(hash.contains(36))
    {
      cout<<"36 is in the table at index "<<hash.hash(36);
    }
  else
    {
      cout<< "36 is not in the table ";
    }

  cout<<endl<<"////////////////////////////////////"<<endl;
  cout << "Output for linear probing:" << endl;
  hash2.print();
  hash2.remove(26);
  cout << endl << "//remove(26);" << endl;
  hash2.print();
  hash2.insert(36);
  hash2.insert(42);
  cout << endl << "//insert(36); insert(42);" << endl;
  hash2.print();

  cout << endl << "//contains(26) ";
  if (hash2.contains(26))
  {
	  cout << "26 is in the table at index " << hash2.hash(26);
  }
  else
  {
	  cout << "26 is not in the table ";
  }
  cout << "contains(36) ";
  if (hash2.contains(36))
  {
	  cout << "36 is in the table at index " << hash2.hash(36) << endl;
	  cout << "Actually, since I have your attention, the website says it is in index 5. That's clearly incorrect. You might want to change that." << endl;
  }
  else
  {
	  cout << "36 is not in the table.";
  }


  return 0;
}
