.model small
.stack 100h 
.data
    _num dw 548
    _len dw ?
    _digit dw ?
    _temp dw ?
    _E10 dw ?
.code

main PROC
    mov ax,@data
    mov ds,ax
    


    mov ax,1
    mov bx,10
    mov dx,0
    mov _len,0
    _find_length:
        inc _len
        mul bx
        cmp ax,_num
        jle _find_length


    mov cx,_len
    mov ax,_num
    mov _temp,ax
    _extract_digit:
        push cx

        mov cx,_len
        dec cx
        mov ax,1
        mov bx,10
        mov dx,0
        cmp cx,0
        je _found
        _divider:
            mul bx
        loop _divider
        _found:
        mov _E10,ax

        mov ax,_temp
        mov bx,_E10
        mov dx,0
        div bx 
        mov _digit,ax
        mov _temp,dx

        jmp _print 
        _return: 

        dec _len
        pop cx
    loop _extract_digit
    jmp _endd


    _print:
        mov dx,_digit
        add dx,48
        mov ah,6
        int 21h 
    jmp _return
    
    _endd:
    mov ah,4Ch
    int 21h
main ENDP
end main