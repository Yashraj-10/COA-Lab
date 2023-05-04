# Computer Organisation and Architecture Laboratory
# Assignment No. 1
# Problem No. 2
# Autumn Semester 2022
# Group No - 24
# Vikas Vijaykumar Bastewad - 20CS10073
# Yashraj Singh - 20CS10079


# This program takes two integers and calculate their GCD by repeated subtraction
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
	.globl main

	.data

# program output text constants
#
prompt1: 
	.asciiz "Enter the first positive integer: "
prompt2:
	.asciiz "Enter the second positive integer: "
result1:
	.asciiz "GCD of the two integers is: "
err:
    	.asciiz "Error: Invalid input.\n"
	
	.text

# main program
#
# program variables
# a: $s0
# b: $s1
#

sub_b:
	sub	$s0,$s0,$s1			# a = a-b
	b	while

sub_a:
	sub	$s1,$s1,$s0			# b = b-a
	b	while

main: 
	li	$v0, 4				
	la	$a0, prompt1			# Prompt asking user to enter the first number
	syscall

	li	$v0, 5				# getting 'a' from user
	syscall
	move 	$s0, $v0			# save 'a' to $s0
	
	blt 	$s0, 0, error  			# checking if 'a' is negative

	li	$v0, 4				# Prompt asking user to enter the second number
	la	$a0, prompt2
	syscall
	
	li	$v0, 5				# getting 'b' from user
	syscall
	move 	$s1, $v0

	blt 	$s1, 0, error  			# checking if 'b' is negative

	beq	$s0, $s1, ans			# if a==b then returning a

	beq	$s0, 0, ifzeroA			# Branching if the first number is zero

	beq	$s1, 0, ifzeroB			# Branching if the second number is zero

while:
	beq	$s1, 0, ans  			# exiting loop if b==0
	bgt	$s0, $s1, sub_b   		# if a > b then a = a-b
	blt	$s0, $s1, sub_a

ans:
	li    	$v0, 4
    	la    	$a0, result1			
    	syscall					# Prompting the Output Message
	
	li	$v0, 1
	move	$a0, $s0			
	syscall					# Printing the GCD

	li    	$v0, 10         		
    	syscall					# Terminating the program

# If one of the numbers of the two numbers is 0, the GCD is the non-zero number

# ---------- Label when the first number is zero ----------
ifzeroA:
	li	$v0, 4
	la	$a0, result1
	syscall					# Prompting the Output Message
	
	li	$v0, 1
	move	$a0, $s1
	syscall					# Printing the GCD
	
	li    	$v0, 10         		
    	syscall					# Terminating the program

# ---------- Label when the second number is zero ----------
ifzeroB:
	li	$v0, 4
	la	$a0, result1		
	syscall					# Prompting the Output Message
	
	li	$v0, 1
	move	$a0, $s0
	syscall					# Printing the GCD
	
	li    	$v0, 10         		
    	syscall					# Terminating the program

error:
    	li 	$v0, 4         			
    	la 	$a0, err
    	syscall					# Printing error message
    
	j	main				# Jumping to main when one of the integers supplied is negetive in order to take the new input