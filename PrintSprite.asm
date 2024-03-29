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


ca_slotraw db 36 DUP(0)
ca_tokenraw db 36 DUP(0)
ca_barleftRaw db 2,3,4,4
ca_barRightRaw db 4 Dup(0)


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

animation_array dd 10 DUP(0)

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

pf_int db 0
pf_rows db 0
pf_columns db 0
pf_x db 0
pf_y db 0

pb_loop db 0

pg_startingrow db 0
.code

main PROC	
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	Call initSprites
	
	mov cl, 30
	mov bl, 15
	mov edx, 0
m_startanim:
	mov edi, offset animation_array
	mov eax, 0
m_animfirework:
	mov esi, [edi]
	
	call printfirework
	inc eax
	add edi, 4
	mov esi, [edi]
	push eax
	mov eax, 100
	call delay
	call clearsprite
	pop eax
	cmp eax, 10
	jl m_animfirework
	jmp m_startanim


	exit

	;call printbarright
	;call printbarleft
	;call printgrid

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

ConvertRowCol PROC
	push ebx
	push ecx
	push edx
	mov edx, 0
	push eax
	
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


printFirework PROC
	;bl has rows
	;cl has columns
	;dh has current row, dl has current column
	;esi has total image
	push eax
	push ebx
	push ecx
	push edx
	push esi

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
	mov eax, blue
	;; change this to do both colors
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
	mov edx,0
	Call gotoXY
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	ret
printFirework endp



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

end main