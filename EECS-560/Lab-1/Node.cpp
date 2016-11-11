#include "Node.h"
#include <iostream>

// Default constructor. Do not use.
Node::Node()
{

};

// Preferred constructor.
Node::Node(int& item)
{
  this->data = item;
  this->next = nullptr;
}

// Destructor
Node::~Node()
{
}

void Node::print()
{
  // Pretty formatting:
  cout << this->data << " ";
  // Is there more list?
  if (this->next != nullptr)
    {
      // Then keep going
      this->next->print();
    }
  else
    {
      // More formatting:
      cout << endl;
    }
}

void Node::insert(int x)
{
  if (x != this->data)
    {
      if (this->next != nullptr)
	{
	  this->next->insert(x);
	}
      else
	{
	  this->next = new Node(x);
	}
    }
}


Node* Node::find(int x, Node* prevptr)
{
  if (this->data == x)
    {
      return prevptr;
    }
  else if (this->next != nullptr)
    {
      return this->next->find(x, this->next);
    }
  else {
    return nullptr;
  }
}

bool Node::erase(Node* desired, Node* prevptr)
{
  if(this->next == desired)
    {
      this->next = this->next->next;
      delete desired;
      return true;
    }
  else {
    return this->next->erase(desired,this->next);
  }
}
