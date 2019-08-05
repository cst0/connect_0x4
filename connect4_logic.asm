TITLE Template

INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

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

	calc_threezero dw 0
	calc_twozero dw 0
	calc_onezero dw 0
	calc_zerozero dw 0
	calc_zeroone dw 0
	calc_zerotwo dw 0
	calc_zerothree dw 0
	calc_sum dd 0
	calc_indexx db 0
	calc_indexy db 0

	matval_coordx db 0
	matval_coordy db 0
	g_coordx db 0
	g_coordy db 0
	
	; The number of turns we've had. This way we can detect a stalemate, and
	; we can tell whose turn it is.
	g_turn db 0
	g_playerwon db 0

	;== Prompts and other text strings
	currentplayerstring db "The current player turn is ",0
	printmatheader db "  0 1 2 3 4 5 6", 13, 10, 0
	printmatbar db" ----------------", 13, 10, 0
	youwonstring db "Player won!", 13, 10, 0
	invalidclick db "Invalid click location!", 13, 10, 0

	hStdIn    dd 0
    nRead     dd 0

    _INPUT_RECORD STRUCT
        EventType   WORD ?
        WORD ?                    ; For alignment
        UNION
            KeyEvent              KEY_EVENT_RECORD          <>
            MouseEvent            MOUSE_EVENT_RECORD        <>
            WindowBufferSizeEvent WINDOW_BUFFER_SIZE_RECORD <>
            MenuEvent             MENU_EVENT_RECORD         <>
            FocusEvent            FOCUS_EVENT_RECORD        <>
          ENDS
    _INPUT_RECORD ENDS

    InputRecord _INPUT_RECORD <>

    ConsoleMode dd 0

;=================== CODE =========================
.code
main PROC

	; Mouse interaction was informed by https://stackoverflow.com/questions/33973305,
	; modified to give an x/y coordinate and integrated into the whole program.
    invoke GetStdHandle,STD_INPUT_HANDLE
    mov   hStdIn,eax

    invoke GetConsoleMode, hStdIn, ADDR ConsoleMode
    mov eax, 0090h          ; ENABLE_MOUSE_INPUT | DISABLE_QUICK_EDIT_MODE | ENABLE_EXTENDED_FLAGS
    invoke SetConsoleMode, hStdIn, eax

	m_mainloop:
        invoke ReadConsoleInput,hStdIn,ADDR InputRecord,1,ADDR nRead
		mov al, g_playerwon
		cmp al, 0
		jne done

        movzx  eax,InputRecord.EventType
        cmp eax, MOUSE_EVENT
        jne endloop
        mov eax, InputRecord.MouseEvent.dwMousePosition
        test InputRecord.MouseEvent.dwButtonState, 1

        jz endloop

		call calculatecolumn
		cmp al, -1
		je m_flagval

		call placecoin
		cmp al, -1
		je m_flagval

		call printmat
		inc g_turn
		jmp endloop

		m_flagval:
			mov edx, offset invalidclick
			call writestring

        endloop:
    jmp m_mainloop

    done:
	mov edx, offset youwonstring
	call writestring
    mov eax, ConsoleMode
    invoke SetConsoleMode, hStdIn, eax
    call ReadChar
    invoke ExitProcess, 0
main ENDP

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
	cmp ax, 0
	je getplayer_iszero
	cmp ax, 1
	je getplayer_isone
	cmp ax, 1000
	je getplayer_isonek

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

	mov matval_coordx, al
	mov matval_coordy, al

	cmp al, 0
	jge getmatval_nonnegative
	cmp ah, 0
	jge getmatval_nonnegative
	mov eax, 0
	ret

	getmatval_nonnegative:
	add al, 3 ; account for that +3 buffer
	add ah, 3 ; that same buffer
	movzx ebx, al
	movzx esi, ah
	mov eax, ebx
	mov ecx, 13
	mul ecx
	mov ebx, offset mainarr
	
	; Deal with the fact that this is a dw array, not db
	add eax, esi
	mov ecx, 2
	mul ecx
	
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

	mov matval_coordx, al
	mov matval_coordy, ah

	add al, 3 ; account for that +3 buffer
	add ah, 3 ; that same buffer
	movzx ebp, al
	movzx esi, ah
	mov eax, ebp
	mov ecx, 13
	mul ecx
	mov ebp, offset mainarr

	; Deal with the fact that this is a dw array
	add eax, esi
	mov ecx, 2
	mul ecx

	add ebp, eax

	cmp bl, 0
	je setmatval_iszero
	cmp bl, 1
	je setmatval_isone
	cmp bl, 2
	je setmatval_istwo

	mov ebx, -1
	jmp setmatval_done


	setmatval_iszero:
		mov bx, 0
		jmp setmatval_done
	setmatval_isone:
		mov bx, 1
		jmp setmatval_done
	setmatval_istwo:
		mov bx, 1000
		jmp setmatval_done

	setmatval_done:
	mov [ebp], bx

	mov al, matval_coordx
	mov ah, matval_coordy

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
	mov g_coordx, ah
	mov g_coordy, al
	call checkvertical
	call checkhorizontal
	call checkdiagup
	call checkdiagdown

	ret
checkconnectstate endp

;=== With the calc_ variables filled, do the check math.
docheckmath proc
	mov calc_sum, 0

	movzx eax, calc_threezero
	mov dx, 64
	mul dx
	add calc_sum, eax

	movzx eax, calc_twozero
	mov dx, 32
	mul dx
	add calc_sum, eax

	movzx eax, calc_onezero
	mov dx, 16
	mul dx
	add calc_sum, eax

	movzx eax, calc_zerozero
	mov dx, 8
	mul dx
	add calc_sum, eax

	movzx eax, calc_zeroone
	mov dx, 4
	mul dx
	add calc_sum, eax

	movzx eax, calc_zerotwo
	mov dx, 2
	mul dx
	add calc_sum, eax

	movzx eax, calc_zerothree
	add calc_sum, eax
	mov eax, calc_sum
	 
	call binarycheck
	ret
