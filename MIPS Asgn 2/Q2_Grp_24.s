# Computer Organisation and Architecture Laboratory
# Assignment No. 2
# Problem No. 2
# Autumn Semester 2022
# Group No - 24
# Vikas Vijaykumar Bastewad - 20CS10073
# Yashraj Singh - 20CS10079
# -----------------------------------------------------

# This program takes 10 integers and an integer k as input from user, sort the array and print the sorted array and k'th largest number in the array.

    .globl main

    .data

prompt1: 
    .asciiz "Enter 10 numbers to be stored in the array."
array: 
    .space 40    # 10 element integer array
askVal:
    .asciiz "Enter the integer to be stored in the array: "
ask_K:
    .asciiz "Enter the integer k: "
err:
    .asciiz "Error: Invalid input.\n Value of k is greater than 10.\n"
printMsg:
    .asciiz "The sorted array is: \n"
outputMsg:
    .asciiz "\nThe k-th largest number is: "
	.text

# main program
# Input: 10 integers and an integer k
# Output: Sorted array and k'th largest number in the array

    
main:
    li      $s1, 10                     # Number of elements in the array.

    jal     read_arr                    # Jump to read_arr function.

    jal     read_k                      # input k from the user

    li	    $a0, 0                      # Initialize array index to 0.
    li 	    $a1, 10                     # Initialise n=10 

    jal     sort_array                  # Jump to sort_array function.   
    jal	    print_array                 # Jump to print_array function.
    jal	    find_k_largest              # Jump to find_k_largest function.
    
    j       finish
    
find_k_largest:
	move 	$t0, $a0			        # $t0 -> array
	move 	$t1, $a1			        # $t1 -> n
	sub	    $t3, $t1, $t2			    # t3 -> n-k
	li	    $t4, 4                      # t4 -> 4
	mul	    $t3, $t4, $t3			    # t3 -> (n-k)*4
	add	    $t3, $t3, $t0			    # t3 -> array[n-k]
	
	li	    $v0, 4                  
	la	    $a0, outputMsg              # Printing output message.
	syscall
	
	li	    $v0, 1                      
	move	$a0, $t3            
	syscall                             # Printing k-th largest number.
	
	j	    finish                      # Jump to finish function.
	
read_arr:
    li      $t0, 0                      # Initialize loop counter (i) to 0.  
    b       read_arr_loop               # Jump to read_arr_loop to read array element input.   

read_arr_loop:
    
    li      $v0, 4
    la      $a0, askVal                 # Asking user to Enter the integer to be stored in the array.
    syscall

    li      $v0, 5                      # Read input from user.
    syscall
    sw      $v0, array($t0)             # store input in array ERROR HERE
    addi    $t0, $t0, 4                 # i = i+1 (int takes 4 byte of memory)
    bne     $t0, 40, read_arr_loop      # if i!=10 continue the loop 
    jr      $ra                         # return to main if i==10 

read_k:
    li      $v0, 4  
    la      $a0, ask_K                  # Asking user to input k
    syscall

    li      $v0, 5                      # take input
    syscall
    move    $s2, $v0                    # storing the value of k in s2


    bgt     $s2, $s1, error             # if k>n then print error message and end the program
    jr      $ra                         # return to main

error:
    li      $v0, 4
    la      $a0, err                    # print the error message
    syscall
    j       finish

sort_array:
	move 	$t0, $a0			        # $t0 -> array
	move 	$t1, $a1			        # $t1 -> n
	li	    $t2, 0				        # Initialize loop counter (i) to 0.
	j	    outerLoop
	
outerLoop:
	beq	    $t2, $t1, exitOuter         # if i==n then exit the loop
	li	    $t3, 0				        # Initialize loop counter (j) to 0.
	sub	    $t4, $t1, $t2               # t4 -> n-i
	
	j 	    innerLoop                   # jump to innerLoop
	
innerLoop:
	beq	    $t3, $t4, exitInner         # if j==n-i then exit the loop
	li	    $t5, 4                      # $t5->4
	mul	    $t6, $t3, $t5               # $t6->4*j
	add	    $t6, $t6, $t0			    # $t6 -> array[j]
	add	    $t7, $t6, $t5			    # $t7 -> array[j+1]
	addi	$t3, $t3, 1                 # $t3 -> j+1
	
	bgt	    $t6, $t7, swap              # if array[j]>array[j+1] then swap the elements
	
	j	    innerLoop                   # else continue the loop
	
exitInner:                              # exit innerLoop
	addi	$t2, $t2,  1                # i = i+1
	j	    outerLoop                   # continue the loop
exitOuter:                              # exit outerLoop
	jr	    $ra                         # return to main
swap:
	sub	    $t6, $t6, $t0               # $t6 -> array[j] - array[0]
	addi	$t7, $t6, 4                 # $t7 -> array[j+1] - array[0]
	move	$t5, $a0                    # $t5 -> array[j]
	add	    $t6, $t6, $t5			    # $t6 -> array[j]
	add	    $t7, $t7, $t5			    # $t7 -> array[j+1]
	lw	    $t8, 0($t6)                 # $t8 -> array[j]
	lw	    $t9, 0($t7)                 # $t9 -> array[j+1]
	sw	    $t8, 0($t7)                 # array[j+1] = array[j]
	sw	    $t9, 0($t6)                 # array[j] = array[j+1]
	
	j	    innerLoop                   # continue the loop
	
print_array:                            # printing the array
    li      $t0,0                       # Initialize loop counter (i) to 0.
    li      $t2,0                       # Initialize loop counter (j) to 0.
    
print_for_loop:
    bge     $t0,$s1,print_func_end      # if i>=n then exit the loop

    lw      $t1,array($t2)              # $t1 -> array[j]
    addi $  t2,$t2,4                    # j++
    
    li      $v0, 1              
    move    $a0, $t1                    # load array[i] in $a0
    syscall                             # print array[i]

                         
    addi    $t0,$t0,1                   # i++
    j       print_for_loop              # continue the loop
    
print_func_end:
    jr      $ra

finish:
    li      $v0, 10                      # end the program
    syscall

