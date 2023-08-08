;6. Write a program to multiply two unsigned word integers and display the product. The integers 
;are stored in two variables in the data segment, namely X and Y each of which is a “word”
;data. Store the product in a variable which is 4 bytes long. Handle overflow case.
.model small
.stack 100h 
.data 
    num dw 25440
.code
main proc
    mov ax,@data
    mov ds,ax

    mov bx,num
    call printf

    mov ah,4Ch
    int 21h
main endp
;---------------------------------------------------------------
;               printf
;
;Task:      prints an integer
;Receives:  bx
;Returns:   void
;---------------------------------------------------------------
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