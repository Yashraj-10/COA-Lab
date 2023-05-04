#-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Computer Organization and Architecture Laboratory
# Assignment No. 3 (MIPS)
# Problem No. 3
# Autumn Semester 2022
# Group No - 24
# Yashraj Singh - 20CS10079
# Vikas Vijaykumar Bastewad - 20CS10073
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Data Segment
    .data

array: 
    .space 40                                                   # creating space for the array with 10 integer elements

prompt1:
    .asciiz "Please enter array element "

prompt2:
    .asciiz "Sorted array: "

prompt3:
    .asciiz "Enter number to be searched: "

prompt4:
    .asciiz " NOT FOUND in the array."

prompt5:
    .asciiz " FOUND in array at index "

fullStop:
    .asciiz "."

colon:
    .asciiz ":"

newline:
    .asciiz "\n"

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Code Segment------------------------------------------------------------------------------------------------------------------------------------------------------- 
    .text
    .globl main

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Main function------------------------------------------------------------------------------------------------------------------------------------------------------ 
main:
    addi    $sp, $sp, -4                                        # making space for storing frame pointer
    sw      $fp, 0($sp)                                         # storing old frame pointer
    move    $fp, $sp                                            # setting frame pointer
    
    li      $s0, 10                                             # initialise array length to 10
    
    li      $t0, 0                                              # i = 0

    # calling function to read the array from user
    jal     read
    
    # prompting user to enter the key
    li      $v0, 4
    la      $a0, prompt3
    syscall
   
    # inputting key from the user
    li      $v0, 5
    syscall
    move    $s1, $v0

    la      $a0, array                                          # loading array address in $a0
    li      $a1, 0                                              # $a1 <- 0, start=0
    li      $a2, 9                                              # $a2 <- 9, end=9
   
    # calling function to sort the array
    jal     recursive_sort                                      # calling recursive sort with arguments: array, start(=0) and end(=9)

    # Calling the print functions to print the sorted array
    li      $v0, 4                                              # printing prompt2 i.e. "Sorted array: "
    la      $a0, prompt2
    syscall

    la      $a0, array                                          # loading base address of array in $a0
    move    $a1, $s0                                            # storing array_length in $a1

    # calling function to print sorted array
    jal     print      

    la      $a0, array                                          # loading base address of array in $a0
    li      $a1, 0                                              # $a0<- start index
    li      $a2, 9                                              # $a1<- end index
    move    $a3, $s1                                            # $a3<- key

    jal     recursive_search					# calling recursive_search with parameters A, start(0), end(9), key

    move    $s2, $v0
    li      $t9, -1
    beq     $s2, $t9, notFound					# branching to notFound block when the key is not found

    move    $a0, $s1
    move    $a1, $s2
    jal     Found						# jumping to Found when key is found and with key value and index as arguments 

    lw      $fp, 0($sp)                                         # restoring the frame pointer
    addi    $sp, $sp, 4                                         # restoring the stack pointer

    li      $v0, 10                                             # terminating the program execution
    syscall

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Function to input array from user---------------------------------------------------------------------------------------------------------------------------------- 
read:
    li      $v0, 4                                              # printing prompt1  "Please enter array element "
    la      $a0, prompt1
    syscall

    srl     $t9, $t0, 2						# calculating index
    addi    $t9, $t9, 1						# coverting the 0-based index to element number, ie, 1-based indexing

    li      $v0, 1                                              # printing the element number to be inputted
    move    $a0, $t9
    syscall

    li      $v0, 4                                              # printing colon 
    la      $a0, colon
    syscall
    
    li      $v0, 11                                             # printing space character
    li      $a0, 32                                             # loading sapace character in $a0
    syscall

    li      $v0, 5                                              # taking input from user 
    syscall   

    sw      $v0, array($t0)                                     # storing array element 

    addi    $t0, $t0, 4                                         # i++       
    bne     $t0, 40, read                                 	# if i<10 then continue the read loop

    jr      $ra

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Function group to print the sorted array--------------------------------------------------------------------------------------------------------------------------- 
print: 
    li      $t0, 0                                              # i = 0
    li      $t2, 0                                              # offset = 0
    move    $s0, $a0                                            # moving base address of array to $s0

