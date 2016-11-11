

-1 is a reserved system integer and is not an acceptable key value for the table. Use of -1 may cause unexpected behavior.

{{EECS560}}
__NOTOC__
===Lab Info===
* 80 points
* Due 11:59pm on Sunday 9/21/2014
==Assignment==
In this assignment you will work on closed hashing with open addressing. You are to read in the numbers from a data file of integers. The first number is a prime number that shows the size of the hash table. The rest of the file contains the key numbers that should be inserted in the hash table. Use % ( mod) as the hash function. The file of numbers you read from will be data.txt. You may hard code the file name in your program if you wish. In This lab we will use both quadratic probing with hi(x) = (h(x) +i^2)% m and linear probing hi(x) = (h(x) +i)% m. Don't forget that the elements are key so there should not be any duplicate element in the hash table.
 
One important thing that you should pay attention when implementing closed hashing is when you want to remove an element. In this case we should differ from an empty bucket (no element has been placed in it during hashing) and a bucket that has become empty by deletion. To distinguish between these two situations we should use an extra flag field. When the flag is true it shows that the bucket is emptied by deletion and searching must continue. When the flag is false it means that the bucket was empty from the beginning of the hashing process so searching terminates.

In this lab we will not consider rehashing, but as you know in quadratic probing there may be some situations in which there are empty spaces in the hash table but insertion cannot be done. In this situation, the empty space in the hash table can be searched for K times and if an empty place cannot be found then an error message must be shown, this element must be ignored and next element should be inserted in the table. Consider K = length(hash table). '''Don't forget that when you want to insert an element into the hash table, first you have to search for it.'''


===Hash===
The methods that should be implemented are as follows: 
* <tt> insert(x) </tt> should insert x to the Hash table. Be careful that insert may sometimes fail even if the table is not full.  
* <tt> remove(x) </tt>   should remove the key from the hash table. 
* <tt> print () </tt> should print out all the elements of the hash table. 
* <tt> hash(x) </tt> Use hi(x) = (h(x) +i^2)% m for quadratic probing and hi(x) = (h(x) +i)% m for linear probing. 
* <tt> contains(x) </tt> return true if the key x is in the hash table and false if not. 
* <tt> isfull() </tt> return true if the hash table is full.

===Output===
file: 7 64 26 56 72 8 

output for quadratic:

0: 56  flag =false

1: 64  flag =false

2: 72  flag =false

3: 8   flag =false

4: -1  flag =false

5: 26  flag =false

6: -1  flag =false



// remove(26); 

0: 56  flag =false

1: 64  flag =false

2: 72  flag =false

3: 8   flag =false

4: -1  flag =false

5: -1  flag =true

6: -1  flag =false





//insert(36); insert(42);

Output:

0: 56  flag =false

1: 64  flag =false

2: 72  flag =false

3: 8   flag =false

4: 42  flag =false

5: 36  flag =false

6: -1  flag =false 


// contains(26) 26 is not in the table // contains 36 36 is in the table at index 5

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

Output for linear probing:

0: 56  flag =false

1: 64  flag =false

2: 72  flag =false

3: 8   flag =false

4: -1  flag =false

5: 26  flag =false

6: -1  flag =false



// remove(26); 

0: 56  flag =false

1: 64  flag =false

2: 72  flag =false

3: 8   flag =false

4: -1  flag =false

5: -1  flag =true

6: -1  flag =false


//insert(36); insert(42);

output:

0: 56  flag =false

1: 64  flag =false

2: 72  flag =false

3: 8   flag =false

4: 36  flag =false

5: 42  flag =false

6: -1  flag =false

// contains(26) 26 is not in the table // contains 36 36 is in the table at index 5

===Files===
* Files to include in folder:
** all source files
** a functioning <tt>makefile</tt>
** <tt>data.txt</tt>
* Folder name: <tt>Lastname_Lab3</tt>
* Compressed file name: <tt>Last_Lab3.zip</tt> (or <tt>.rar</tt> or <tt>.tar.gz</tt>)
* Executable name: <tt>lab3</tt>
