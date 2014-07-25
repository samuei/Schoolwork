#ifndef Manager_h
#define Manager_h
#include "Point2DArray.h"
#include <iostream>
#include <fstream>

class Manager
{
private:
	Point2DArray* Arr;
	double center[2];
public:
	Manager(std::ifstream &input);
	~Manager();
	void start();
};


#endif
