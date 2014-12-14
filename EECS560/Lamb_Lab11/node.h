#ifndef NODE_H
#define NODE_H

class node{
 public:
  node();
  node(int number);
  ~node();
  node* parent;
  int rank;
  int num;
  node* find();
  bool unionbyr(node* x, node* y);
};

#include "node.cpp"

#endif
