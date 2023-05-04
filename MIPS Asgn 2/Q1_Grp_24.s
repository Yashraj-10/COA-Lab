# Computer Organisation and Architecture Laboratory
# Assignment No. 2
# Problem No. 2
# Autumn Semester 2022
# Group No - 24
# Vikas Vijaykumar Bastewad - 20CS10073
# Yashraj Singh - 20CS10079
# -----------------------------------------------------

# This program reads two 16-bit signed integers and calculates the product of those numbers.
# ------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------
    .globl main
    .data

# program output text constants
prompt1:
    .asciiz "Enter first number: "
prompt2:
    .asciiz "Enter second number: "
product:
    .asciiz "Product of the two numbers is: "
err:
    .asciiz "Error: Invalid input.\n"

.text

# main program
#
# program variables
#   a: $s0
#   b: $s1
#   product of a and b : $s2

# Booth’s Multiplication Algorithm variables
#   M:      $a0     (Multiplicand)
#   Q:      $a1     (Multiplier)
#   Q-1:    $t0     
#   A:      $t1     
#   count:  $t2     (count <- n)

main:
    # --- Taking input ---
    li      $v0, 4
    la      $a0, prompt1               # Prompt asking user to enter the first number
    syscall 

    li      $v0, 5                     # getting 'a' from user
    syscall
    move    $s0, $v0                   # store 'a' in s0

    li      $v0, 4
    la      $a0, prompt2               # Prompt asking user to enter the second number
    syscall 

    li      $v0, 5                     # Getting 'b' from user
    syscall
    move    $s1, $v0                   # Storing 'b' in s1

    # --- Sanity checking ---

    # a and b are 16 bit signed integers their range will be -->  (-2^15 < a,b < 2^15-1)
    # Checking if a is in the range 
    blt     $s0, -32768, error   
    bgt     $s0, 32767, error

    # Checking if b is in the range
    blt     $s1, -32768, error
    bgt     $s1, 32767, error
    
    
    move    $a0, $s0                    # Moving 'a' to $a0 (as mentioned in the question)
    move    $a1, $s1                    # Moving 'b' to $a1
    
    jal     booth                       # Calling Booth’s Multiplication Algorithm to calculate the product of a and b

    move    $s2, $v0                    # Storing the returned value in $s2

    
    li      $v0, 4
    la      $a0, product
    syscall                             # Prompting the Output Message

    li      $v0, 1
    move    $a0, $s2
    syscall                             # Printing the product

    b		finish                      # Jump to terminate the program

# Booth’s Multiplication Algorithm variables
#   M:      $a0     (Multiplicand)
#   Q:      $a1     (Multiplier)
#   Q-1:    $t0     
#   A:      $t1     
#   count:  $t2     (count <- n)

booth:
    move 	$t0, $zero                  # Initialising Q-1 with zero
    move 	$t1, $zero                  # Initialising A with zero
    li      $t2, 32                     # Initialising n with 32, number of bits= 32 i.e. n=32
    b       while                       # Jump to while loop

while:  
    andi    $t3, $a1, 1                 # Calculating LSB i.e. Q0 and storing it in t3

    xor     $t3, $t3, $t0               # Taking xor of Q0 and Q-1 to decide arithmetic action that sould be done
    
    # 11 -> no arithmetic operation
    # 00 -> no arithmetic operation
    # 01 -> add multiplicand to left half of the product
    # 10 -> substract multiplicand from left half of product

    bne	    $t3, 0, operation_decide    # Branching to 'operation_decide' to do arithmetic operation ; { Q0 Q-1 = 01 or 10 }
    b       ASR                         # jump to ASR (Arithmetic shift right)

ASR:                                    # Arithmetic shift right function
    andi    $t3, $a1, 1                 # Storing Q0 in $t3

    move    $t0, $t3                    # Setting Q-1 to Q0
    srl     $a1, $a1, 1                 # logically shift Q right by 1 bit

    # Putting the LSB of A in MSB of $t4 
    andi    $t4, $t1, 1                 # store A0 in $t4
    sll     $t4, $t4, 31                # logically shift left by 31 bits

    or      $a1, $a1, $t4               # Transfering the MSB of $t4 to Q
    sra     $t1, $t1, 1                 # Arithmetic shift right A by 1 bit

    sub 	$t2, $t2, 1                 # Decrementing count by 1 , n = n-1
    bgt     $t2, 0 , while              # Looping until n != 0 

    move 	$v0, $a1                    # if n = 0 then return after storing return value in $v0
    jr		$ra                         # return to main 

operation_decide:                       # Exactly one of Q0 and Q-1 is 1
    beq     $t0, 1, addition            # if Q-1 is 1 then addition operation is done
    b       substraction                # else substraction operation will be done
         
addition:
    add		$t1, $t1, $a0		        # A = A + M
    b       ASR                         # jump to ASR 

substraction:
    sub		$t1, $t1, $a0		        # A = A - M
    b       ASR                         # jump to ASR 
    
error:
    li      $v0, 4
    la      $a0, err                    # Printing the error message
    syscall
    j       finish

finish:
    li      $v0, 10                     
    syscall                             # Terminating the program