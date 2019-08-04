TITLE PrintSprite

; Eric Scherfling

INCLUDE Irvine32.inc
.data
mymessage1 db 4,3,3,3,4,1,3,1,1
mymessage2 db 36 DUP(0)
mymessage3 db 72 DUP(0)
ps_int db 0
cqs_rows db 0
cqs_columns db 0
cqs_slice dd 0
.code

main PROC	

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	mov esi, offset mymessage1
	mov edi, offset mymessage2
	mov bl, 3
	mov bh, 3
	Call convertquartersprite


	mov edi, Offset mymessage2
	mov esi, Offset mymessage3
	mov ecx, lengthof mymessage2
	Call changearray
	mov esi, offset myMessage3
	mov ebx, 6
	mov ecx, 12
	mov edx, 0
loopem:
	Call ReadInt
	mov dl, al
	Call ReadInt
	mov dh, al	
	mov ebx, 6
	mov ecx, 12
	mov esi, offset myMessage3
	Call printSprite

	jmp loopem

endProgram:
	exit
main ENDP


convertquartersprite PROC
	; esi has the quarter
	; edi has the receptacle
	; bl has the rows of slice, bh has the columns of slice
	
	; dl will be row counter, dh will be column counter
	
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
	ret
convertquartersprite endp


printSprite PROC
	;ebx has columns
	;ecx has rows
	;esi has total image
	;edh has current column, edl has current row
	mov edi, Offset ps_int
	mov [edi], ecx
ps_startall:
	Call gotoXY
	dec ebx
	inc dh
	cmp ebx, 0
	jl ps_endprint
ps_printloop:
	mov eax, [esi]
	Call WriteChar
	inc esi
		loop ps_printloop
	
	mov eax, 13
	call writechar
	mov eax, 10
	call writechar
	mov ecx, [edi]
	jmp ps_startall
ps_endprint:
	mov edx,0
	Call gotoXY
	ret
printSprite endp


changeArray PROC
ca_start:
	mov bl, [edi]
	mov dl, 1
	cmp [edi],dl
	jne ca_d1
	mov bl, 32
	jmp ca_doneloop
ca_d1:
	mov dl, 2
	cmp [edi], dl
	jne ca_d2
	mov bl, 176
	jmp ca_doneloop
ca_d2:
	mov dl, 3
	cmp [edi], dl
	jne ca_d3
	mov bl, 177
	jmp ca_doneloop
ca_d3:
	mov dl, 4
	cmp [edi], dl
	jne ca_d4
	mov bl, 178
	jmp ca_doneloop
ca_d4:
	mov dl, 5
	cmp [edi], dl
	jne ca_doneloop
	mov bl, 219
ca_doneloop:
	mov [esi], bl
	inc esi
	mov [esi], bl
	inc esi
	inc edi
	loop ca_start
	ret
changeArray endp

END main