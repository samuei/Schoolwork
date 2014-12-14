#include <iostream>
using namespace std;


edge::edge()
{

}

edge::edge(node* x, node* y, int val)
{
  v1 = x;
  v2 = y;
  value = val;
}

edge::~edge()
{

}


void edge::print()
{
  cout << "(" << v1->num << ","<<v2->num<<")";
}
