#--------------------------------------------------------------------------------------------------
# Computer Organization and Architecture Laboratory
# Assignment No. 3 (MIPS)
# Problem No. 1
# Autumn Semester 2022
# Group No - 24
# Yashraj Singh - 20CS10079
# Vikas Vijaykumar Bastewad - 20CS10073
# -------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
# Data Segment
    .data
input_prompt1:                                                      # Prompt for reading input n
    .asciiz "Enter n: "
input_prompt2:                                                      # Prompt for reading input a
    .asciiz "Enter a: "
input_prompt3:                                                      # Prompt for reading input r
    .asciiz "Enter r: "
input_prompt4:                                                      # Prompt for reading input m
    .asciiz "Enter m: "
print_msg:                                                          # Message for displaying matrix A
    .asciiz "The matrix A is : \n"
error_msg:                                                          # Prompt for error 
    .asciiz "Invalid Input !!!\n"
output_msg:                                                         # Prompt for output
    .asciiz "Final determinant of matrix A is: "                    
whitespace:                                                         # Whitespace
    .asciiz " "
newline:                                                            # Newline
    .asciiz "\n"

#--------------------------------------------------------------------------------------------------
# Code Segment

    .text
    .globl main                                 # Declaring main as global

#--------------------------------------------------------------------------------------------------
# Main function
main:
    addi    $sp, $sp, -4
    sw      $fp, 0($sp)                         # storing $fp in stack

    move    $fp, $sp                            # Making $fp point to current stack top

    move    $s0, $sp                            # storing the stack pointer in $s0

# Using different labels to input different parameters so that errors could be handled nicely
input_n:                                        # label for inputting n
    li      $v0, 4
    la      $a0, input_prompt1
    syscall

    li      $v0, 5
    syscall
    move    $a0, $v0

    blez    $v0, error_n                        # branching to error label in case of invalid input

    jal     pushToStack

input_a:                                        # label for inputting a
    li      $v0, 4
    la      $a0, input_prompt2
    syscall

    li      $v0, 5
    syscall
    move    $a0, $v0

    jal     pushToStack

input_r:                                        # label for inputting r
    li      $v0, 4
    la      $a0, input_prompt3
    syscall

    li      $v0, 5
    syscall
    move    $a0, $v0

    jal     pushToStack

input_m:                                        # label for inputting m
    li      $v0, 4
    la      $a0, input_prompt4
    syscall

    li      $v0, 5
    syscall
    move    $a0, $v0

    blez    $v0, error_m                        # branching to error label in case of invalid input

    jal     pushToStack

# after initializing stack and taking correct input, the stack is as

#         |-----|
#         | $fp |
#         |-----|
#         |  n  |
#         |-----|
#         |  a  |
#         |-----|
#         |  r  |
#         |-----|
#         |  m  |
#         |_____|
#--------------------------------------------------------------------------------------------------
# Function to allocate space for A 
allocate: 
    lw      $t0, -4($s0)                        # $t0 <- n
    mul     $a0, $t0, $t0                       # $a0 <- n * n

    jal     mallocInStack                       # call mallocInStack with $a0 as argument

    move    $s1, $v0                            # storing address of A in $s0

#--------------------------------------------------------------------------------------------------
# Function group to fill A with values-------------------------------------------------------------
populate: 
    lw      $t0, -4($s0)                        # $t0 <- n
    mul     $t1, $t0, $t0                       # $t1 <- n * n
    li      $t2, 0                              # $t2 <- 0 , $t2 is i
    lw      $t3, -8($s0)                        # $t3 <- a
    lw      $t6, -16($s0)                       # $t6 <- m
    div     $t3, $t6                            # dividing a by m
    mfhi    $t3                                 # $t3 <- a%m
    lw      $t4, -12($s0)                       # $t4 <- r
    move    $t5, $s1                            # storing address of first element of A in $t5

# Loop to populate the elements of A in a row-major fashion
populate_loop:
    bge     $t2, $t1, display                   # if i >= n * n, exit loop and printing A

    sw      $t3, 0($t5)                         # populating current matrix element

    # calcualting next element of matrix
    mul     $t3, $t3, $t4
    lw      $t6, -16($s0)
    div     $t3, $t6
    mfhi    $t3

    addi    $t5, $t5, -4                        # moving to the next address to populate
    addi    $t2, $t2, 1                         # i++

    j       populate_loop
#--------------------------------------------------------------------------------------------------
# function group to print A after pupolating it----------------------------------------------------------
display:  
    li      $v0, 4
    la      $a0, print_msg
    syscall                                     # outputting print msg on the console

    lw      $a0, -4($s0)                        # $a0 = n
    move    $a1, $s1                            # storing address of first element of A in $a1
    j       printMatrix                         # printing A after filling it

printMatrix:
    move    $t0, $a1                            # storing address of first element A in $t0
    move    $t3, $a0                            # $t3 <- n
    li      $t1, 0                              # $t1 <- 0, i=0
    
outerLoop:
    beq     $t1, $t3, printDet                  # looping till i<n and the calling the function to compute determinant
    li      $t2, 0                              # $t2 <- 0, j=0