printFor:
    bge     $t0, $a1, endPrint                                  # branching if i>=n 
    add     $t1, $s0, $t2                                       # $t1 = array base address + 4*i
    lw      $t1, 0($t1)                                         # load array[i] in $t1
    addi    $t2, $t2, 4                                         # offset = offset + 4
    
    li      $v0, 1                                              # printing array[i]
    move    $a0, $t1                                            # $a0 <= array[i]
    syscall             

    li      $v0, 11                                             # printing space character
    li      $a0, 32                                             # loading sapace character in $a0
    syscall

    addi    $t0, $t0, 1                                         # i++
    b       printFor                                		# continue the printFor

endPrint:
    li      $v0, 4                                              # printing newline
    la      $a0, newline
    syscall

    jr      $ra                                                 # return from endPrint procedure 

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Function to execute when key is found------------------------------------------------------------------------------------------------------------------------------ 
Found:
    li      $v0, 1				# printing the key 
    move    $a0, $s1
    syscall

    li      $v0, 4				# printing prompt5
    la      $a0, prompt5
    syscall

    li      $v0, 1				# printing index at which key is found
    move    $a0, $s2
    syscall

    li      $v0, 4				# printing full stop
    la      $a0, fullStop
    syscall

    jr      $ra					# jumping back to from where the Found function was called

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Function to execute when key is not found-------------------------------------------------------------------------------------------------------------------------- 
notFound:
    li      $v0, 1				# printing the key which is not found
    move    $a0, $s1
    syscall

    li      $v0, 4				# printing prompt4
    la      $a0, prompt4
    syscall

    # Exiting the program from here only when key is not found

    lw      $fp, 0($sp)                                         # restoring the frame pointer
    addi    $sp, $sp, 4                                         # restoring the stack pointer

    li      $v0, 10                                             # terminating the program execution
    syscall

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Function group to sort the array recursively-----------------------------------------------------------------------------------------------------------------------

# base address of array A : $a0
# l: $s0
# r: $s1
# p: $s2
# left: $a1
# right: $a2

recursive_sort:
    move    $t0, $ra                                            # storing $ra in t0

    # intializing the frame and stack pointer
    addi    $sp, $sp, -4
    sw      $fp, 0($sp)
    move    $fp, $sp
   
    move    $t1, $a0                                            # store array address temporarily
    
    # pushing existing $ra to stack, it will be stored at position $fp-4
    move    $a0, $t0
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    
    # pushing existing $s0 to stack, it will be stored at position $fp-4
    move    $a0, $s0
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    
    # pushing existing $s1 to stack, it will be stored at position $fp-4
    move    $a0, $s1
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    
    # pushing existing $s2 to stack, it will be stored at position $fp-4
    move    $a0, $s2
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    
    # pushing array address to stack, it will be stored at position $fp-4
    move    $a0, $t1
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    
    # pushing start index/left to stack, it will be stored at position $fp-4
    move    $a0, $a1
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
    
    # pushing end index/right to stack, it will be stored at position $fp-4
    move    $a0, $a2
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)
   
    move    $a0, $t1                                            # restoring array address

    move    $s0, $a1                                            # l <- left
    move    $s1, $a2                                            # r <- right
    move    $s2, $a1                                            # p <- left

outerWhile:
    slt     $t0, $s0, $s1                                       # set $t0 = 1 if l<r
    beq     $t0, $zero, returnSort                              # returning when l>=r else going to the innerWhileLeft function

