;Program to check for password
.model small
.stack 100h
.data
    pw db 'Runthis$' 
    str db 100 dup(0) 
    plen db 7 
    len db 0 
    f db 0 
    try db 0 
    msg1 db 'Enter the password : $'
    msg2 db 'Password Incorrect! Try again. $'
    msg3 db ' attempt(s) left.',10,13,'$'
    msg4 db 'You are authorized person.$'
    msg5 db 'Maximum tries exceeded.$'
.code
main proc 
    mov ax,@data
    mov ds,ax
    loop1:
        inc try
        mov f,0
        
        mov dx,offset msg1
        mov ah,9
        int 21h
      
        mov len,0
        mov si,offset str
        loop2:
            mov ah,1
            int 21h
            cmp al,13
            je exitloop2
            mov [si],al
            inc si
            inc len
        jmp loop2
        exitloop2:
        mov bl,'$'
        mov [si],bl
        
        cmp len,7
        je skiptocompare
            mov f,1
            jmp break3
        skiptocompare:
        
        mov si,offset pw
        mov di,offset str
        mov cl,plen
        loop3:
            mov bl,[si]
            mov dl,[di]
            cmp bl,dl
            je continue3
                mov f,1
                jmp break3
            continue3:
            inc si
            inc di
        loop loop3
        break3:
        cmp f,0
        je positive
        cmp try,3
        je negative
       
        mov dx,offset msg2
        mov ah,9
        int 21h
        
        mov dh,0
        mov dl,51 
        sub dl,try
        mov ah,2
        int 21h
        
        mov dx,offset msg3
        mov ah,9
        int 21h
    jmp loop1
    positive:
        
        mov dx,offset msg4
        mov ah,9
        int 21h
        jmp exitprog
    negative:
        
        mov dx,offset msg5
        mov ah,9
        int 21h
    exitprog:
    mov ah,4ch
    int 21h
main endp
end main
