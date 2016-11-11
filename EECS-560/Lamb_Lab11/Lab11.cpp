#include <iostream>
#include <fstream>
#include <string>
#include "krus.h"

using namespace std;

int main()
{
  ifstream infile("data.txt");
  cout << "data.txt elements: "<<endl;
  string temp;
  int numcases;
  infile >> numcases;
  cout << numcases<<endl;
  krus graph[numcases];
  for(int i = 0; i<numcases;i++)
    {
      int base;
      infile >> base;
      cout << base << endl;
      graph[i] = krus(base);
      getline(infile, temp);
      for (int j = 0; j<base;j++)
	{
	  getline(infile, temp);
	  cout << temp << endl;
	  graph[i].init(temp);
	}
    }
  cout << ".........................................................."<<endl<<"Output:"<<endl;
  for (int k = 0; k<numcases;k++)
    {
      cout << "Graph" << k+1 <<":"<<endl;
      graph[k].kruskal();
    }
}
