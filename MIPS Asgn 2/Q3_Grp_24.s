# Computer Organization and Architecture Laboratory
# Assignment No. 2
# Problem No. 3
# Autumn Semester 2022
# Group No - 24
# Yashraj Singh - 20CS10079
# Vikas Vijaykumar Bastewad - 20CS10073
# -------------------------------------------------------------------------------------------------------
# This program is for inputting a matrix and printing its transpose along with calculating its elements
	.data
string:									# label for input msg
	.asciiz "Enter four positive integers m, n, a and r:\n"
printMsgA:								# label for printing A msg
	.asciiz "Matrix A:\n"
printMsgB:								# label for printing B msg
	.asciiz "Matrix B:\n"
tab:									# label for printing tab
	.asciiz "    "
newline:								# label for printing new line
	.asciiz "\n"
	
# -------------------------------------------------------------------------------------------------------
	
	.text
	.globl main
	
main:
	jal 	initStack		# Initializing Stack
	move 	$s0, $sp
	
	li 	$v0, 4
	la 	$a0, string
	syscall				# Asking user to enter numbers
	
	li 	$v0, 5
	syscall				# inputting m and pushing to stack
	move $a0, $v0
	jal pushToStack
	
	li 	$v0, 5
	syscall				# inputting n and pushing to stack
	move 	$a0, $v0
	jal 	pushToStack

	li 	$v0, 5
	syscall				# inputting a and pushing to stack
	move 	$a0, $v0
	jal 	pushToStack

	li 	$v0, 5
	syscall				# inputting r and pushing to stack
	move 	$a0, $v0
	jal 	pushToStack

	lw	$t0, 0($s0)		# $t0 -> m
	lw	$t1, -4($s0)		# $t1 -> n
	mul	$a0, $t1, $t0		# $a0 -> m*n
	
	jal 	mallocInStack		# allocating memory for matrix A
	
    	move	$s1, $v0		# storing starting address of A in $s1
    	
    	lw	$t0, 0($s0)
	lw	$t1, -4($s0)
	mul	$a0, $t1, $t0
	
	jal	mallocInStack		# allocating memory for matrix B
	
    	move	$s2, $v0		# storing starting address of A in $s1
    	
    	lw	$t0, 0($s0)
    	lw   	$t1, -4($s0)                        
    	mul  	$t2, $t0, $t1      	# $t2 -> n*m                 
    	li   	$t3, 0       		# $t3->i=0                       
    	lw   	$t4, -8($s0)  		# $t4 ->a                      
    	lw   	$t5, -12($s0)         	# $t5 ->r              
    	move 	$t6, $s1 		# $t6 -> starting address of A

	j	populate		# filling A
	
# -------------------------------------------------------------------------------------------------------
# Function 1---------------------------------------------------------------------------------------------
initStack:
    	addi 	$sp, $sp, -4    	# moving down the stack pointer                    
    	sw   	$fp, 4($sp)      	# storing the frame pointer                   
    	move	$fp, $sp    		# making frame pointer point the current stack top                        
    	jr  	$ra                    	# jumping back to from where the function wsa called          

# -------------------------------------------------------------------------------------------------------
# Function 2---------------------------------------------------------------------------------------------
pushToStack:
    	addi	$sp, $sp, -4   		# moving the stack pointer down                     
    	sw   	$a0, 4($sp)     	# storing $a0 in stack                    
    	jr   	$ra                    	# jumping back to from where the function wsa called  
	
# -------------------------------------------------------------------------------------------------------
# Function 3---------------------------------------------------------------------------------------------
mallocInStack:
	li	$t3, 4			# size of int=4
	mul	$t0, $a0, $t3		# calculating amount of space to be given
    	move 	$v0, $sp		# storing stack pointer
    	sub  	$sp, $sp, $t0		# moving the stack pointer
	jr	$ra
	
