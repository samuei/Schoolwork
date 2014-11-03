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
  Hash hash{y};
   while(!infile.getline(x,10,' ').eof()){
     istringstream iss(x);
     iss >> y;
     hash.insert(y);
   }
  infile.close();
  cout << "//print()" << endl;
  hash.print();
  cout << "//remove(17);remove(14);"<<endl;
  hash.remove(17);
  hash.remove(14);
  cout << "//print()" << endl;
  hash.print();
  cout << "//insert(2);insert(25);insert(13);" << endl;
  hash.insert(2);
  hash.insert(25);
  hash.insert(13);
  cout << "//print()" << endl;
  hash.print();
  
  return 0;
}
