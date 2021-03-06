// Samuel Lamb
// 2118080
#include "Node.cpp"
#include "LinkedList.h"

using namespace std;

// Constructor
LinkedList::LinkedList()
{
  Node *curptr = nullptr;
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
void LinkedList::insert(int x, LinkedList& L)
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
  return (headptr == nullptr);
}

// erase
 string LinkedList::erase(int x, LinkedList& L)
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
  if (headptr != nullptr){
    headptr->print();
  }
  else
    {
      cout << endl;
    }
}

// Find
// Returns nullptr if x is not in the list.
Node* LinkedList::find(int x, LinkedList& L)
{
  if(!L.isEmpty())
    {
      return headptr->find(x,headptr);
    }
}
