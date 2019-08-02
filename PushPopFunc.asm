TITLE PushPop					(PushPopFunc.asm)

INCLUDE Irvine32.inc
.data

.code
  ; contains three functions
  ; pushregs -> for pushing the general purpose regs and then clearing
  ; popregs -> for returning values on the stack to their associated gen purpose reg
  ; clearregs -> clears the registers to 0

  ; main procedure
main PROC
	
	call clearregs
  
    ; test values
	mov eax, 1
	mov ebx, 2
	mov ecx, 3
	mov edx, 4
  mov esi, 5
	mov edi, 6

	call pushregs
	;call printregs
	call popregs
	;call printregs

	call clearregs

	exit
main ENDP	
  
  ; functions belows
  
  ;push the registers 
pushregs PROC
    
    ; need to utilize the stack pointer frame, ebp
    ; this stores the current stack in esp, so that the procedure can return
    ; -> the ret call is stored on the stack and will be overwritten otherwise
	mov ebp, esp

    ; push values onto the stack
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
    ; clear the registers for reuse
	call clearregs

    ; store the register values on ebp and return the original state of esp
    ; so function can return to main
	xchg esp, ebp

	ret
pushregs ENDP

  ; pop the registers 
popregs PROC
	
    ; place the register values back into esp to be popped
	xchg esp, ebp

    ; return values from stack, in opposite order from push
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax

    ; return original state of esp so function can return
	xchg ebp, esp

	ret
popregs ENDP

  ; clear the registers
clearregs PROC
	
    ; use xor, same result as mov reg, 0
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi
	xor edi, edi

	ret
clearregs ENDP
