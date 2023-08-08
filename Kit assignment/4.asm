;4. Write the 8086 machine code to calculate the GCD of two unsigned 16-bit numbers.
.model small 
.stack 100h
.data
    num1 dw 147
    num2 dw 42
    gcd  dw ?
.code

main PROC
    mov ax,@data
    mov ds,ax

    mov bx,num1
    mov dx,num2
    mov cx,2        
    call find_gcd

    mov bx,ax
    call printf

    mov ah,4Ch
    int 21h
main ENDP
;-------------------------------------------------------------------
;                            find_gcd
;Task:      Finds gcd of two nsigned integers
;Receives:  bx,dx,(in the first call cx=2)
;Returns:   ax
;-------------------------------------------------------------------
find_gcd PROC
    cmp cx,bx
    jg conditional_return

    cmp cx,dx
    jg conditional_return

    mov ax,bx
    div cl
    cmp ah,0
    jne Non_divisible
    mov bx,ax           ;we don't need to restore bx 's previous value even if dx is not divisible by cl 's current value

    mov ax,dx       
    div cl
    cmp ah,0
    jne Non_divisible
    mov dx,ax           ;ah is already 0

    push cx
    call find_gcd
    jmp endd
    Non_divisible: 
        mov ax,1
        push ax         ;to maintain the symmetry in the runtime stack so that while popping cx 
                        ;at the time of returning the values that devides the numbers get popped into instead of the return addresses
        inc cx
        call find_gcd
    endd:
        pop cx
        mul cx
        jmp return
    conditional_return:
        mov ax,1
        ret
    return:
        ret
find_gcd ENDP
;------------------------------------------------------
;               printf
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
