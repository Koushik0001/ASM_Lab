;Program to multiply two unsigned word integers
.model small
.stack 100h
.data
    x dw ? 
    y dw ? 
    p dw 2 dup(?) 
    str db ?
    fl db 0 
    msg1 db 'Enter num1 in hexadecimal  : $'
    msg2 db 'Enter num2 in hexadecimal  : $'
    msg3 db 'The product is : (HEX) $'
.code
main proc  
    mov ax,@data
    mov ds,ax
   
    mov dx,offset msg1
    mov ah,9
    int 21h
   
    call gethex
    mov x,bx
   
    mov dx,offset msg2
    mov ah,9
    int 21h
 
    call gethex
    mov y,bx
   
    mov dx,0
    mov ax,x
    mov bx,y
    mul bx
    
    mov si,offset p
    mov [si],dx             
    add si,2
    mov [si],ax             
    
    mov di,offset p
    mov bx,[di]             
    add di,2
    mov si,[di]            
    mov di,offset str
    mov dh,2                
    loop1:
        mov ch,4             
        mov cl,4            
        loop2:
            rol bx,cl        
            mov dl,bl       
            and dl,0fh      
            cmp dl,9      
            jbe skip1  
                add dl,7  
            skip1:
            add dl,30h     
            cmp fl,0
            jne skip2
                cmp dl,'0'
                je skip3
                mov fl,1
            skip2:
                mov [di],dl
                inc di
            skip3:
            dec ch          
        jnz loop2  
        dec dh              
        cmp dh,0  
        mov bx,si          
    jnz loop1
    mov bl,'$'
    mov [di],bl
  
    mov dx,offset msg3
    mov ah,9
    int 21h
   
    mov dx,offset str
    mov ah,9
    int 21h
   
    mov ah,4ch 
    int 21h
main endp
gethex proc 
    mov bx,0
    mov cl,4
    loop3:
        mov ah,1
        int 21h
        cmp al,13
        je endd
        cmp al,57
        jle skip4
            sub al,7
        skip4:
        sub al,48
        rol bx,cl
        or bl,al
        jmp loop3
    endd:
    ret
gethex endp
end main