innerWhileLeft:
    sll     $t0, $s0, 2                                         # $t0 <- 4*l
    add     $t0, $a0, $t0                                       # $t0 <- A + 4*l
    lw      $t0, 0($t0)                                         # $t0 <- A[l]

    sll     $t1, $s2, 2                                         # $t1 <- 4*p
    add     $t1, $a0, $t1                                       # $t1 <- A + 4*p
    lw      $t1, 0($t1)                                         # $t1 <- A[p]

    bgt     $t0, $t1, innerWhileRight                           # if A[l] > A[p] then break this loop and go to the innerWhileRight loop
    bge     $s0, $a2, innerWhileRight                           # if l >= right then break this loop and go to the innerWhileRight loop
    addi    $s0, $s0, 1                                         # l++, incrementing l
    b       innerWhileLeft                                      # continuing the innerWhileLeft loop

innerWhileRight:
    sll     $t0, $s1, 2                                         # $t0 <- 4*r
    add     $t0, $a0, $t0                                       # $t0 <- A + 4*r
    lw      $t0, 0($t0)                                         # $t0 <- A[r]

    sll     $t1, $s2, 2                                         # $t1 <- 4*p
    add     $t1, $a0, $t1                                       # $t1 <- A + 4*p
    lw      $t1, 0($t1)                                         # $t1 <- A[p]

    blt     $t0, $t1, innerIf                                   # if A[r] < A[p] then break this loop and go to the if condition
    ble     $s1, $a1, innerIf                                   # if r <= left then break this loop and go to the if condition
    addi    $s1, $s1, -1                                        # r--, decrementing r
    b       innerWhileRight                                     # continue the innerWhileRight loop

innerIf:
    blt     $s0, $s1, outerSwap                                 # if l < r then go to outerSwap to swap A[l] and A[r]
 
    # swap A[p] and A[r]
    move    $a1, $s2                                            # $a1 <- p
    move    $a2, $s1                                            # $a2 <- r
    jal     swap                                                # calling swap with arguments A, p, r

    # calling recursive_sort(A, left, r-1)
    lw      $a1, -24($fp)                                       # $a1 <- left
    addi    $a2, $s1, -1                                        # $a2 <- r-1     
    jal     recursive_sort  

    # calling recursive_sort(A, r+1, right) 
    addi    $a1, $s1, 1                                         # $a1 <- r+1     
    lw      $a2, -28($fp)                                       # $a2 <- right   
    jal     recursive_sort  

    j       returnSort

outerSwap:
    move    $a1, $s0                                            # $a1 <- l       
    move    $a2, $s1                                            # $a2 <- r       
    jal     swap                                                # calling swap with arguments A, l, r

    lw      $a1, -24($fp)                                       # restoring $a1
    lw      $a2, -28($fp)                                       # restoring $a2

    j       outerWhile

# swap procedure for swapping array element at index i and j
swap:
    sll     $t0, $a1, 2                                         # $t0 = 4*i
    add     $t0, $a0, $t0                                       # $t0 = A+(i*4)  # (address of A[i])                                                               
    lw      $t2, 0($t0)                                         # $t2 = A[i]

    sll     $t1, $a2, 2                                         # $t1 = 4*j
    add     $t1, $a0, $t1                                       # $t1 = A+(j*4)  # (address of A[j])                                                               
    lw      $t3, 0($t1)                                         # $t3 = A[j], temp = A[j]

    sw      $t2, 0($t1)                                         # A[j] = A[i]
    sw      $t3, 0($t0)                                         # A[i] = temp
    jr		$ra			                        # returning from the swap function


returnSort:
    lw      $ra, -4($fp)                                        # restoring $ra
    lw      $s0, -8($fp)                                        # restoring $s0
    lw      $s1, -12($fp)                                       # restoring $s1
    lw      $s2, -16($fp)                                       # restoring $s2

    addi    $sp, $sp, 28                                        # popping everyting from stack except the frame pointer, ie, $fp

    lw      $fp, 0($sp)                                         # restoring frame pointer
    addi    $sp, $sp, 4                                         # restoring stack pointer

    jr      $ra                                                 # returning from the recursive_sort procedure

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
# Function group to find key in the array recursively----------------------------------------------------------------------------------------------------------------

