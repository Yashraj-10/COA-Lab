# Computer Organisation and Architecture Laboratory
# Assignment No. 1
# Problem No. 3
# Autumn Semester 2022
# Group No - 24
# Vikas Vijaykumar Bastewad - 20CS10073
# Yashraj Singh - 20CS10079


# This program takes an integer greater than 10 and prints whether it is prime or composite
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

    	.globl main
    	.data

# Program output text constants

prompt1:
    	.asciiz "Enter a positive integer greater than or equal to 10: "
result1:
    	.asciiz "Entered number is a "
result2:
    	.asciiz " number."
ans1:
    	.asciiz "PRIME"
ans2:
    	.asciiz "COMPOSITE"
err:
    	.asciiz "Error: Invalid input.\n"

    	.text

# main program
#
# program variables
# n: $s0
# i: $s1
# ans: $s2

main:
    	li $v0, 4           	# Printing prompt1
    	la $a0, prompt1
    	syscall

    	li $v0, 5           	# Getting n from user
    	syscall

    	move $s0, $v0       	# saving n to $s0
    	blt $s0, 10, error  	# checking if n is less than 10

    	li $s1, 2           	# initializing i to 2
    
for:
    	beq $s0, $s1, endf
    	div $s0, $s1        	# dividing n by i
    	mfhi $s2            	# storing remainder in s2
    	beq $s2, 0 , prt2   	# if n is divisible by i, n is not prime
    	add $s1, $s1, 1     	# incrementing i
    	b for               	# checking for next i

endf:
    	bne $s2, 0, prt1    	# if n is prime, printing "PRIME"
    	b prt1

# Label to print output when the number is prime
prt1:
    	li  $v0, 4          	# Printing "Entered number is a "
    	la  $a0, result1
    	syscall

    	li $v0, 4           	# Printing "PRIME"
    	la $a0, ans1
    	syscall

    	li $v0, 4    
    	la $a0, result2
    	syscall			# Printing " number."

    	li $v0, 10          	# Exiting the program
    	syscall 

# Label to print output when the number is composite
prt2:
    	li  $v0, 4          	# Printing "Entered number is a "
    	la  $a0, result1
    	syscall

    	li $v0, 4           	# Printing "COMPOSITE"
    	la $a0, ans2
    	syscall

    	li $v0, 4
    	la $a0, result2
    	syscall			# Printing " number."

    	li $v0, 10          	# Exiting the program
    	syscall

# Label for handling error/invalid input
error:
    	li $v0, 4           	# Printing the Error Message
    	la $a0, err
    	syscall
    
	j	main		# Jumping to main to again take input from the user