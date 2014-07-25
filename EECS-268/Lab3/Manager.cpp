#include "Manager.h"
using namespace std;

	// Constructor: Takes a stream, gives an array of 2D Points
Manager::Manager(std::ifstream &input)
{
	Arr = new Point2DArray(input);
}

	// Destructor. Danger, hazardous materials.
Manager::~Manager()
{
	delete Arr;
}

	// Prints the points, calculates and prints the centroid and length, then cleans up.
void Manager::start()
{
	Arr->print(cout);
	cout << "\n";
	cout << "Centroid: ";
	Arr->centroid(center);
	cout << center[0] << ", " << center[1];
	cout << "\n";
	cout << "Length: " << Arr->length();
}
