;1. Write the 8086 machine code to check whether a number is prime or not.
.model small
.stack 100h
.data 
    num dw 103
    prompt_Prime db " is Prime.",0Ah,'$'
    prompt_NotPrime db " is Not Prime.",0Ah,'$'
.code
main PROC
    mov ax,@data
    mov ds,ax
    
    mov bx,num
    call check_prime      

    cmp dx,0
    je prompt_np  
    mov bx,num
    call printf
    mov ah,9
    mov dx,offset prompt_Prime
    int 21h  
    jmp endd

    prompt_np: 
        mov bx,num
        call printf
        
        mov ah,9
        mov dx,offset prompt_NotPrime
        int 21h
                 
    endd:
    mov ah,4Ch
    int 21h
main ENDP
;------------------------------------------------------
;                   check_prime
;
;Task:      Checks Wheather a number is prime or not.
;Receives:  bx
;returns:   dx=1 if prime
;           dx=0 if not prime
;------------------------------------------------------
check_prime PROC
    mov cl,2
    mov ax,bx
    div cl
    mov ah,0
    mov dl,al         ;dl = bx/2
    check:
        mov ax,bx 
        div cl
        cmp ah,0
        je not_prime
        inc cl
        cmp cl,dl
    jl check
    jmp return_prime
    not_prime:
        mov dx,0
        ret
    return_prime:
        mov dx,1
        ret    
check_prime ENDP  
;------------------------------------------------------
;               printf
;
;Task:      prints an integer
;Receives:  bx
;Returns:   void
;------------------------------------------------------
printf proc uses bx
    cmp bx,10
    mov dx,bx
    jl print

    mov ax,bx
    mov cx,10
    mov dx,0
    div cx

    push dx
    mov bx,ax
    call printf
    pop dx
    print:
        add dx,48
        mov ah,6
        int 21h 
    ret
printf endp
end main
