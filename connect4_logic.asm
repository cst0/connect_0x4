TITLE Template

INCLUDE Irvine32.inc
INCLUDE GraphWin.inc

;==================== DATA =======================
.data
	mainarr dw 164 DUP(0)
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
	m_last_tokenx db 0


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

	cqs_slotslice db 4,3,3,3,4,1,3,1,1
	cqs_tokenslice db 1,3,3,3,3,3,3,3,4 
	cqs_slotslicex db 3
	cqs_slotslicey db 3
	cqs_rows db 0
	cqs_columns db 0
	cqs_slice dd 0

	ca_slotraw db 36 DUP(0)
	ca_tokenraw db 36 DUP(0)
	ca_barleftRaw db 2,3,4,4
	ca_barRightRaw db 4 Dup(0)

	g_token db 72 DUP(0)
	g_tokenslot db 72 DUP(0)
	g_slotrows db 6
	g_slotcolumns db 12

	g_barRight db 8 Dup(0)
	g_barLeft db 8 Dup(0)

	g_barRows db 1
	g_barcolumns db 8

	ps_int db 0
	ps_rows db 0
	ps_columns db 0
	ps_x db 0
	ps_y db 0

	g_point_x db 0
	g_point_y db 0

	pb_loop db 0

	pg_startingrow db 0
	

	animation_rows db 15
	animation_columns db 30

	caa_RawAnimSize db 225
	caa_animation1Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,1,5,1,2,1,1,1,1,1,1,1,1,1,1
	db 1,2,2,2,2,1,1,1,1,1,1,1,1,1,1

	caa_animation2Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,5,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,2,3,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,2,2,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,2,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,2,2,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,2,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation3Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,5,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,3,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,2,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,2,1,1,1,1,1,1,1,1,1,1
	db 1,1,2,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,2,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation4Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,5,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,2,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,2,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,2,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,2,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation5Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,5,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation6Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,4,1,1,1,4,4,1,1,1,1
	db 1,1,1,1,1,4,4,4,4,4,4,1,1,1,1
	db 1,1,1,1,1,4,4,4,2,4,1,1,1,1,1
	db 1,1,1,1,1,1,4,2,2,4,1,1,1,1,1
	db 1,1,1,1,1,4,4,4,1,4,1,1,1,1,1
	db 1,1,1,1,1,4,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation7Raw db 1,1,1,1,1,1,1,4,1,1,1,1,1,1,1
	db 1,1,1,4,1,1,1,4,4,1,1,4,4,1,1
	db 1,1,1,1,2,2,1,1,2,1,1,4,1,1,1
	db 1,1,1,4,4,2,2,4,2,2,2,1,1,1,1
	db 1,1,1,1,4,2,1,4,4,2,4,1,1,1,1
	db 1,1,1,1,2,2,4,1,1,1,4,1,1,1,1
	db 1,1,1,1,1,4,4,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation8Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,2,1,1,1,1,1,1,1,1,4,1,1
	db 1,1,4,2,1,1,1,1,1,1,1,2,4,4,1
	db 1,1,1,1,1,1,2,4,4,2,2,2,1,1,1
	db 1,1,4,4,2,2,1,4,1,1,1,4,4,1,1
	db 1,1,4,1,1,2,2,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,2,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,4,4,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,4,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation9Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,2,2,1,1,1,1,1,1,1
	db 1,1,2,1,1,1,4,1,1,1,1,1,1,1,1
	db 1,1,4,1,1,1,1,1,1,1,1,1,1,2,2
	db 1,1,1,1,1,1,1,2,1,1,1,1,1,1,4
	db 1,1,2,1,1,1,1,4,1,1,1,2,2,1,1
	db 1,1,4,1,1,1,1,1,1,1,1,1,4,1,1
	db 1,1,1,1,1,2,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,4,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	caa_animation10Raw db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,4,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,4
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,4,1,1,1,1,1,1,1,1,1,4,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,4,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

	animation_1 db 450 DUP(1)
	animation_2 db 450 DUP(1)
	animation_3 db 450 DUP(1)
	animation_4 db 450 DUP(1)
	animation_5 db 450 DUP(1)
	animation_6 db 450 DUP(1)
	animation_7 db 450 DUP(1)
	animation_8 db 450 DUP(1)
	animation_9 db 450 DUP(1)
	animation_10 db 450 DUP(1)

	pf_int db 0
	pf_rows db 0
	pf_columns db 0
	pf_x db 0
	pf_y db 0

	wf_counter db 0

	m_hastokenplaced db 0

	animation_array dd 10 DUP(0)
	animation_async db 3 DUP(0)

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
	blanks db "                       ", 13, 10, 0

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
	; Set up the background stuff
