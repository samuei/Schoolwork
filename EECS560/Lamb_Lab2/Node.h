#ifndef NODE_H
#define NODE_H

using namespace std;

class Node
{
 public:
  Node();
  Node(int& item);
  ~Node();
  int data;
  Node* next;
  void print();
  void insert(int x);
  Node* find(int x, Node* prevptr);
  bool erase(Node* desired, Node* prevptr);
};

#endif
