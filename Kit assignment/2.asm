;Write the 8086 machine code to compute the difference of two numbers and store the 
;magnitude and sign.
.model small 
.stack 100h
.data
    a dw 10
    b dw 26
    result dw ?
    sign db ?
.code 
main PROC
    mov ax,@data
    mov ds,ax

    mov ax,a
    sub ax,b
    js negetive
    mov result,ax
    mov sign,'+'
    jmp output
    negetive:
        mov ax,b
        sub ax,a
        mov result,ax
        mov sign,'-'
    output:
    mov bx,a
    call printf

    mov ah,6
    mov dl,'-'
    int 21h

    mov bx,b
    call printf

    mov ah,6
    mov dl,'='
    int 21h

    mov ah,6
    mov dl,sign
    int 21h

    mov bx,result
    call printf

    mov ah,4Ch
    int 21h
main ENDP
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