m_start:
	call initsprites
	call printbarright
	call printbarleft
	call printgrid

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
		mov al, g_turn
		cmp al, 42
		jne m_dontreset
		call Resetgrid
		jmp m_start
	m_dontreset:
        movzx  eax,InputRecord.EventType
        cmp eax, MOUSE_EVENT

        jne endloop
        mov eax, InputRecord.MouseEvent.dwMousePosition
        test InputRecord.MouseEvent.dwButtonState, 1
		
        jz endloop_justmove

		cmp m_hastokenplaced, 1
		je endloop

		mov m_hastokenplaced, 1

		mov g_point_x, al
		mov g_point_y, ah
		call calculatecolumn
		cmp al, -1
		je m_flagval

		call placecoin
		cmp al, -1
		je m_flagval

		mov dl, g_coordy
		mov dh, g_coordx
		call convertrowcol
		mov edx, eax
		call printtoken
		call printtokenslot

		inc g_turn
		jmp endloop

		m_flagval:
			mov edx, offset invalidclick
			call writestring
			mov edx,0
			Call gotoxy
			mov eax, 500
			call delay
			mov edx, offset blanks
			call writestring
			mov edx, 0
			call gotoxy
			jmp endloop

		endloop_justmove:
			cmp al, 12*7+8-6
			jge endloop
			cmp al, 12
			jle endloop

			mov dl, m_last_tokenx
			mov dh, 0
			call cleartoken

			mov dl, al
			sub dl, 5
			mov m_last_tokenx, dl
			mov dh, 0
			call printtoken
			mov edx, 0
			mov m_hastokenplaced, 0
        endloop:
    jmp m_mainloop

    done:
	push eax
	mov al, g_playerwon
	cmp al, 1
	jne m_player2won
	mov eax, red
	jmp m_afterwon
m_player2won:
	mov eax, blue
m_afterwon:
	call settextcolor
	mov edx, offset youwonstring
	call writestring
	mov eax, 1000
	call Delay
	call clrscr
	call writestring
	pop eax
	Call winningfireworks

	call resetgrid
	jmp m_start


    mov eax, ConsoleMode
    invoke SetConsoleMode, hStdIn, eax
	exit
main ENDP

winningfireworks PROC
	mov esi, offset animation_async
	mov al, -6
	mov [esi], al
	inc esi
	mov al, -3
	mov [esi], al
	inc esi
	mov al, 0
	mov [esi], al
	mov esi, offset animation_async
	mov ecx, lengthof animation_async
	mov bl, 40
	mov edx,0
	mov dh, 5
	mov dl, 0

wf_morefireworks:
	mov al, [esi]
	cmp bl, 1
	jg wf_printasusual
	call clearfireworks
	jmp wf_therest
wf_printasusual:
	call printfirework	
wf_therest:
	
	inc al
	cmp al, 10
	jl wf_dontreset
	mov al, 0
wf_dontreset:
	mov [esi], al
	inc esi
	add dl, 40
		loop wf_morefireworks
	mov eax, 100
	call delay
	mov esi, offset animation_async
	mov ecx, lengthof animation_async
	mov dl, 0

	dec bl	
	cmp bl, 0
	jl wf_done
	jmp wf_morefireworks
wf_done:

	ret
winningfireworks ENDP


resetgrid PROC
	mov esi, offset mainarr
	mov ecx, lengthof mainarr
	mov ax, 0
rg_loop:
	mov [esi], ax
	add esi, 2
	loop rg_loop
	mov g_turn, 0
	mov g_playerwon, 0
	call clrscr
	ret
resetgrid endp

