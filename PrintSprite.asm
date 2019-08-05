TITLE PrintSprite

; Eric Scherfling

INCLUDE Irvine32.inc

.data
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


.code

main PROC	
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	Call initSprites
	
	mov edx, 0
loopem:
	Call ReadInt
	mov dl, al
	Call ReadInt
	mov dh, al	
	Call printToken
	mov eax, 1000
	Call Delay
	Call printTokenSlot
	Call Delay
	Call clearTokenSlot
	jmp loopem

endProgram:
	exit
main ENDP

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
	
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
InitSprites ENDP

PrintTokenSlot PROC
	push esi
	push ebx
	push ecx
	push eax
	mov eax, yellow
	call setTextColor
	;dh has current row, dl has current column
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



ClearTokenSlot PROC
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
	push esi
	push ebx
	push ecx
	push eax
	mov eax, red
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
	;cl has columns
	;bl has rows
	;esi has total image
	;dh has current row, dl has current column
	
	push ecx
	push ebx
	push esi
	push edx

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
	
	pop edx
	pop esi
	pop ebx
	pop ecx
	
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
	;bh has num row, bl has numcolumn
	push edx
	push ebx
	push ecx
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
	pop ecx
	pop ebx
	pop edx
	ret
ClearSprite ENDP

END main