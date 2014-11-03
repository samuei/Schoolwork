{{EECS560}}
__NOTOC__
===Lab Info===
* 60 points
* Due 11:59pm, Sunday, 9/14/2014.

==Assignment==
In this assignment you will work on open hashing with chaining. You are to read in the numbers from a data file of integers. The first number, is a prime number that shows the size of the hash table. The rest of the file contains the '''key numbers''' that should be inserted in the hash table. Because the numbers are key so there shouldn't be any duplicate numbers in the hash table. Use %(mod) as the hash function. The file of numbers you read from will be data.txt. You may hard code the file name in your program if you wish.

==Hash==
The Hash should implement an appropriate constructor and destructor. The rest of the methods should be implemented as follows: 
*insert(x) should insert x to the Hash table. insert must be done at the end of the chain. 
*remove(x) should remove the key from the hash table. 
*print() should print out all the elements of the hash table. Each chain must be separated by a space and ending with an endl. 
*hash(x) Use % (mod) as the hash function and return the index for key x. 
*find(x) return true if the key x is in the hash table and false if not.

==Output==
Consider that the data.txt is as below:
5 16 12 17 4 2 16 14 12 3 8 15
As mentioned the first number (here 5, but can be any prime number) shows the prime number that is needed for the has function, so the output list would be:

//print()

0: 15

1: 16

2: 12 17 2 

3: 3 8 

4: 4 14 

// remove(17); remove(14);

// print();

0: 15

1: 16

2: 12 2

3: 3 8

4: 4

// insert(2); insert(25); insert(13);

// print();

0: 15 25

1: 16

2: 12 2

3: 3 8 13

4: 4

===Files===
* Files to include in folder:
** all source files
** a functioning <tt>makefile</tt>
** <tt>data.txt</tt>
* Folder name: <tt>Lastname_Lab2</tt>
* Compressed file name: <tt>Lastname_Lab2.zip</tt> (or <tt>.rar</tt> or <tt>.tar.gz</tt>)
* Executable name: <tt>lab2</tt>