ConvertRowCol PROC
    ;push ebx
    ;push ecx
    ;push edx
    ;mov edx, 0
    ;push eax

	mov al, g_coordy
	mov bl, 12
	mul bl
	add al, g_barcolumns
	mov cl, al

	mov al, g_coordx
	neg al
	mov bl, 6
	add al, 6-1
	mul bl
	add al, 6
	mov ch, al

	mov eax, ecx
	ret
    
    ;max
    push eax
    mov eax, 0
    mov al, g_slotrows
    mov bl, 6
	mul bl
    mov ecx, eax    
    pop eax
    
    mov ebx, 0
    and eax, 0000ff00h
    mov al, ah
    mov ah, 0
    mov bl, g_slotrows
    mul bl
    ; sub the max from the current value
    sub cl, al
    mov al, cl
    mov dh, al

    pop eax
    push eax
    and eax, 000000ffh
    mov bl, g_slotcolumns
    mul bl
    add al, g_barcolumns
    mov dl, al
    pop eax
    mov ax, dx

    pop edx
    pop ecx
    pop ebx

    ret
ConvertRowCol ENDP

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
		mov al, -1
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


InitSprites PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	mov ecx, lengthof ca_barleftraw
	mov esi, offset ca_barLeftraw
	mov edi, offset ca_barRightraw
	add edi, ecx
	dec edi
is_fillBarRight:
	mov al, [esi]
	mov [edi], al
	inc esi
	dec edi
	Loop is_fillBarRight

	mov esi, offset cqs_tokenslice
	mov edi, offset ca_tokenRaw
	mov bl, cqs_slotslicey
	mov bh, cqs_slotslicex
	Call convertquartersprite
	mov esi, Offset ca_tokenRaw
	mov edi, Offset g_token
	mov ecx, lengthof ca_tokenRaw
	Call changearray

	mov esi, offset cqs_slotslice
	mov edi, offset ca_slotraw
	Call convertquartersprite
	mov esi, Offset ca_slotraw
	mov edi, Offset g_tokenslot
	mov ecx, lengthof ca_slotraw
	Call changearray


	mov esi, Offset ca_barRightraw
	mov edi, Offset g_barRight
	mov ecx, lengthof ca_barRightraw
	Call changearray

	mov esi, Offset ca_barleftraw
	mov edi, Offset g_barleft
	mov ecx, lengthof ca_barleftraw
	Call changearray
	
	mov edx, offset animation_array

	mov esi, offset caa_animation1Raw
	mov edi, offset animation_1
	mov [edx], edi
	add edx, 4
	mov ecx,0
	mov cl, caa_rawanimsize
	Call changearray
	

	mov esi, offset caa_animation2Raw
	mov edi, offset animation_2
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation3Raw
	mov edi, offset animation_3
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation4Raw
	mov edi, offset animation_4
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation5Raw
	mov edi, offset animation_5
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation6Raw
	mov edi, offset animation_6
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation7Raw
	mov edi, offset animation_7
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation8Raw
	mov edi, offset animation_8
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation9Raw
	mov edi, offset animation_9
	mov [edx], edi
	add edx, 4
	Call changearray

	mov esi, offset caa_animation10Raw
	mov edi, offset animation_10
	mov [edx], edi
	Call changearray

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
InitSprites ENDP

PrintTokenSlot PROC
	;dh has current row, dl has current column
	push esi
	push ebx
	push ecx
	push eax
	mov eax, yellow
	call setTextColor
	mov esi, offset g_tokenslot
	mov ebx, 0
	mov bl, g_slotrows
	mov ecx, 0
	mov cl, g_slotcolumns
	Call PrintSprite
	mov eax, white
	call setTextColor
	pop eax
	pop ecx
	pop ebx
	pop esi
	ret
PrintTokenSlot endp


printBarRight PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov eax, yellow
	call setTextColor

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, offset g_barright
	
	mov al, g_slotcolumns
	mov bl, 7
	mul bl
	add al, g_barcolumns
	mov dl, al

	mov dh, g_slotrows
	mov eax, 7
	mov cl, g_barcolumns
	mov bl, g_slotrows
	mul bl
	mov bl, g_barrows
	mov pb_loop, al
	xchg pb_loop, cl
pbr_sideloop:
	xchg pb_loop, cl
	call PrintSprite
	inc dh
	xchg pb_loop, cl
	Loop pbr_sideloop
	
	mov eax, white
	call setTextColor

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
printbarRight endp

printbarLeft PROC
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov eax, yellow
	call setTextColor

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, offset g_barleft
	
	mov dh, g_slotrows
	mov eax, 7
	mov cl, g_barcolumns
	mov bl, g_slotrows
	mul bl
	mov bl, g_barrows
	mov pb_loop, al
	xchg pb_loop, cl