innerLoop:
    beq     $t2, $t3, exitInnerLoop             # looping till j<n

    li      $v0, 1
    lw      $a0, 0($t0)
    syscall                                     # print matrix element at A[i][j]

    li      $v0, 4  
    la      $a0, whitespace 
    syscall                                     # printing whitespace

    addi    $t0, $t0, -4                        # moving to next element in A
    addi    $t2, $t2, 1                         # j++
    j       innerLoop                           # continuing inner loop
    
exitInnerLoop:      
    li      $v0, 4  
    la      $a0, newline    
    syscall                                     # printing newline

    addi    $t1, $t1, 1                         # i++
    j       outerLoop                           # continuing outer loop
#--------------------------------------------------------------------------------------------------
# Function to print determinat after calculating it recursively------------------------------------
printDet:
    lw      $a0, -4($s0)                        # $a0 <- n
    move    $a1, $s1                            # storing address of first element of A in $a1
    jal     calcDet                             # call the calcDet function with $a0, $a1 as arguments

    move    $t0, $v0                            # $t0 <- $v0, as det(A) is returned in $v0

    li      $v0, 4
    la      $a0, output_msg
    syscall                                     # print output_msg on the console

    move    $a0, $t0                            # $a0 <- det(A)

    la      $v0, 1
    syscall                                     # print det(A) on the console

    j       exit                                # jumping to exit
#--------------------------------------------------------------------------------------------------
# Function group to calculate determinant recursively----------------------------------------------------
calcDet:
    move    $t0, $ra                            # $t0 <- $ra

    jal     pushToStack                         # pushing n to stack

    move    $a0, $a1                            # $a0 <- $a1, storing starting address of A in $a0
    jal     pushToStack                         # pushing starting address of A to stack

    move    $a0, $t0                            # $a0 <- $t0, $t0 stores return address($ra)
    jal     pushToStack                         # pushing return address to stack to stack

    li      $t0, 1                              # $t0 <- 1
    lw      $t1, 8($sp)                         # $t1 <- n

    bne     $t0, $t1, notEqual_1                # jumping to notEqual_1 if n != 1

    # base case of the recursive function
    lw      $v0, 0($a1)                         # $v0 = A[0][0]
    lw      $ra, 0($sp)                         # restore return address from stack
    addi    $sp, $sp, 12                        # poping 3 elements from stack
    jr      $ra                                 # jumping back to from where the calcDet function was called

notEqual_1:
    li      $v0, 0                              # return variable initialized to 0
    move    $a0, $v0                            # $a0 <- $v0
    jal     pushToStack                         # pushing return variable to stack

    li      $t0, 1                              # storing sign which is initialized to 1
    move    $a0, $t0                            # $a0 <- $t0
    jal     pushToStack                         # pushing sign to stack

    lw      $t2, 16($sp)                        # $t2 <- n
    li      $t0, 0                              # $t0 stores loop_counter, initialized to 0

# Loop for calculating the determinant
loopDet: 
    beq     $t0, $t2, endLoopDet                # ending the loop when we have reached the last row, ie, j==n
    move    $t6, $t0                            # $t6 <- j
    move    $a0, $t0                            # $a0 <- $t0, storing loop counter in $a0
    jal     pushToStack                         # pushing loop counter to stack

    lw      $t7, 16($sp)                        # storing address of 1st element of A in $t7

    # using $t1  to store n_smaller
    move    $t1, $t2                            # $t1 <- n_smaller
    addi    $t1, $t1,-1                         # n_smaller = n-1

    mul     $t1, $t1, $t1                       # $t1 now stores the no of elements in smaller determinant

    # allocate memory on stack for the smaller determinant
    move    $a0, $t1                            # $a0 stores size of smaller determinant
    jal     mallocInStack

    # populating cofactor matrix
    move    $t0, $t2                            # $t0 <- n
    move    $t1, $v0                            # storing address of 1st element of cofactor matrix in $t1
    li      $t2, 1                              # $t2 <- row
    li      $t3, 0                              # $t3 <- col
    li      $t8, -4                             # $t8 = -4 
    mul     $t8, $t8, $t0                       # $t8 = -4*n
    add     $t7, $t7, $t8                       # $t7 points to 1st element of 2nd row in matrix A

outerFill:
    beq     $t2, $t0, endOuterFill              # ending outer loop when row==n
    move    $t3, $zero                          # else, col = 0

innerFill:
    beq     $t3, $t0, endInnerFill              # ending inner loop when col==n
    beq     $t6, $t3, incrementColumn           # incrementing col no when col==j
    lw      $t4, 0($t7)                         # $t4 <- A[row][col]
    sw      $t4, 0($t1)                         # A'[i][j] = A[row][col]
    addi    $t1, $t1, -4                        # $t1 <- $t1 - 4
    addi    $t7, $t7, -4                        # $t7 <- $t7 - 4
    addi    $t3, $t3, 1                         # $t3 <- $t3 + 3, incrementing col
    j       innerFill                           # jumping to innerFill