# -------------------------------------------------------------------------------------------------------
# Function 4---------------------------------------------------------------------------------------------
printMatrix:
	move	$t0, $a2		# starting address of matrix
	move	$t1, $a0		# no of rows
	move	$t2, $a1		# no of clumns
	li	$t3, 0			# i=0
	
outerLoop:
	beq	$t3, $t1, exitPrint	# looping till i<rows
	li	$t4, 0			# j=0
	j	innerLoop
	
innerLoop:
	beq	$t4, $t2, exitInnerLoop	# looping till j<columns
	li	$v0, 1
	lw	$a0, 0($t0)
	syscall				# printing the element of matrix
	
	li	$v0, 4
	la	$a0, tab
	syscall				# printing tab
	
	addi	$t0, $t0, -4		# moving to next address in the stack, ie, next element in matrix to print
	addi	$t4, $t4, 1		# j++
	j	innerLoop
	
exitInnerLoop:
	li	$v0, 4
	la	$a0, newline
	syscall				# moving to new row/line
	
	addi	$t3, $t3, 1		# i++
	j	outerLoop
	
exitPrint:
	jr	$ra			# exiting print and back to from where it was called

# -------------------------------------------------------------------------------------------------------
# Function 5---------------------------------------------------------------------------------------------
transposeMatrix:
	move	$t0, $s1			# $t0 = starting address of A
	move	$t1, $s2			# $t1 = starting address of B
	lw	$t2, 0($s0)			# $t2 = m
	lw	$t3, -4($s0)			# $t3 = n
	li	$t4, 0				# i=0
	
OuterLoop:
	beq	$t4, $t2, ExitTranspose		# running loop till i<m
	li	$t5, 0				# j=0
	
InnerLoop:
	beq  	$t5, $t3, ExitInnerLoop		# running loop till j<n
	
	lw	$t6, 0($t0)			# t6 = starting address of A
	mul	$t7, $t2, $t5			# $t7 = m*j;	
	add	$t7, $t7, $t4			# $t7 = m*j +i;
	li	$t8, 4				# $t8->4
	mul	$t7, $t7, $t8			# $t7 = (m*j+i)*4;
	sub	$t7, $t1, $t7			# $t7-> address of B[j][i]
	sw	$t6, 0($t7)			# B[j][i] = A[i][j]
	
	addi	$t0, $t0, -4			# moving to next address of A in stack
	addi	$t5, $t5, 1			# j++
	
	j	InnerLoop
	
ExitInnerLoop:
	addi	$t4, $t4, 1			# i++
	j	OuterLoop
	
ExitTranspose:
	jr	$ra
	
# -------------------------------------------------------------------------------------------------------
populate:
	bge	$t3, $t2, printA		# printing A when all spaces have been filled
	
	sw	$t4, 0($t6)			# $t4->$t6
	mul	$t4, $t4, $t5			# calculating next term of GP
	addi	$t3, $t3, 1			# i = i+1
	addi	$t6, $t6, -4			# moving in next space in array to fill
	
	j 	populate			# looping back
# -------------------------------------------------------------------------------------------------------
printA:
	li	$v0, 4
	la	$a0, printMsgA
	syscall					# printing msg for printing A
		
	lw	$a0, 0($s0)			# $a0(rows)->m
	lw	$a1, -4($s0)			# $a1(columns)->n
	move	$a2, $s1			# $a2->starting address of A
	
	jal	printMatrix			# printing A
	
	jal	transposeMatrix			# calculating transpose
	
	jal 	printB
# -------------------------------------------------------------------------------------------------------
printB:
	li	$v0, 4
	la	$a0, printMsgB
	syscall					# printing msg for printing B
	
	lw	$a0, -4($s0)			# $a0(rows)->n
	lw	$a1, 0($s0)			# $a1(columns)->m
	move	$a2, $s2			# $a2->starting address of B
	
	jal	printMatrix			# printing B
	
	j	exit
# -------------------------------------------------------------------------------------------------------
exit:
	li	$v0, 10
	syscall					# exiting the program
