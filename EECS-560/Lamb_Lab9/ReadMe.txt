{{EECS560}}

__NOTOC__
===Lab Info===

* 80 points
* Due 11:59pm on Sunday 11/16/2014.

==Assignment==
In this assignment you will work on designing a class for a Min-max Heap. You are to read in the numbers from a data file of integers and insert each number in a Min-max heap. Use the bottom-up method for building the heap (if not the results would be different). The file of numbers you read from will be data.txt. You may hard code the file name in your program if you wish. Duplicate numbers are allowed.

First you should make the tree by the samples which are in the data.txt, after that your program should have a simple menu like: 

Please choose one of the following commands: 

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

By inserting the appropriate number or typing the command (specify it), the command should be applied to the tree. The command insert will also need a number to be inserted. 

The paper for min-max is here: [http://people.eecs.ku.edu/~mhajiarb/minmax1.pdf min-max]

The min-max heap will be discussed in the lab.

The function TrickleDown should be used for building the heap (bottom up approach, delete min and delete max) and the function BubbleUp should be used for insert.

'''important:''' In case that a node has just 2 children for finding the min (or max) we have to look at the children and the grand children. consider this example

      \
      4            min
   /     \
  20       10       max
  /   \     
 19  16             min


This tree is a part of heap, if we have used the trickledown and 4 have been replaced by 30 then the heap becomes like this 

      \
      30            min
   /     \
  20       10       max
 /   \     
 19  16             min

30 is on the min level, so now 10 should be replaced with 30 (10 is children , here shows the case that a child may be used instead of grand children) the new heap will be:


       \
      10            min
    /     \
  20       30       max
 /   \     
 19  16             min


Start from the index one of the array (discard zero), in that case the min and max nodes can be find as below:

Min node: floor(lg(i)) = even

Max node: floor(lg(i)) = odd

===Min-max Heap===

The Min-max Heap methods should be implemented as follows: 
* <tt> insert(x) </tt> should insert x in the Min-max Heap. 
* <tt> deletemin() </tt>  should delete the smallest value from the Min-max Heap.
* <tt> deletemax() </tt>  should delete the largest value from the Min-max Heap.
* <tt> levelorder() </tt> should print out all the elements of the Min-max Heap using level order traversal.

===Output===

data.txt elements : 6 8 5 2 7 10 3 9 12 1

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 4

Level order:  

1 

12 10 

2 6 5 3 

9 8 7

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 2

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 4

level order:   

2 

12 10 

7 6 5 3 

9 8


..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 3

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 4

level order:  

2 

9 10 

7 6 5 3 

8 


..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 1

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 20

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 15

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 30

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 12

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 13

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 

> 1

Please insert the number that you want to be inserted in the tree

> 14

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 


> 4

level order:  

1 

20 30 

2 6 5 3 

8 7 9 15 10 12 13 14

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit
 

> 2

..........................................................

Please choose one of the following commands:

1- insert 

2- deletemin 

3- deletemax 

4- levelorder 

5- exit 


> 4

level order:  

2 

20 30 

7 6 5 3 

8 14 9 15 10 12 13

===Files===

* Files to include in folder:
** all source files
** a functioning <tt>makefile</tt>
** <tt>data.txt</tt>
* Folder name: <tt>Lastname_Lab9</tt>
* Compressed file name: <tt>Lastname_Lab9.zip</tt> (or <tt>.rar</tt> or <tt>.tar.gz</tt>)
* Executable name: <tt>lab9</tt>
