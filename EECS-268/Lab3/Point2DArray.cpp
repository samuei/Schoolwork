#include <cmath>
#include "Point2DArray.h"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
using namespace std;

	// Constructor builds the array from an input stream.
Point2DArray::Point2DArray(ifstream &input)
{
	numPoints = 0;
	// initial size is gotten from the file
	input >> arraySize;
	
	// If the file is naughty, this code scolds the user
	while (arraySize <= 0)
	{
		cout << "File estimates no elements.\nYour file is bad and you should feel bad.\n";
		arraySize = 1;
	}
	double temp;
	// the pts array is made on the heap
	pts = new Point2D[arraySize];
	// the first entry is taken, followed by a loop for any subsequent points
	input >> pts[0][0];
	input >> pts[0][0];
	while (input >> temp)
	{
		numPoints++;
		// before the points are assigned, this loop checks to see if there's room at the inn.
		// else (manger)
		if (numPoints >= arraySize)
		{
			// Despite its name, the buff array is actually a little flabby. We still love it, though.
			// It's here to store the new values so pts doesn't lose them
			Point2DArray::buff = new Point2D[(arraySize*2)];
			for (int i = 0; i < arraySize; i++)
			{
				buff[i][0] = pts[i][0];
				buff[i][1] = pts[i][1];
			}
			delete [] pts;
			pts = buff;
			arraySize += arraySize;
			// Then we just throw it away, like an old shoe
			buff = NULL;
			delete [] buff;
		}
		// Finally, pts gets its new value
		pts[numPoints][0] = temp;
		input >> pts[numPoints][1];
	}	
}

// Deconstructor. Danger: Men at Work.
Point2DArray::~Point2DArray()
{
	delete pts;
}

// Centroid takes an external set of doubles and magically turns them into the average of the above array
void Point2DArray::centroid(Point2D &in)
{
	in[0] = 0.0;
	in[1] = 0.0;
	for (int i = 0; i < numPoints; i++)
	{
		in[0] += pts[i][0];
		in[1] += pts[i][1]; 
	}
	in[0] = (in[0]/numPoints);
	in[1] = (in[1]/numPoints);
}

// Length is, ironically enough, the shortest of these methods. It does what it says on the tin.
double Point2DArray::length()
{
	double length = 0, x = 0, y = 0;
	for (int i = 0; i < numPoints; i++)
	{
		x += pts[i][0];
		y += pts[i][1];
	}
	length = sqrt ((x*x)+(y*y));
	return length;
}

// Print, as you might expect, prints the values of the array.
void Point2DArray::print(ostream &output)
{
	int ln = 0;
	for (int i = 0; i < numPoints; i++)
	{
		ln++;
		output << pts[i][0] << ", " <<pts[i][1];
		if (ln >= 1)
		{
			output << "\n";
			ln = 0;
		}
	}
}
