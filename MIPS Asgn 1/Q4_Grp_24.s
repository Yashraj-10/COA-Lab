# Computer Organisation and Architecture Laboratory
# Assignment No. 1
# Problem No. 4
# Autumn Semester 2022
# Group No - 24
# Vikas Vijaykumar Bastewad - 20CS10073
# Yashraj Singh - 20CS10079


# This program takes a positive integer from user and checks whether it is a perfect number or not.
# A perfect number is a number that is equal to the sum of its proper divisors.
#---------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------
    
	.globl main
    	.data

prompt1:
    	.asciiz "Enter a positive integer: "
result1:
    	.asciiz "Entered number is a perfect number."
result2:
    	.asciiz "Entered number is not a perfect number."
err:
    	.asciiz "Error: Invalid input.\n"

    	.text

# main program
#
# program variables
# n: $s0
# i: $s1
# sum: $s2
#

addSum:
    	add 	$s2, $s2, $s1			# sum = sum + i because n is divisible by i
    	add 	$s1, $s1, 1			# Incrementing i by 1
    	b   	for				# Returning to the 'for' label

main:
    	li 	$v0, 4
    	la 	$a0, prompt1
    	syscall					# Asking user to enter the number

    	li 	$v0, 5                   	# Reading n from user
    	syscall

    	move 	$s0, $v0

    	blt 	$s0, 0, error			# Checking if n is negative

    	li 	$s1, 2                   	# Initialising i=2

    	li 	$s2, 1                   	# Initialising sum=1 as 1 will always be a factor

for:
    	ble 	$s0, $s1, endf
    
    	div 	$s0, $s1                	# dividing n by i
    	mfhi 	$s3                    		# storing remainder in s3
    	beq 	$s3, 0 , addSum         	# if n is divisible by i, adding i to sum
    	add 	$s1, $s1, 1	
    	b   	for

endf:
    	beq 	$s0, $s2, Yes           	# if n is equal to sum it is perfect number
    	bne 	$s0, $s2, No            	# else it is not perfect
    	li      $v0, 10             		
    	syscall					# Terminating the program

Yes:
    	li  	$v0, 4      
    	la  	$a0, result1            	# Printing the result
    	syscall

    	li      $v0, 10             		# Terminating the program
    	syscall

No:
    	li  	$v0, 4
    	la  	$a0, result2            	# Printing the result
    	syscall
    		
	li      $v0, 10             		# Terminating the program
    	syscall

error:
    	li 	$v0, 4                   	# Printing error message
    	la 	$a0, err
    	syscall
    
	j	main				# Jumping to main to again take input from the user