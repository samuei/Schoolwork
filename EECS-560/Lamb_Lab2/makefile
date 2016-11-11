Lab2: Lab2.o
	g++ -o Lab2 Lab2.o
Lab2.o: Lab2.cpp Hash.h Hash.cpp LinkedList.h LinkedList.cpp Node.h Node.cpp
	g++ -g -c -std=c++11 Lab2.cpp
	g++ -g -c -std=c++11 Hash.cpp
	g++ -g -c -std=c++11 LinkedList.cpp
	g++ -g -c -std=c++11 Node.cpp
clean:
	rm -f *.o *~ Lab2
