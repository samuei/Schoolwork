#ifndef KRUS_H
#define KRUS_H

#include "edge.h"
#include <sstream>
#include <string>
#include <iostream>

class krus
{
 public:
  int base;
  edge* edges;
  node** nodes;
  int numdone;
  krus();
  krus(int numelements);
  ~krus();
  void init(string costs);
  void sort();
  void kruskal();
};

#include "krus.cpp"

#endif
