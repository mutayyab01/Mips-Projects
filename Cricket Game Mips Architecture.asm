.data
msg1: .asciiz "\n____________ Welcome_______________\n ----------- Assembley Cricket Legue -----------\n\t === === \n \t\t Created By : \n \t\tMutayyab Imran\t --> 02-131212-063  \n\t\tAdeeb Ul Hassan\t --> 02-131212-002  \n\t\tAhsan Sajjad\t --> 02-131212-049  \n\n ******* Game Instructions Are******* \n The Keys you can use in this game are only numeric Keys \n The Match will be of Two Overs\n \nThere will be two Players"
selectplayer: .asciiz " Press 1 to Choose Player '1' and Press 2 to Choose Player '2'\n "
enter:.asciiz"Enter : "
play1: .asciiz "\nPlayer 1 turn\n"
play2: .asciiz "\nPlayer 2 turn\n"
#ballmsg: .asciiz " Star Balling now...\nEnter any key For balling\n"
ballmsg: .asciiz " Star Balling now...\n\n"
play_again: .asciiz "\nPress Y to Play again and Press Enter to Quit the Game"
player2turn:.asciiz "\n Player 2 Turn"
player1Win:.asciiz "\n Player 1 Wins"
player2Win: .asciiz "\nPlayer 2 Wins"
errormsg: "\n \n\n Wrong Choice Restarting the Game \n\n\n"
ball_no: .asciiz " Ball no. :"
scoremsg: .asciiz "\nScore is:"
totalplayer1: .asciiz "\nTotal Scores Of "
ballend: .asciiz "\nBalls Are Ended\n\n " 
newLine: .asciiz "\n"
over:.asciiz"How Many Over You want To Play : "
player1read:.asciiz "Enter Score :  "
player2read:.asciiz "Enter Score Of Player 2 :  "
nameofplayer:.asciiz"\n\nEnter name : "
name1: .space 30
name2: .space 30
drawmatch:.asciiz"\n----------------------------------------------------------------------\n----------------------Match Draw ----------------------------------\n------------------------------------------------------------------------------\n"
####################### Main Program ##################################
.text 
.globl main
main:
li $k1,1
#########################MESSAGES##############
la $a0,msg1
li $v0,4
syscall
la $a0,over
li $v0,4
syscall
li $v0,5
syscall
move $t7 ,$v0                   #t7 is total Over
beq $t7,0,exit
mul $t7,$t7,6


la $a0,selectplayer
li $v0,4
syscall
la $a0,enter
li $v0,4
syscall
li $v0,5
syscall
move $t2,$v0

beq $v0,1,player1
beq $v0,2,player2
la $a0,errormsg
li $v0,4
syscall
j main

#Player 1 Program   
player1:
la $a0,nameofplayer
li $v0,4
syscall
li $v0,8
la $a0,name1
li $a1,26
syscall
move $t8,$a0
la $a0,play1
li $v0,4
syscall 
li $k0,0
j ball 


player2:
la $a0,nameofplayer
li $v0,4
syscall
li $v0,8
la $a0,name2
li $a1,26
syscall
move $t9,$a0
la $a0,play2
li $v0,4
syscall
li $k1,0
j ball1


ball:
li $t1,0  	          # Ball Counter t1
la $a0,ballmsg
li $v0,4
syscall
balling:
beq $t1,$t7,continue1
la $a0,newLine
li $v0,4
syscall
la $a0,ball_no
li $v0,4
syscall
addi $t1,$t1,1  	          # Ball Counter t1
move $a0,$t1
li $v0,1
syscall
la $a0,newLine
li $v0,4
syscall
la $a0,player1read
li $v0,4
syscall
li $v0,5
syscall
move $s1,$v0
la $a0,newLine
li $v0,4
syscall
la $a0,player2read
li $v0,4
syscall
li $v0,5
syscall
move $s2,$v0
beq $s1,$s2,continue1
add $k0,$k0,$s1
j balling
#----------------------------------------------------------------------------------------------------------------------
ball1:
li $t2,0  	          # Ball Counter t1
la $a0,ballmsg
li $v0,4
syscall
balling1:
beq $t2,$t7,continue2
la $a0,newLine
li $v0,4
syscall
la $a0,ball_no
li $v0,4
syscall
addi $t2,$t2,1  	          # Ball Counter t1
move $a0,$t2
li $v0,1
syscall
la $a0,newLine
li $v0,4
syscall
la $a0,player1read
li $v0,4
syscall
li $v0,5
syscall
move $s3,$v0
la $a0,newLine
li $v0,4
syscall
la $a0,player2read
li $v0,4
syscall
li $v0,5
syscall
move $s4,$v0

beq $s3,$s4,continue2
add $k1,$k1,$s3
j balling1





#---------------------------------------------------------------------------------------------------------------------------
continue1:
la $a0,ballend
li $v0,4
syscall
la $a0,totalplayer1
li $v0,4
syscall
move $a0,$t8
li $v0,4
syscall
move $a0,$k0
li $v0,1
syscall
j compare
#---------------------------------------------------------------------------------------------------------------------------
continue2:
la $a0,ballend
li $v0,4
syscall
la $a0,totalplayer1
li $v0,4
syscall
move $a0,$t9
li $v0,4
syscall
move $a0,$k1
li $v0,1
syscall
j compare1

compare:
la $a0,play2
li $v0,4
syscall
j player2

compare1:
bgt $k0,$k1,compare2
beq $k0,$k1,draw
la $a0,player2Win
li $v0,4
syscall
j exit
compare2:
la $a0,player1Win
la $v0,4
syscall
draw:
la $a0,drawmatch
la $v0,4
syscall


#---------------------------------------------------------------------------------------------------------------------------
exit:
la $a0,play_again
li $v0,4
syscall
li $v0,12
syscall
beq $v0,'y',main
li $v0,10
syscall
