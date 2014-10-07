#include <fstream>
#include <iostream>
#include "LinkedList.cpp"
using namespace std;

int main( int argc, const char* argv[] ) {


  LinkedList List{};
  cout << "List: ";
  List.print();
  List.erase(0,List);
  cout << "List after deleting 0: ";
  List.print();
  List.erase(21,List);
  cout << "List after deleting 21: ";
  List.print();
  List.insert(10,List);
  cout << "List after inserting 10: ";
  List.print();
  List.insert(21,List);
  cout << "List after inserting 21: ";
  List.print();
  List.insert(12, List);
  cout << "List after inserting 12: ";
  List.print();
  List.erase(8, List);
  cout << "List after deleting 8: ";
  List.print();

  return 0;
}
