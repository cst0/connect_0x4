TITLE DrawGrid					(DrawGrid.asm)

INCLUDE Irvine32.inc	

.data
		; define bars on side of board
	g_bar db 56 DUP(8 DUP(178))
		; define space for each slot within the board
	g_tokenslot db 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178
		db 178, 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178, 178
		db 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178
		db 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178
		db 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178
		db 178, 178, 178, 32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32, 178, 178, 178
		db 178, 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178
		db 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178
	
		; values used for loops in procedures
	lenbarw dd 8
	lenbard dd 56
	lenrow dd 112
	lentoken dd 16
	lendown dd 8

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
	mov dl, 8
	mov dh, 8
	call printbar
	mov dl, 16
	mov dh, 8
	call printgrid
	mov dl, 128
	mov dh, 8
	call printbar
	call crlf

	ret
printspace ENDP


printgrid PROC		; print all of the slots, individually
	
	mov ecx, 6
	gridheight:
		
		push ecx
		mov ecx, 7
		push dx
		mov ebp, esp
		
		gridwidth:

			push ecx
			call printslot
			add dl, 16
			sub dh, 8
			pop ecx

			loop gridwidth
			
		xchg esp, ebp
		pop dx
		add dh, 8
		pop ecx

		loop gridheight

	ret
printgrid ENDP


printbar PROC		; print the bar that will appear on either side of the grid
	
	mov esi, offset g_bar
	mov ecx, lenbard 
	
	bheight:

		call gotoxy
		push ecx
		mov ecx, lenbarw
		call printline
		add dh, 1
		pop ecx

		loop bheight

	ret
printbar ENDP


printslot PROC		; procedure for each individual slot
	
	mov esi, offset g_tokenslot
	mov ecx, lendown
	
	sheight:

		call gotoxy
		push ecx
		mov ecx, lentoken
		call printline
		add dh, 1
		pop ecx

		loop sheight

	ret
printslot ENDP


printline PROC		; print an individual line of characters, auxiliary procedure
	
	print: 

		mov al, [esi]
		call Writechar
		inc esi
		loop print

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
