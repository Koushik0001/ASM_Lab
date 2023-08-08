;5. Write an 8086 alp to find out if a substring (which would be taken from keyboard) is present 
;in a given string (which would be taken from keyboard) or not. If the substring is present it 
;will return the location (or index) from where it matches otherwise print a negative massage.

.model small
.stack 100h
.data 
    string db "Now you see me...$"
    sub_string db "you see you"
    outer_counter dw ?
    first_match dw ?
    index_main_st dw ?
    index_sub_st dw ?
.code
main PROC
    mov ax,@data
    mov ds,ax 

    mov cx,lengthof string
    
    mov index_main_st,0
    mov index_sub_st,0

    loop1:
        mov si,index_sub_st
        mov dl,sub_string[si]
        mov si,index_main_st
        cmp dl,string[si]
        je full_comp
        jmp continue
        return:
            pop cx
        continue:
            inc [index_main_st]
            mov index_sub_st,0
    loop loop1
    cmp cx,0
    je not_found 

    full_comp:
        mov first_match,si
        push cx
        mov cx,lengthof sub_string
        sub cx,1
        mov si,index_main_st
        mov di,index_sub_st
        loop2:
            inc si 
            inc di
            mov dl,sub_string[di]
            cmp dl,string[si]
            jne return
        loop loop2
        cmp cx,0
        je found 

    found:
        mov dx,first_match
        add dx,48
        mov ah,6
        int 21h
        jmp endd
    not_found:
        mov dl,'N'
        mov ah,6
        int 21h
    
    endd:
    mov ah,4Ch
    int 21h
main ENDP
end main