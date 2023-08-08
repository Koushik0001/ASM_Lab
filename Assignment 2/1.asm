;1. Write an 8086 assembly language program to calculate the GCD of two unsigned 16 bit 
;numbers.

.model small
.stack 100h
.data

    val1 dw 500
    val2 dw 145

    tval1 dw ?
    tval2 dw ?

    gcd dw ?

    _num dw ?
    _len dw ?
    _digit dw ?
    _temp dw ?
    _E10 dw ?
.code 
main PROC
    mov ax,@data
    mov ds,ax

    mov gcd,1
    mov ax,val1
    mov tval1,ax

    mov ax,val2
    mov tval2,ax

    mov dx,0
    mov bx,2
    test1:
        mov ax,tval1
        div bx
        cmp dx,0
        je test2
        jmp go_around
        test2:
            mov tval1,ax
            mov ax, tval2
            div bx
            cmp dx,0
            je multiply
            mov ax,tval1
            mul bx
            mov tval1,ax
            jmp go_around
            multiply:              ;gcd = gcd * bl   
                mov tval2,ax          
                mov ax,gcd
                mul bx
                mov gcd,ax
                jmp test1
        go_around:
            inc bx
            mov dx,0

        mov ax,tval1
        cmp ax,0
        je print_gcd

        mov ax,tval2
        cmp ax,0
        je print_gcd

        cmp bx,tval1
        jg print_gcd

        cmp bx,tval2
        jg print_gcd

    jmp test1

    print_gcd:
       mov  ax,gcd
        mov _num,ax

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

