#ifndef LINKEDLIST_H
#define LINKEDLIST_H

class LinkedList
{
 private:

 public:
  Node* headptr;
  LinkedList();
  // LinkedList(std::ifstream& infile);
  ~LinkedList();
  void insert(int x,LinkedList L);
  bool isEmpty();
  string erase(int x, LinkedList L);
  void print();
  Node* find(int x,LinkedList L);
};

#endif
