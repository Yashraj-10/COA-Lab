#--------------------------------------------------------------------------------------------------
# Computer Organization and Architecture Laboratory
# Assignment No. 3 (MIPS)
# Problem No. 2
# Autumn Semester 2022
# Group No - 24
# Yashraj Singh - 20CS10079
# Vikas Vijaykumar Bastewad - 20CS10073
# -------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
# Data Segment-------------------------------------------------------------------------------------
    .data

array: 
    .space 40                                                   # creating space for the array with 10 integer elements

prompt1:
    .asciiz "Please enter array element "

colon:
    .asciiz ":"

prompt2:
    .asciiz "Sorted array: "

newline:
    .asciiz "\n"


#--------------------------------------------------------------------------------------------------
# Code Segment-------------------------------------------------------------------------------------
    .globl  main
    .text

#--------------------------------------------------------------------------------------------------
# Main function------------------------------------------------------------------------------------
main:
    addi    $sp, $sp, -4                                        # making space for storing frame pointer
    sw      $fp, 0($sp)                                         # storing old frame pointer
    move    $fp, $sp                                            # setting frame pointer
    
    li      $s0, 10                                             # initialise array length to 10
    
    li      $t0, 0                                              # i = 0

    # calling function to read the array from user
    jal     read

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
    li      $a1, 10                                             # storing array_length in $a1, ie, $a1<-10

    # calling function to print array
    jal     print

    lw      $fp, 0($sp)                                         # restoring the frame pointer
    addi    $sp, $sp, 4                                         # restoring the stack pointer

    li      $v0, 10                                             # terminating the program execution
    syscall
# -------------------------------------------------------------------------------------------------
# Function to input array from user----------------------------------------------------------------
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
    li      $a0, 32                                             # loading space character in $a0
    syscall

    li      $v0, 5                                              # taking input from user 
    syscall   

    sw      $v0, array($t0)                                     # storing array element 

    addi    $t0, $t0, 4                                         # i++       
    bne     $t0, 40, read                                 	# if i<10 then continue the read loop

    jr      $ra
# -------------------------------------------------------------------------------------------------
# Funtion block to print the sorted array----------------------------------------------------------
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
# -------------------------------------------------------------------------------------------------
# Function block to recursively sort the array-----------------------------------------------------

# base address of array A : $a0
# l: $s0
# r: $s1
# p: $s2
# left: $a1
# right: $a2

recursive_sort:
    move    $t0, $ra                                            # storing $ra in t0
    addi    $sp, $sp, -4                                        # making space for storing frame pointer
    sw      $fp, 0($sp)                                         # storing the old frame pointer
    move    $fp, $sp                                            # update frame pointer
   
    move    $t1, $a0                                            # storing array address temporarily in $t1
    
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
    beq     $t0, $zero, return                                  # returning when l>=r else going to the innerWhileLeft function

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
    j       innerWhileLeft                                      # continue the innerWhileLeft loop

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
    b       innerWhileRight                                     # continuing the innerWhileRight loop

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

    j       return

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
    add     $t0, $a0, $t0                                       # $t0 = A+(4*i), $t0 now contains the address of A[i]                                                           
    lw      $t2, 0($t0)                                         # $t2 = A[i]

    sll     $t1, $a2, 2                                         # $t1 = 4*j
    add     $t1, $a0, $t1                                       # $t1 = A+(j*4) , $t1 now contains the address of A[j] 
                                                           
    lw      $t3, 0($t1)                                         # $t3 = A[j], temp = A[j]

    sw      $t2, 0($t1)                                         # A[j] = A[i]
    sw      $t3, 0($t0)                                         # A[i] = temp
    jr		$ra			                        # returning from the swap function

return:
    lw      $ra, -4($fp)                                        # restoring $ra
    lw      $s0, -8($fp)                                        # restoring $s0
    lw      $s1, -12($fp)                                       # restoring $s1
    lw      $s2, -16($fp)                                       # restoring $s2

    addi    $sp, $sp, 28                                        # popping everyting from stack except the frame pointer, ie, $fp

    lw      $fp, 0($sp)                                         # restoring frame pointer
    addi    $sp, $sp, 4                                         # restoring stack pointer

    jr      $ra                                                 # returning from the recursive_sort function
