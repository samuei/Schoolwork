#ifndef FUNMAZE_H
#define FUNMAZE_H

class FunMaze
{
private:
	char** maze;
	int dim1;
	int dim2;

public:
	FunMaze();
	~FunMaze();
	void readMaze(char* fileName);
	void solveMaze(int x, int y);
	void printMaze();
};

#endif