# label for incrementing col no and moving to the next element in matrix
incrementColumn:
    addi    $t3, $t3, 1                         # $t3 = $t3  + 1, increment col
    addi    $t7, $t7, -4                        # $t7 = A[row][col+1]
    j       innerFill                           # jumping to innerFill

endInnerFill:
    addi    $t2, $t2, 1                         # $t2 = $t2 + 1, increment row by 1
    j       outerFill                           # jumping to outerFill

endOuterFill:
    addi    $t0, $t0, -1                        # $t0 <- n-1
    move    $a0, $t0                            # $a0 <- $n-1
    jal     pushToStack                         # pushing $a0 to stack

    move    $a0, $t0                            # $a0 <- n-1 
    move    $a1, $v0                            # storing address of first element of cofactor matrix in $a1
    jal     calcDet                             # call the calcDet function with $a0, $a1 as arguments

    lw      $t2, 0($sp)                         # $t2 <- n-1
    move    $t0, $t2                            # $t0 <- n-1
    mul     $t0, $t0, $t0                       # $t0 <- (n-1)*(n-1)
    jal     popFromStack                        # poping n-1 from stack

    sll     $t0, $t0, 2                         # $t0 <- 4*(n-1)*(n-1)
    add     $sp, $sp, $t0                       # pop matrix A' from stack

    lw      $t0, 0($sp)                         # loading loop counter back in $t0 and popping it
    jal     popFromStack

    lw      $t1, 0($sp)                         # loading sign from stack and popping it
    jal     popFromStack

    lw      $t3, 0($sp)                         # loading current value of det from loop and popping it
    jal     popFromStack

    mul     $t4, $v0, $t1                       # $t4 = recursiveDet(A', n-1)*sign
    lw      $t5, 4($sp)                         # loading address of 1st element of A in $t5
    move    $t6, $t0                            # $t6 <- j(loop counter)
    li      $t8, -4                             # $t8 <- -4
    mul     $t6, $t6, $t8                       # $t6 <- -4*j
    add     $t5, $t5, $t6                       # $t5 <- address of A[0][j]
    lw      $t5, 0($t5)                         # $t5 <- A[0][j]

    mul     $t4, $t4, $t5                       # $t4 = recursiveDet(A', n-1) * sign * A[0][j]
    add     $t4, $t4, $t3                       # $t4 = $t4 + $t3, equivalent to so_far_Det(A) += $t4
    move    $a0, $t4                            # $a0 = so_far_Det(A)
    jal     pushToStack                         # push $a0(so_far_Det(A)) to stack
    
    #negating sign and pushing in stack
    li      $t8, -1                             # $t8 <- -1
    mul     $t1, $t1, $t8                       # sign = -sign
    move    $a0, $t1                            # $a0 <- sign(updated/negated)
    jal     pushToStack                         # pushing sign to stack
    
    addi    $t2, $t2, 1                         # $t2 <- n
    addi    $t0, $t0, 1                         # $t0 <- j+1
    j       loopDet                             # jumping to loopDet

endLoopDet:
    jal     popFromStack                        # poping sign from stack

    lw      $v0, 0($sp)                         # $v0 = Det(A)
    jal     popFromStack                        # poping Det(A) from stack

    lw      $ra, 0($sp)                         # restoring return address
    addi    $sp, $sp, 12                        # poping 3 elements from stack

    jr      $ra                                 # jumping to return address

#--------------------------------------------------------------------------------------------------
# Function to push an element to the stack---------------------------------------------------------
pushToStack:
    addi    $sp, $sp, -4                        # Decrement stack pointer by 4
    sw      $a0, 0($sp)                         # Store $a0 in stack
    jr      $ra                                 # jump to return address

#--------------------------------------------------------------------------------------------------
# Function to pop an element from stack------------------------------------------------------------
popFromStack:
    addi    $sp, $sp, 4                         # increment stack pointer by 4
    jr      $ra                                 # jump to return address

#--------------------------------------------------------------------------------------------------
# Function to allocate memory for square matrix of size n------------------------------------------
mallocInStack:
    sll     $t0, $a0, 2                         # $t0 = $a0 * 4 = 4*n*n
    addi    $v0, $sp, -4                        # store beginning address in $v0, so that we can return this value
    sub     $sp, $sp, $t0                       # Decrement stack pointer to allocate memory for 4*n*n bytes
    jr      $ra                                 # jump to return address
#--------------------------------------------------------------------------------------------------
# Function for the case when n value is invalid----------------------------------------------------
error_n:
    li      $v0, 4
    la      $a0, error_msg
    syscall
    j       input_n                             # again taking input for n
#--------------------------------------------------------------------------------------------------
# Function for the case when m value is invalid---------------------------------------------------- 
error_m:
    li      $v0, 4
    la      $a0, error_msg
    syscall
    j       input_m                             # again taking input for m
#--------------------------------------------------------------------------------------------------
# Function for exiting the program-----------------------------------------------------------------
exit:
    move    $sp, $fp                            # restoring stack pointer

    li      $v0, 10                         
    syscall                                     # exiting the program
#--------------------------------------------------------------------------------------------------