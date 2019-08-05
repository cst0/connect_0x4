TITLE DrawGrid					(DrawGrid.asm)

INCLUDE Irvine32.inc	
.data
	
	g_bar db 56 DUP(8 DUP(178))
	g_tokenslot db 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178
				      db 178, 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178, 178
				      db 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178
				      db 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178
				      db 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178
              db 178, 178, 178, 32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32, 178, 178, 178
              db 178, 178, 178, 178, 32, 32, 32, 32, 32, 32, 32, 32, 178, 178, 178, 178
				      db 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178, 178
	g_space db 84 DUP(32)
	
	lenbarw dd 8
	lenbard dd 56
	lenrow dd 112
	lentoken dd 16
	lendown dd 8

.code

main PROC	; will need to change name, make portable procedure
			; or for testing purposes only
	
	call clearregs

	call printspace

	exit
main ENDP	

printspace PROC

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

printgrid PROC
	
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

printbar PROC
	
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

printslot PROC
	
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

printline PROC
	
	print: 

		mov al, [esi]
		call Writechar
		inc esi
		loop print

	ret
printline ENDP

;setwindow PROC

	;ret
;setwindow ENDP

clearregs PROC

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi

	ret
clearregs ENDP

END main	; end of program!
