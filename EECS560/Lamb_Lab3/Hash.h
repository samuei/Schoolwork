// Samuel Lamb
// 2118080

#ifndef HASH_H
#define HASH_H

class Hash
{
 private:
  int* table;
  int size;
  bool quad;
  bool* flag;
 public:
  Hash();
  Hash(int x, bool quadratic);
  ~Hash();
  void insert(int x);
  void recinsert(int x, int i);
  void remove(int x);
  void print();
  int hash(int x); 
  bool isFull();
  bool contains(int x);
};

#endif
