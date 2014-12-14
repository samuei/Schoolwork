#ifndef MMHEAP_H
#define MMHEAP_H

class MMHeap
{
 private:
 public:
  int Heap[400001];
  MMHeap();
  ~MMHeap();
  void BottomUp();
  void Trickledown(int i);
  void Trickledownmin(int i);
  void Trickledownmax(int i);
  void Bubbleup(int i);
  void Bubbleupmin(int i);
  void Bubbleupmax(int i);
  void levelorder();
  void deletemax();
  void deletemin();
  void insert(int x);
};

#include "MMHeap.cpp"

#endif
