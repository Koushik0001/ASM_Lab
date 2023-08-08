;2. Write an 8086 assembly language program to generate all prime numbers for a given range. 
;For e.g. if anyone input the range 10 to 20, the program will return: 11, 13, 17, 19.

.model small
.stack 100h
.data
    ll dw 200
    ul dw 250
    temp dw ?

    _num dw ?
    _len dw ?
    _digit dw ?
    _temp dw ?
    _E10 dw ?

.code
main PROC
        mov ax,@data
        mov ds,ax

        mov ax,ll
        mov temp,ax
        mov dx,0
        loop1:
            mov bx,2
            cmp ax,2
            jle prime
            loop2:
                div bx
                cmp dx,0
                je not_prime
                mov dx,0
                mov ax,temp
                inc bx
                cmp bx,ax
                jl loop2
            cmp bx,ax
            je prime
    not_prime:
            mov ax,temp
            inc ax
            mov temp,ax
            mov dx,0
            cmp ax,ul
            jle loop1
        jmp endd

    prime:
        mov  ax,temp
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
        mov dx,10
        mov ah,6
        int 21h
    jmp not_prime

endd:
    mov ah,4Ch
    int 21h
main ENDP
end main