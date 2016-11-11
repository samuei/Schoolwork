{{EECS560}}
__NOTOC__
===Lab Info===
* 80 points
* Due 11:59pm on Sunday 12/7/2014

==Assignment==
In this assignment you will work on designing a class for finding the Minimum Spanning Tree in a graph. For implementing Minimum Spanning Tree, Kruskal algorithm should be used. In Kruskal algorithm the edges are chosen from the smallest and add  to the structure. If by choosing an edge, a cycle occurs that edge will not be chosen. '''In order to find the cycles disjoint sets must be used and use path compression with union by rank.''' Also for choosing the smallest edge you need to sort the edges, any priority queue or sorting algorithm can be used.

The adjacency matrix should be read from the file data.txt. Then your program should output the edges which have been used to create the Minimum Spanning Tree. The first number in the file is the number of test cases, the next number shows the number of the nodes in the first graph and then you will have the adjacency matrix corresponding to the graph. '''A 0 in the adjacency matrix shows that there are no connection between the two nodes.'''


===Output===
data.txt elements : 

3

5

0     10    1   0   7

10     0    6   7   12

1      6    0   3   0

0      7    3   0   4

7     12   0   4    0

7

0   1   0   0   0   4   9

1    0   7  0   0   0   13

0    7   0   5  0   0   3

0   0   5   0   6   0   11

0   0   0   6   0   8   2

4   0   0   0   8   0   10

9   13  3 11  2  10  0

5

0   1   3   0   0  

1   0   2   0   0

3   2   0   6    4

0   0   6   0   5

0   0   4   5   0   

..........................................................

Output:

Graph1:

(0,2)  (1,2)  (2,3) (3,4)

Graph2:

(0,1)  (0,5)  (1,2)  (2,3)  (2,6)  (4,6)

Graph3:

(0,1)  (1,2)  (2,4)  (3,4)

'''// The order of the edges are not important'''

===Files===
* Files to include in folder:
** all source files
** a functioning  makefile</tt>
** <tt>data.txt</tt>
* Folder name: <tt>Lastname_Lab11</tt>
* Compressed file name: <tt>Lastname_Lab11.zip</tt> (or <tt>.rar</tt> or <tt>.tar.gz</tt>)
* Executable name: <tt>lab11</tt>
