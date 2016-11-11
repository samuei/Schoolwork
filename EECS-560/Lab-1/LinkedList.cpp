#include <string>
#include "Node.cpp"
#include "LinkedList.h"
#include <fstream>
#include <sstream>
#include <cstddef>
#include <iostream>
using namespace std;

// Constructor
// As specified, filename "data.txt" is hard-coded.
LinkedList::LinkedList()
{
  Node *curptr = nullptr;
  ifstream infile;
  infile.open("data.txt");
  /* As you can tell, file io is not my strong suit.
     If you have any suggestions on better ways to do this, I would be
     very happy to hear them. This works, but is very ugly. */
  char x[10];
  int y;
  // First element is a special case, because of headptr
  infile.getline(x,10,' ');
  istringstream iss1(x);
  iss1 >> y;
  headptr = new Node(y);
  Node *prevptr = headptr;
  curptr = headptr->next;
  /* Neither the constructor nor the destructor were specified as needing to be
     recursive, and since this is already gross to get through (see above), I
     decided not to risk it. */
  while(!infile.getline(x,10,' ').eof()){
    istringstream iss(x);
    iss >> y;
    curptr = new Node(y);
    prevptr->next = curptr;
    prevptr = curptr;
    curptr = curptr->next;
  }
  infile.close();
}

// Destructor
LinkedList::~LinkedList()
{
  // Erases the first element over and over until there's nothing left.
  while(headptr!=nullptr)
    {
      this->erase(headptr->data,*this);
    }
}

// Insert
void LinkedList::insert(int x, LinkedList L)
{
  if (!L.isEmpty())
    {
      headptr->insert(x);
    }
  else {
    Node* newd = new Node(x);
    headptr = newd;
  }
}

// isEmpty
bool LinkedList::isEmpty()
{
  return headptr = nullptr;
}

// erase
 string LinkedList::erase(int x, LinkedList L)
 {
   if(!L.isEmpty())
     {
       Node* desired = this->find(x,L);
       if(headptr == desired)
	 {
	   headptr = headptr->next;
	   delete desired;
	   return "Operation performed successfully.";
	 }
       else  if(headptr->erase(desired, headptr))
	 {
	   return "Operation performed successfully.";
	 }
       else
	 {
	   return "Integer not in List. No operations performed.";
	 }
     }
   else
     {
       return "List empty. No operations performed.";
     }
 }

// Print
void LinkedList::print()
{
  headptr->print();
}

// Find
// Returns nullptr if x is not in the list.
Node* LinkedList::find(int x, LinkedList L)
{
  if(!L.isEmpty())
    {
      return headptr->find(x,headptr);
    }
}