# function variables

# array A start address: $a0
# start index: $a1
# end index: $a2
# key to find: $a3

recursive_search:
    move    $t0, $ra                                       	# storing the old frame pointer

    # intializing the frame and stack pointer
    addi    $sp, $sp, -4
    sw      $fp, 0($sp)
    move    $fp, $sp

    move    $t1, $a0    					# store array address temporarily
    
    # pushing the existing return address $ra to stack
    move    $a0, $t0
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)

    move    $a0, $t1    					# restoring array address
    li      $v0, -1     					# default return value is -1, ie, key is not found

    blt     $a2, $a1, returnSearch   				# if end < start then return -1 as key has still not been found

    # calculating mid1 and mid2
    sub     $t0, $a2, $a1   					# $t0 <- end - start
    div	    $t0, $t0, 3     					# $t0 <- (end - start) / 3
    add     $t1, $a1, $t0   					# $t1 <- start + (end - start) / 3 = mid1
    sub     $t2, $a2, $t0   					# $t2 <- end - (end - start) / 3 = mid2
    
    mul     $t3, $t1, 4     					# $t3 = 4*mid1
    add     $t3, $t3, $a0   					# $t3 = A + 4*mid1, $t3 here is address of A[mid1]
    lw      $t3, 0($t3)     					# $t3 <- A[mid1]

    mul     $t4, $t2, 4     					# $t4 = 4*mid2
    add     $t4, $t4, $a0   					# $t4 = A + 4*mid2, $t4 here is address of A[mid2]
    lw      $t4, 0($t4)     					# $t4 <- A[mid2]

# following 5 labels correspond to the if else if block in the algorithm
keyEQmid1COND:
    bne     $a3, $t3, keyEQmid2COND  				# if key != A[mid1], moving to next condition
    move    $v0, $t1                                		# else set the return value to mid1 as key is found at index mid1
    j       returnSearch                 			# returning with mid1 as return value

keyEQmid2COND:
    bne     $a3, $t4, keyLTmid1COND  				# if key != A[mid2], moving to next condition
    move    $v0, $t2                                		# else set the return value to mid2 as key is found at index mid2
    j       returnSearch                			# returning with mid2 as return value

keyLTmid1COND:
    bge     $a3, $t3, keyGTmid2COND  				# if key >= A[mid1] branch to next condition else we will search for key in A[0->mid1-1]
    
    addi    $a2, $t1, -1                            		# $a2 <- mid1-1, end = mid1-1

    jal     recursive_search                        		# call recursive search with parameters A, start(0), end(mid1-1), key
    j       returnSearch                 			# return the index at which key is found in A[0->mid1-1]

keyGTmid2COND:
    ble     $a3, $t4, elseSTMT         				# if key <= A[mid2] branch to next condition else will search for key in A[mid2+1->9(end)]
    
    addi    $a1, $t2, 1                             		# $a1 <- mid2 + 1, start = mid2+1

    jal     recursive_search                        		# call recursive search with parameters A, start(mid2+1), end, key
    
    j       returnSearch                            		# return the index at whcih key is found in A[mid2+1->9(end)]

elseSTMT:							# reaching this label means that key is in A[mid1+1->mid2-1]
    addi    $a1, $t1, 1                             		# $a1 <- mid1 + 1, start = mid1+1
    addi    $a2, $t2, -1                            		# $a2 <- mid2 - 1, end = mid2-1

    jal     recursive_search                        		# call recursive search with parameters A, mid1+1, mid2-1, key

returnSearch:
    lw      $ra, -4($fp)    					# restore $ra, ie, return address

    addi    $sp, $sp, 4     					# pop from stack

    lw      $fp, 0($sp)     					# restore frame pointer
    addi    $sp, $sp, 4     					# restore stack pointer

    jr      $ra             					# return
