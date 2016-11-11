#ifndef EDGE_H
#define EDGE_H

#include "node.h"

class edge
{
 public:
  node* v1;
  node* v2;
  int value;
  edge();
  edge(node* x, node* y, int val);
  ~edge();
  void print();
};

#include "edge.cpp"

#endif
