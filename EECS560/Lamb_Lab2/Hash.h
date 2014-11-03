#ifndef HASH_H
#define HASH_H

class Hash
{
 private:
  LinkedList* table;
  int size;
 public:
  Hash();
  Hash(int x);
  ~Hash();
  void insert(int x);
  void remove(int x);
  void print();
  int hash(int x);
  bool find(int x);  
};

#endif
