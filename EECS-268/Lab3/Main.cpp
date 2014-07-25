// Samuel Lamb
// 2118080

#include "Manager.cpp"
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

// Opens the stream, creates a Manager, runs that Manager, cleans up, and then it's done.
int main(int argc, char* argv[])
{
	ifstream inp(argv[1]);
	Manager mgr(inp);
	mgr.start();
	inp.close();
	return 0;
}