pbl_sideloop:
	xchg pb_loop, cl
	call PrintSprite
	inc dh
	xchg pb_loop, cl
	Loop pbl_sideloop
	
	mov eax, white
	call setTextColor

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
printbarLeft ENDP


PrintGrid PROC
	push ebx
	push ecx
	push edx
	mov edx, 0
	add dl, g_barcolumns
	add dh, g_slotrows
	mov ecx, 7
	mov ebx, 7
	mov pg_startingrow, dl
pg_startall:
	dec bl
	cmp bl, 0
	jle pg_done
pg_loop:
	Call PrintTokenSlot
	add dl, g_slotcolumns
	Loop pg_loop

	add dh, g_slotrows
	mov dl, pg_startingrow
	mov ecx, 7
	jmp pg_startall 
pg_done:
	pop edx
	pop ecx
	pop ebx
	ret
PrintGrid endp



ClearTokenSlot PROC
	;dh has current row, dl has current column
	push ebx
	push ecx
	mov ebx, 0
	mov bl, g_slotrows
	mov ecx, 0
	mov cl, g_slotcolumns
	Call clearSprite
	pop ecx
	pop ebx
	ret
ClearTokenSlot endp



PrintToken PROC
	;dh has current row, dl has current column
	push esi
	push ebx
	push ecx
	push eax

	call getcurrentplayer
	cmp al, 1
	je printtoken_playerone
	cmp al, 2
	je printtoken_playertwo
	
	printtoken_playerone:
		mov eax, red
		jmp printtoken_colorselected
	printtoken_playertwo:
		mov eax, blue
		jmp printtoken_colorselected

	printtoken_colorselected:
	call setTextColor
	;dh has current row, dl has current column
	mov esi, offset g_token
	mov ebx, 0
	mov bl, g_slotrows
	mov ecx, 0
	mov cl, g_slotcolumns
	Call PrintSprite
	mov eax, white
	call setTextColor
	pop eax
	pop ecx
	pop ebx
	pop esi
	ret
PrintToken endp



ClearToken PROC
	call ClearTokenslot
	ret
ClearToken endp



convertquartersprite PROC
	; esi has the quarter
	; edi has the receptacle
	; bl has the rows of slice, bh has the columns of slice
	
	; dl will be row counter, dh will be column counter
	
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov cqs_slice, esi
	mov ecx, 0
	mov cl, bl
	mov dx, 0

cqs_loopUpLeft:
	mov al, [esi] 
	mov [edi], al
	inc edi
	inc esi
	inc dl
	cmp dl, bh
	jl cqs_loopupleft
	dec esi
	mov dl, 0
cqs_loopUpRight:
	mov al, [esi] 
	mov [edi], al
	inc edi
	dec esi
	inc dl
	cmp dl, bh
	jl cqs_loopupright
	inc esi
	push eax
	mov eax, 0
	mov al, bh
	add esi, eax
	pop eax
	mov dl, 0
	Loop cqs_loopUpLeft
	
	push eax
	mov eax, 0
	mov al, bh
	sub esi, eax
	pop eax
	mov cl, bl

cqs_loopDownLeft:
	mov al, [esi] 
	mov [edi], al
	inc edi
	inc esi
	inc dl
	cmp dl, bh
	jl cqs_loopDownleft
	dec esi
	mov dl, 0
cqs_loopDownRight:
mov al, [esi] 
	mov [edi], al
	inc edi
	dec esi
	inc dl
	cmp dl, bh
	jl cqs_loopDownright
	inc esi
	push eax
	mov eax, 0
	mov al, bh
	sub esi, eax
	pop eax
	mov dl, 0
	Loop cqs_loopDownLeft
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
convertquartersprite endp


printSprite PROC
	;bl has rows
	;cl has columns
	;dh has current row, dl has current column
	;esi has total image
	push eax
	push ebx
	push ecx
	push edx
	push esi

	mov ps_x, dl
	mov ps_y, dh
	mov ps_int, cl
	mov ps_rows, dl
	mov ps_columns, dh
ps_startall:
	Call gotoXY
	dec bl
	cmp bl, 0
	jl ps_endprint

ps_printloop:
	mov al, [esi]
	inc dl
	cmp al, 32
	je ps_dontprint
	Call WriteChar
ps_dontprint:
	Call gotoxy
	inc esi
		loop ps_printloop
	mov dl, ps_x
	inc dh
	call gotoxy
	mov cl, ps_int
	jmp ps_startall
