{{EECS560}}
__NOTOC__
===Lab Info===
* 50 points
* Due 11:59pm, Sunday, 8/31/2014.

==Assignment==
In this assignment you will work on a singly linked list (The goal of this lab is to review pointers and recursion). You have to implement the specified functions using recursion. You are to read in the numbers from a data file of integers, one at a time, and put each number, as it is read, into a node of a singly linked list. (You may not store all of the numbers in a vector or array; the list must be built as you read in the numbers.) Then, you are to do at least 3 insertion and 3 deletion from the list. The file of numbers you read from will be data.txt. You may hard code the file name in your program if you wish.

Print out the list contents after you have completed building the list and again after each operation. Be sure to label your output. When you are finished, submit the final project along with a makefile so that we may build an executable and run your code. Make sure to zip or tar.gz everything together.

==List==
The List should implement an appropriate constructor and destructor. The rest of the methods should be implemented as follows:
*insert(x,L)  Insert x recursively into a list L if x does not exist. insertion should be done at the end of the list.
*isEmpty() should return true if L is empty.
*erase(x,L) Use Find(x,L) to remove x from L if found; else, return message.
*print() should print out all the elements of the list separated by a space and ending with an endl.
*Find(x,L) Search for x in L recursively and return a pointer pointing at x.

==Output==
List :17 19 11 0 3 5 8 13 21 37 55

List after deleting 0 : 17 19 11 3 5 8 13 21 37 55

List after deleting 21 : 17 19 11 3 5 8 13 37 55

List after inserting 10 : 17 19 11 3 5 8 13 37 55 10 

List after inserting 44 : 17 19 11 3 5 8 13 37 55 10 44

List after inserting 12 : 17 19 11 3 5 8 13 37 55 10 44 12

List after deleting 8: 17 19 11 3 5 13 37 55 10 44 12


===Files===
* Files to include in folder:
** all source files
** a functioning <tt>makefile</tt>
** <tt>data.txt</tt>
* Folder name: <tt>Lastname_Lab1</tt>
* Compressed file name: <tt>Lastname_Lab1.zip</tt> (or <tt>.rar</tt> or <tt>.tar.gz</tt>)
* Executable name: <tt>lab1</tt>