docheckmath endp

;=== Checks if the token at (al, ah) is vertically a win
;=== If true, eax_0 will be high
checkvertical proc
	mov ah, g_coordx
	mov al, g_coordy
	sub ah, 3
	call getmatval
	mov calc_threezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub ah, 2
	call getmatval
	mov calc_twozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub ah, 1
	call getmatval
	mov calc_onezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	call getmatval
	mov calc_zerozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	add ah, 1
	call getmatval
	mov calc_zeroone, ax

	mov ah, g_coordx
	mov al, g_coordy
	add ah, 2
	call getmatval
	mov calc_zerotwo, ax

	mov ah, g_coordx
	mov al, g_coordy
	add ah, 3
	call getmatval
	mov calc_zerothree, ax

	mov ah, g_coordx
	mov al, g_coordy
	call docheckmath
	ret
checkvertical endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, eax_0 will be high
checkdiagup proc
	mov ah, g_coordx
	mov al, g_coordy
	sub ah, 3
	sub al, 3
	call getmatval
	mov calc_threezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub ah, 2
	sub al, 2
	call getmatval
	mov calc_twozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub ah, 1
	sub al, 1
	call getmatval
	mov calc_onezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	call getmatval
	mov calc_zerozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 1
	add ah, 1
	call getmatval
	mov calc_zeroone, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 2
	add ah, 2
	call getmatval
	mov calc_zerotwo, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 3
	add ah, 3
	call getmatval
	mov calc_zerothree, ax

	mov ah, g_coordx
	mov al, g_coordy
	call docheckmath
	ret
checkdiagup endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, edx_0 will be high
checkhorizontal proc
	mov ah, g_coordx
	mov al, g_coordy
	sub al, 3
	call getmatval
	mov calc_threezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub al, 2
	call getmatval
	mov calc_twozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub al, 1
	call getmatval
	mov calc_onezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	call getmatval
	mov calc_zerozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 1
	call getmatval
	mov calc_zeroone, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 2
	call getmatval
	mov calc_zerotwo, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 3
	call getmatval
	mov calc_zerothree, ax

	mov ah, g_coordx
	mov al, g_coordy
	call docheckmath
	ret
checkhorizontal endp

;=== Checks if the token at (al, ah) is horizontally a win
;=== If true, eax_0 will be high
checkdiagdown proc
	mov ah, g_coordx
	mov al, g_coordy
	sub al, 3
	add ah, 3
	call getmatval
	mov calc_threezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub al, 2
	add ah, 2
	call getmatval
	mov calc_twozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	sub al, 1
	add ah, 1
	call getmatval
	mov calc_onezero, ax

	mov ah, g_coordx
	mov al, g_coordy
	call getmatval
	mov calc_zerozero, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 1
	sub ah, 1
	call getmatval
	mov calc_zeroone, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 2
	sub ah, 2
	call getmatval
	mov calc_zerotwo, ax

	mov ah, g_coordx
	mov al, g_coordy
	add al, 3
	sub ah, 3
	call getmatval
	mov calc_zerothree, ax

	mov ah, g_coordx
	mov al, g_coordy
	call docheckmath
	ret
checkdiagdown endp

;=== Checks if the value in eax matches one of the binary states
;=== that we care about
binarycheck proc

	call getcurrentplayer
	mov cl, al


	mov edx, 0
	mov eax, calc_sum
	mov ebx, 1000
	div ebx

	; Are we checking for player one or two?
	; If we're checking for player one, we should be using the remainder.
	; If not, we should be using the quotient..
	cmp cl, 1
	je binarycheck_playerone
	mov dx, ax

	binarycheck_playerone:

	mov bx, dx
	and bx, 15
	cmp bx, 15
	je binarycheck_success

	mov bx, dx
	and bx, 30
	cmp bx, 30
	je binarycheck_success

	mov bx, dx
	and bx, 60
	cmp bx, 60
	je binarycheck_success

	mov bx, dx
	and bx, 120
	cmp bx, 120
	je binarycheck_success

	ret
	binarycheck_success:
		call getcurrentplayer
		mov g_playerwon, al
		or edx, 65536
		ret
binarycheck endp

calculatecolumn proc
	cmp al, 8			; Account for the left side bar
	jle calculatecolumn_ignore
	
	sub al, 8
	cmp al, 84		; Make sure it's not bigger than 12 columns, 7 characters wide
	jge calculatecolumn_ignore

	movzx ax, al
	mov cl, 12			; Each column is 12 characters wide, get ready to divide by that amount
	div cl
	movzx eax, al
	; column is now in al
	ret
	calculatecolumn_ignore:
		mov al, -1
		ret
ret
calculatecolumn endp

;=== Places the coin in the right part of the column (al) according to 'gravity'
;=== If this led to a connect 4 state, dl will be 1, 0 otherwise
placecoin proc
	mov g_last_ebx, ebx
	mov g_last_ecx, ecx

	mov ecx, eax
	placecoin_findcoinloop:
		mov ah, ch

		mov ebx, eax
		call getplayer
		cmp al, 0
		je placecoin_notfilled
		mov al, bl
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
		mov ecx, eax
		call getcurrentplayer		; dumps the current player into al
		mov bl, al
		mov eax, ecx 

		mov eax, g_last_eax
		call setmatval
		call checkconnectstate

	mov ebx, g_last_ebx
	ret
placecoin endp

;=== Get where the user wants to place a coin via text input, to be substituted by mouse input later
getcol proc
getcol endp

end main
