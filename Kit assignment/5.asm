;5. Write the 8086 machine code to search the smallest number in an array of ten 8-bit 
;numbers. The array of numbers (bytes) is stored in memory.
.model small 
.stack 100h
.data
    array db 97,35,23,21,51,12,20,100,80,10
.code
main PROC
    mov ax,@data
    mov ds,ax


    mov bx,offset array
    mov cl,lengthof array 
    mov ch,0
    call find_smallest
            
    mov ah,0
    mov bx,ax
    call printf

    mov ah,4Ch
    int 21h
main ENDP
;--------------------------------------------------------------
;                   find_smallest
;Task:      Find the smallest the number in the array
;Receives:  bx(offset of the array),cx(length of the array
;Returns:   ax(smallest number of the array)
;-------------------------------------------------------------
find_smallest PROC
    mov si,0
    continue:
        mov al,[bx+si]
    start:           
        mov dl,[bx+si]
        cmp al,dl
        jg continue
        inc si
        cmp si,cx
    jl start 
    ret
find_smallest ENDP
;------------------------------------------------------
;               printf
;Task:      prints an integer
;Receives:  bx (The number to printed)
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
