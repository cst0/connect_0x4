TITLE DrawGrid					(DrawGrid.asm)

INCLUDE Irvine32.inc	

.data
		; define bars on side of board (height and width)
	g_bar db 56 DUP(8 DUP(178))
		; define space for each slot within the board (ascii: 178 -> bar, 32 -> space)
	g_tokenslot db 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178
		db 178, 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178, 178
		db 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178
		db 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178
		db 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178
		db 178, 178, 178, 32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32, 178, 178, 178
		db 178, 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178, 178
		db 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178
	
		; values used for loops in procedures
		; all dd, easier to load with ecx for looping (since ecx is a 32 bit register)
	lenbarw dd 8		; width of bar
	lenbard dd 56		; height of bar (8 pixels each, 7 times, accounting for extra row for stand)
	
	lentoken dd 16		; length of a token (8 pixel -> 16 ascii characters)
	lendown dd 8		; height of token
	
	gridw dd 7		; grid space, width
	gridh dd 6		; grid space, height
	
		; values for coordinates
		; all db, used for coordinate call as registers are dh and dl (8 bit)
	lenrow db 112		; width of just placed tokens (7 wide)
	lendowndb db 8		; heigth of token, in db
	lenbar db 8		; bar length, in db
	tknwidth db 16		; width of each token, in db
	
	strtheight db 8		; starting position, allows for one token height above grid
	pixel db 1		; a 1 pixel jump down or up
	
.code


main PROC	; testing procedure
	
	call clearregs
	call printspace
	;call printbar
	;call printslot

	exit
main ENDP	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	procedures	   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printspace PROC		; print the entire space, might want to add more or less
	
	;call setwindow
	mov dl, 8				; set start width, from border of window
	mov dh, strtheight			; set start heigth, will remain constant for each
	call printbar				; first draw leftmost bar
	mov dl, lenbar				; shift height and width of next pixel to draw
	add dl, 8		
	mov dh, strtheight	
	call printgrid				; print the tokens
	mov dl, lenbar				; shift heigth and width again
	add dl, lenrow 
	add dl, 8
	mov dh, strtheight
	call printbar				; print the left most bar
	call crlf				; add a space at the bottom, why not right

	ret
printspace ENDP


printgrid PROC		; print all of the slots, individually
	
	mov ecx, gridh				; grid height counter in loop, print for 6 tall
	gridheight:
		
		push ecx			; height counter on the stack
		mov ecx, gridw			; time for the width counter 
		push dx				; lets push our coordinates too, both contained on dx
		mov ebp, esp			; we'll point to the stack frame here, now we have basically a free stack
		
		gridwidth:

			push ecx		; push the counter on the stack, we need ecx for printslot call
			call printslot		; print an individual slot in the board
			add dl, tknwidth	; offset for next slot by the slot width for x coordinate
			sub dh, lendowndb	; offset to top left corner with y coordinate
			pop ecx			; pop our counter

			loop gridwidth		; loop for row (in our case 7)
			
		xchg esp, ebp			; return original pointer, with height counter and original coordinates
		pop dx				; pop our original coordinates, we need this to start the next row
		add dh, lendowndb		; move position down to next row
		pop ecx				; pop our height counter, back to the loop

		loop gridheight

	ret
printgrid ENDP


printbar PROC		; print the bar that will appear on either side of the grid
	
	mov esi, offset g_bar			; our array to build our bar, offset for loop
	mov ecx, lenbard 			; we know we will be looping down a certain distance
	
	bheight:

		call gotoxy			; go to our coordinate to begin a row to print
		push ecx			; push our counter, we will need this soon!
		mov ecx, lenbarw		; now we know how wide our bar is
		call printline			; print out a line of characters!
		add dh, pixel			; move down a pixel to print next line in sequence
		pop ecx				; ah we need our counter again!

		loop bheight			; loop

	ret
printbar ENDP


printslot PROC		; procedure for each individual slot
	
	mov esi, offset g_tokenslot		; our array to build tokens, cool
	mov ecx, lendown			; loop for height of a single token
	
	sheight:

		call gotoxy			; go to starting coordinate to draw token
		push ecx			; push our counter...you probably get the point now thoughh
		mov ecx, lentoken		; we need to know the length of our token
		call printline			; print the line of characters...yeah we know this procedure
		add dh, pixel			; again, move down a pixel for the next line
		pop ecx				; pop our counter

		loop sheight			; loop

	ret
printslot ENDP


printline PROC		; print an individual line of characters, auxiliary procedure
	
	print: 

		mov al, [esi]			; mov our current ascii value into al, for Writechar
		call Writechar			; call procedure to write a character to the console, thanks Irvine
		inc esi				; increment our pointer
				
		loop print			; loop

	ret
printline ENDP


;setwindow PROC		; will want to implement, set window size

	;ret
;setwindow ENDP


	; from push/pop functions
clearregs PROC		; clear the general purpose registers

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi

	ret
clearregs ENDP


END main
