main: main.o FunMaze.o
	g++ -g -o main main.o FunMaze.o
main.o: FunMaze.h main.cpp
	g++ -g -c main.cpp
FunMaze.o: FunMaze.h FunMaze.cpp
	g++ -g -c FunMaze.cpp