ps_endprint:
	mov edx,0
	Call gotoXY
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	ret
printSprite endp


changeArray PROC
	;esi has source
	;edi has destination
	;ecx has size of array
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
ca_start:
	mov bl, [esi]
	mov dl, 1
	cmp [esi],dl
	jne ca_d1
	mov bl, 32
	jmp ca_doneloop
ca_d1:
	mov dl, 2
	cmp [esi], dl
	jne ca_d2
	mov bl, 176
	jmp ca_doneloop
ca_d2:
	mov dl, 3
	cmp [esi], dl
	jne ca_d3
	mov bl, 177
	jmp ca_doneloop
ca_d3:
	mov dl, 4
	cmp [esi], dl
	jne ca_d4
	mov bl, 178
	jmp ca_doneloop
ca_d4:
	mov dl, 5
	cmp [esi], dl
	jne ca_doneloop
	mov bl, 219
ca_doneloop:
	mov [edi], bl
	inc edi
	mov [edi], bl
	inc edi
	inc esi
	loop ca_start

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
changeArray endp

ClearSprite PROC
	;dh has current row, dl has current column
	;cl has num row, bl has numcolumn
	push edx
	push ecx
	push ebx
	push eax
	
	mov bh, cl
	mov ecx, 0
	mov eax, 32
	Call gotoxy
cs_startall:
	mov cl, bh
	dec bl
 	cmp bl, 0
	jl cs_doneall

cs_printloop:
	Call WriteChar
	Loop cs_printLoop
	
	inc dh
	Call gotoxy
	jmp cs_startall
cs_doneall:
	mov edx,0
	Call gotoxy
	pop eax
	pop ebx
	pop ecx
	pop edx
	ret
ClearSprite ENDP

printFirework PROC
	;al has the index of the firework animation
	;bl has rows
	;cl has columns
	;dh has current row, dl has current column
	cmp al, 0
	jge pf_aboveone
	ret
pf_aboveone:
	cmp al, 10
	jl pf_start
	ret
pf_start:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	
	push bx
	mov bh, 4
	mul bh
	mov esi, offset animation_array
	and eax, 000000FFh
	add esi, eax
	mov esi, [esi]
	pop bx
	mov bl, animation_rows
	mov cl, animation_columns
	call clearfireworks
	mov pf_x, dl
	mov pf_y, dh
	mov pf_int, cl
	mov pf_rows, dl
	mov pf_columns, dh
pf_startall:
	Call gotoXY
	dec bl
	cmp bl, 0
	jl pf_endprint

pf_printloop:
	mov al, [esi]
	inc dl
	cmp al, 32
	je pf_dontprint
	jne pf_d1
pf_d1:
	cmp al, 176
	jne pf_d2
	push eax
	mov eax, white
	Call settextcolor
	pop eax
	jmp pf_print
pf_d2:
	cmp al, 177
	jne pf_d3
	push eax
	mov eax, red
	Call settextcolor
	pop eax
	jmp pf_print
pf_d3:
	cmp al, 178
	jne pf_d4
	push eax
	mov al, g_playerwon
	cmp al, 1
	jne pf_player2
	mov eax, red
	jmp pf_afterplayer
pf_player2:
	mov eax, blue
pf_afterplayer:
	Call settextcolor
	pop eax
	jmp pf_print
pf_d4:
	cmp al, 219
	jne pf_print
	push eax
	mov eax, gray
	Call settextcolor
	pop eax
	jmp pf_print

pf_print:
	Call WriteChar
pf_dontprint:
	Call gotoxy
	inc esi
		loop pf_printloop
	mov dl, pf_x
	inc dh
	call gotoxy
	mov cl, pf_int
	jmp pf_startall
pf_endprint:
	mov eax, gray
	call settextcolor
	mov edx,0
	Call gotoXY
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	ret
printFirework endp


Clearfireworks PROC
	;dh has current row, dl has current column
	push ebx
	push ecx
	mov bl, animation_rows
	mov cl, animation_columns
	call clearsprite
	pop ecx
	pop ebx
	ret
Clearfireworks ENDP

end main

Clearfireworks PROC
	;dh has current row, dl has current column
	push ebx
	push ecx
	mov bl, animation_rows
	mov cl, animation_columns
	call clearsprite
	pop ecx
	pop ebx
	ret
Clearfireworks ENDP

end main
