;6. Write a program to multiply two unsigned word integers and display the product. The integers 
;are stored in two variables in the data segment, namely X and Y each of which is a “word”
;data. Store the product in a variable which is 4 bytes long. Handle overflow case.    

.model small
.stack 100h
.data
    x dw 1254
    y dw 1000
    product dw ?
    
    _num dw ?
    _len dw ?
    _digit dw ?
    _temp dw ?
    _E10 dw ?
.code
    main proc
        mov ax,@data            
        mov ds,ax
        
        mov ax,x
        mov bx,y
        
        mul bx  
        
        mov si,2
        
        mov product,ax
        mov product[si],dx
       print:   
       push cx
       mov ax,x[si] 
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
    
        push cx         
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
       pop cx
       sub si,2
       loop print
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
        
    main endp
    end main