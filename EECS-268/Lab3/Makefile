all: Main.o Point2DArray.o
	g++ -g -Wall Main.o Point2DArray.o -o Lab3
Main.o: Main.cpp
	g++ -g -Wall -c Main.cpp
Manager.o: Manager.cpp
	g++ -g -Wall -c Manager.cpp
Point2DArray.o: Point2DArray.cpp
	g++ -g -Wall -c Point2DArray.cpp
clean: 
	rm *.o
