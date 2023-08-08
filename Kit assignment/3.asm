;3. Write the 8086 machine code to count the number of “1”s present in a 16-bit number and 
;store the counter in some memory location. (e.g. in 34(=100010), there are two “1”s)
.model small 
.stack 100h
.data
    num dw 111101b
.code

main PROC
    mov ax,@data
    mov ds,ax

    mov bx,num
    mov cl,0        ;cl is returned by count_ones function so 0 is stored there first
    call count_ones

    mov dl,cl
    add dl,48
    mov ah,6
    int 21h

    mov ah,4Ch
    int 21h
main ENDP
;------------------------------------------------------------------------------
;               count_ones
;Task:      Counts the number of ones in the binary reparesentation of a number
;Receives:  bx
;Returns:   cl (number of ones present) 
;-----------------------------------------------------------------------------
count_ones PROC
    mov ax,bx
    mov bl,2

    div bl
    add cl,ah
    cmp al,0
    je return 
    mov ah,0
    mov bx,ax
    call count_ones
    return:
        ret
count_ones ENDP
end main
