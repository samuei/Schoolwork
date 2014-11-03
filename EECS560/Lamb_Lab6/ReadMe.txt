{{EECS560}}

===Lab Info===
* 80 points
* Due 11:59pm on Sunday 10/12/2014.

==Assignment==
In this assignment you will work on designing a class for a Min 5-Heap. You are to read in the numbers from a data file of integers and insert each number in a Min 5-heap. 
In Min 5-Heap:

1- Root of T is at A[0].

2- Parent of A[i] is at A[floor((i-1)/5)] if exists.

3- The j''th'' child of A[i] is at A[5i+j]     1<= j <=5 if exist.

'''Use the bottom-up method for building the heap''' (if not the results would be different, for bottom up approach put all the elements in the heap and then try to heapify starting from the last parent, continue heapifying towards the root). The file of numbers you read from will be data.txt. You may hard code the file name in your program if you wish. 
In this lab like Lab5, first you should make the heap by the samples which are in the data.txt, after that your program should have a simple menu like: 
Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit


by inserting the appropriate number or typing the command (specify it), the command should be applied
to the tree. The commands insert and remove will also need a number to be inserted or removed.

'''Take the size of the array 500'''. Heap can have duplicate numbers, so when you want to remove am element , '''You have to remove all the duplicates elements from the heap. For deletemin and deletemax just delete one element from the heap'''. '''The max element is in one of the leaves and the index of the first leaf can be found using  A[floor((last used index in array-1)/5) + 1].'''

===Min 5-Heap===
The Min 5-Heap methods should be implemented as follows:

* insert(x) should insert x in the Min 5-Heap.
* deletemin() should delete the smallest value from the Min 5-Heap.
* deletemax() should delete the smallest value from the Min 5-Heap.
* remove(x) should remove x from the Min 5-Heap
* levelorder() should print out all the elements of the Min 5-Heap (We have called it level order but it is simply printing out the elements of the array).

===Output===
data.txt elements : 100 205 150 44 95 117 402 317 82 66 11 17 1 70 87 99

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit


> 5

Level order:

1

11 17 44 95 117

402 317 82 66 205   -  100 150 70 87 99         

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>2

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>5

Level order:

11

66 17 44 95 117

402 317 82 99 205 - 100 150 70 87 

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>2

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>5

Level order:

17

66 70 44 95 117

402 317 82 99 205 - 100 150 87

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>1

Please insert the number that you want to be inserted in the heap

>2
 
..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>5

Level order:

2

66 17 44 95 117

402 317  82 99 205 - 100 150 87 70

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>3

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>5

Level order:

2

66 17 44 95 117

70 317  82 99 205 - 100 150 87 

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>4

Please insert the number that you want to remove from the 5-Heap

>66

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>5

Level order:

2

70 17 44 95 117

87 317  82 99 205 - 100 150

..........................................................

Please choose one of the following commands:

1- insert

2- deletemin

3- deletemax

4- remove

5- levelorder

6- exit

>6

===Files===
* Files to include in folder:
** all source files
** a functioning <tt>makefile</tt>
* Folder name: <tt>Lastname_Lab6</tt>
* Compressed file name: <tt>Lastname_Lab6.zip</tt> (or <tt>.rar</tt> or <tt>.tar.gz</tt>)
* Executable name: <tt>lab6</tt>
