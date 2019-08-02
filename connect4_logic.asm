TITLE Template

INCLUDE Irvine32.inc

;==================== DATA =======================
.data
	mainarr dw 156 DUP(0)
	g_xvals db 13
	g_yvals db 12
	g_xnbuf db 7
	g_ynbuf db 6
	g_curx db 0
	g_cury db 0
	Rowsize = ($ - mainarr)

	; The last point at which 'x' and 'y' was placed.
	m_lastx db 0
	m_lasty db 0

	; Last values for things so we don't accidently write them over 
	; when running through a method
	g_last_eax dd 0
	g_last_ebx dd 0
	g_last_ecx dd 0
	g_last_edx dd 0
	g_last_esi dd 0
	g_last_edi dd 0
	g_last_ebp dd 0
	
	; The number of turns we've had. This way we can detect a stalemate, and
	; we can tell whose turn it is.
	g_turn db 0

	;== Prompts and other text strings
	currentplayerstring db "The current player turn is ",0
	printmatheader db "  0 1 2 3 4 5 6", 13, 10, 0
	printmatbar db" ----------------", 13, 10, 0

;=================== CODE =========================
.code
main proc
	m_mainloop:
		call Clrscr

		call printcurrentplayer
		mov al, 1
		call placecoin
		call printmat
		inc g_turn

		call printcurrentplayer
		mov al, 1
		call placecoin
		call printmat
		inc g_turn

		call printcurrentplayer
		mov al, 1
		call placecoin
		call printmat
		inc g_turn

		call printcurrentplayer
		mov al, 1
		call placecoin
		call printmat
		inc g_turn

		call printcurrentplayer
		mov al, 1
		call placecoin
		call printmat
		inc g_turn
	exit

main endp

;=== 'push' values to save them when we're in a method
pushregs proc
	; Don't push a, because that's how we pass values around
	;mov g_last_eax, eax
	mov g_last_ebx, ebx
	mov g_last_ecx, ecx
	mov g_last_edx, edx
	mov g_last_esi, esi
	mov g_last_edi, edi

	;mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	mov edi, 0
pushregs endp

;=== 'pop' values to return them to normal
popregs proc
	mov eax, g_last_eax
	mov ebx, g_last_ebx
	mov ecx, g_last_ecx
	mov edx, g_last_edx
	mov esi, g_last_esi
	mov edi, g_last_edi
popregs endp

;=== For the sake of easy debug, print the current player
printcurrentplayer proc
	mov edx, offset currentplayerstring
	call WriteString
	call getcurrentplayer
    cmp al, 2
	je  printcurrentplayer_player2

	printcurrentplayer_player1:
		mov eax, 1
		call Writedec
		call CRLF
		jmp pcpdone
	printcurrentplayer_player2:
		mov eax, 2
		call Writedec
		call CRLF
	
	pcpdone:
		ret
printcurrentplayer endp

;=== Get the current player
getcurrentplayer proc
	mov g_last_ebx, ebx
	movsx ax, g_turn
	mov bl, 2
	div bl
	mov ebx, g_last_ebx
	cmp ah, 0
	je getcurrentplayer_iszero
	jmp getcurrentplayer_notzero

	getcurrentplayer_iszero:
		mov al, 1
		ret
	getcurrentplayer_notzero:
		mov al, 2
		ret
getcurrentplayer endp


;=== Prints the matrix in the 7x6 text format, eliminating the +3 buffer on each side.
printmat proc
	mov edx, offset printmatheader
	call WriteString
	mov edx, offset printmatbar
	call WriteString
	
	mov dh, 0
	mov ebx, offset mainarr
	printmat_printrow:
		mov dl, 0
		call printspace
		printmat_printcol:
			mov al, dl
			mov ah, dh
			call writeplayer
			inc dl
			cmp dl, g_xnbuf
			jne printmat_printcol
		inc dh
		call CRLF
		cmp dh, g_ynbuf
		jne printmat_printrow

	mov edx, offset printmatbar
	call WriteString
	ret
	
printmat endp

;=== Writes the player at x, y in format (al, ah)
writeplayer proc
	call getplayer
	call Writedec
	call printspace
	ret
writeplayer endp

;=== Gets the player at a coordinate x, y in format (al, ah)
getplayer proc
	call getmatval
	cmp al, 0
	je getplayer_iszero
	cmp al, 1
	je getplayer_isone
	cmp al, 232 ; the al portion of 1000
	je getplayer_isonek

	; We're comparing against 'al', so this just checks if there's any runover.
