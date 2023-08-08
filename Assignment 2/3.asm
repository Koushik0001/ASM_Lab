;3. Write an 8086 alp to sort in ascending order using Insertion Sort algorithm, a given set of 16 
;bit unsigned numbers in memory.
.model small
.stack 100h 
.data
    array dw 900,1000,375,1501,501,125,0,5,9,1900
    key dw ?
    current_key_index dw ?

    _num dw ?
    _len dw ?
    _digit dw ?
    _temp dw ?
    _E10 dw ?
.code
main PROC
    mov ax,@data
    mov ds,ax

    mov cx,lengthof array
    dec cx

    mov di,2
    insertion_sort:
        push cx
        mov bx,array[di]
        mov key,bx
        mov current_key_index,di
        mov si,di
        check:
            sub si,2     
            cmp bx,array[si] 
            jl exchange
            return:
            cmp si,0
            je next_key
        jmp check
        next_key:
        mov di,current_key_index
        add di,2
        pop cx
    loop insertion_sort
    mov cx,lengthof array
    jmp print

    exchange:       
        mov ax,array[si]
        mov array[di],ax
        mov array[si],bx      ;bx already holds key value because of line 26
        mov di,si
    jmp return
    
    print:
        push cx
        mov dx,array[si]
        mov _num,dx

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

        add si,2

        mov dx,32
        mov ah,6
        int 21h

        pop cx
    loop print

    mov ah,4Ch
    int 21h
main ENDP
end main