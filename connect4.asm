TITLE Connect 4
#define 

INCLUDE Irvine32.inc
.data
g_mat dw 13 DUP(12 DUP(0))
g_player dw 1,1000
g_turn db 0
g_newMouseInterrupt db 0
g_MouseInputColumn db 0

.code

main PROC	
	
	mov eax,0
	mov ebx,0
	mov ecx,0
	mov edx,0
setup:

	; set up grid

gamestart:
	
	; display grid image
	Call DisplayGrid


	; ask for column to drop coin

	; place coin in column at correct place

	; display grid image

	; if grid is full, end game

	jmp tie

	; check for win state

	; if win state, active player wins
	
	jmp win

	; if no win state, change to 2nd player

	jmp gamestart

tie:

	; display tie

win:
	
	; display x player wins

closeorplayagain:

	; ask to play again?

playagain:

	; set up to play again

endprog:

	; end of program
	exit
main ENDP

;-----------------------------------------------------------;

displaygrid PROC

displaygrid ENDP

;-----------------------------------------------------------;

END main