;	cmp al, 3
;	je getplayer_iszero
;	cmp al, 4
;	je getplayer_isone

	mov eax, -1
	ret

	getplayer_iszero:
		mov eax, 0
		ret
	getplayer_isone:
		mov eax, 1
		ret
	getplayer_isonek:
		mov eax, 2
		ret
getplayer endp

;=== Gets an x, y value in the format (al, ah)
getmatval proc
	mov g_last_ebx, ebx
	mov g_last_esi, esi
	mov g_last_ecx, ecx
	mov g_last_edx, edx

	add al, 3 ; account for that +3 buffer
	add ah, 3 ; that same buffer
	movzx ebx, al
	movzx esi, ah
	mov eax, ebx
	mov ecx, 13
	mul ecx
	mov ebx, offset mainarr
	add ebx, esi
	add ebx, eax
	mov eax,[ebx]

	mov ebx, g_last_ebx
	mov esi, g_last_esi
	mov ecx, g_last_ecx
	mov edx, g_last_edx
	ret
getmatval endp

;=== Sets an x, y value in the format (al, ah) where bl is the player to set to
setmatval proc
	mov g_last_ebp, ebp
	mov g_last_esi, esi
	mov g_last_ecx, ecx
	mov g_last_edx, edx

	add al, 3 ; account for that +3 buffer
	add ah, 3 ; that same buffer
	movzx ebp, al
	movzx esi, ah
	mov eax, ebp
	mov ecx, 13
	mul ecx
	mov ebp, offset mainarr
	add ebp, esi
	add ebp, eax

	cmp bl, 1
	je setmatval_playerone
	cmp bl, 2
	je setmatval_playertwo
	cmp bl, 0
	je setmatval_playernone
	
	mov ebx, -1
	jmp setmatval_done

	setmatval_playerone:
		mov ebx, 1
		jmp setmatval_done
	setmatval_playertwo:
		mov ebx, 232
		jmp setmatval_done
	setmatval_playernone:
		mov ebx, 0
		jmp setmatval_done


	setmatval_done:
	mov [ebp], ebx

	mov ebp, g_last_ebp
	mov esi, g_last_esi
	mov ecx, g_last_ecx
	mov edx, g_last_edx
	ret
setmatval endp

;=== Prints a single space. Useful for formatting.
printspace proc
	mov g_last_eax, eax
	mov al, ' ' ; Space in ASCII
	call WriteChar
	mov eax, g_last_eax
	ret
printspace endp

;=== Checks if the most recent token has led to a connect 4 state
checkconnectstate proc
	call checkvertical
	call checkhorizontal
	call checkdiagup
	call checkdiagdown
	;cmp eax, 0xF000
	;jge checkconnectstate_ishigh
	mov eax, 0
	ret

	checkconnectstate_ishigh:
		mov eax, 1
		ret
checkconnectstate endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, eax_0 will be high
checkvertical proc
	
	ret
checkvertical endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, eax_0 will be high
checkhorizontal proc
	mov g_last_eax, eax
	sub al, 3

	ret
checkhorizontal endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, eax_0 will be high
checkdiagup proc
checkdiagup endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, eax_0 will be high
checkdiagdown proc

	ret
checkdiagdown endp

;=== Checks if the value in eax matches one of the binary states
;=== that we care about
binarycheck proc
	and bl, 15
	cmp bl, 15
	je binarycheck_success

	and bl, 30
	cmp bl, 30
	je binarycheck_success

	and bl, 60
	cmp bl, 60
	je binarycheck_success

	and bl, 120
	cmp bl, 120
	je binarycheck_success

	ret
	binarycheck_success:
;		or eax, 0xF000
		ret
binarycheck endp

;=== Places the coin in the right part of the column (al) according to 'gravity'
placecoin proc
	mov g_last_ebx, ebx
	mov g_last_ecx, ecx

	mov ecx, 0
	placecoin_findcoinloop:
		mov ah, ch

		call writehex
		call CRLF

		mov ebx, eax
		call getplayer
		cmp eax, 0
		je placecoin_notfilled

		inc ch
		cmp ch, 6
		je placecoin_maxedout

		jmp placecoin_findcoinloop

	placecoin_maxedout:
		mov ah, -1
		mov ebx, g_last_ebx
		mov ecx, g_last_ecx
		ret
	placecoin_notfilled:
		; We have an empty spot, let's fill it
		mov g_last_eax, ebx
		;call getcurrentplayer		; dumps the current player into al
		;mov bl, al
		mov bl, 1
		mov eax, g_last_eax
		call setmatval

	mov ebx, g_last_ebx
	ret
placecoin endp

;=== Get where the user wants to place a coin via text input, to be substituted by mouse input later
getcol proc
getcol endp

end main
