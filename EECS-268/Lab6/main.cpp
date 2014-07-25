#include <iostream>
#include <cstdlib>

#include "FunMaze.h"

//Assume that the starting position is always [1][1]
#define START_DIM_1	1
#define START_DIM_2	1

int main(int argc, char* argv[])
{
	FunMaze maze;

	if( argc != 2)
	{
		std::cout << "One argument required: name of maze input file\n";
		exit(1);
	}

	maze.readMaze(argv[1]);
	maze.solveMaze(START_DIM_1, START_DIM_2);
}

	
