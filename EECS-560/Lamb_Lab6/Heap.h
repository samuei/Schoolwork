#ifndef HEAP_H
#define HEAP_H

#include <fstream>
#include <iostream>
#include <cmath>

class Heap
{
 private:
 public:
  int Arr[500];
  int counter;
  Heap();
  ~Heap();
  int heapify(int x);
  void insert(int x);
  void deletemin();
  void deletemax();
  void remove(int x);
  void levelorder();
};

#include "Heap.cpp"

#endif
