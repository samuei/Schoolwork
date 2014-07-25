#ifndef Point2DArray_h
#define Point2DArray_h
#include <iostream>
#include <ostream>
#include <fstream>
#include <string>

typedef double Point2D[2];

class Point2DArray
{
private:
	Point2D* pts;
	Point2D* buff;
	int arraySize, numPoints;
public:
	Point2DArray(std::ifstream &input);
	~Point2DArray();
	void centroid(Point2D &in);
	double length();
	void print(std::ostream &output);
};

#endif
