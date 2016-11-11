#ifndef OPERATION_H
#define OPERATION_H

#include <string>

class operation{
 public:
  operation();
  ~operation();
  std::string op;
  std::string destination;
  std::string operand1;
  std::string operand2;
  int IF,ID,EXbeg,EXend;
};

#include "operation.cpp"

#endif
