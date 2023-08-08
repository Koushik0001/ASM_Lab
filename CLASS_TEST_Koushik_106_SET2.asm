;2. Write an assembly language program which takes a long string as input from
;the keyboard and check how many no. of vowel, consonant, and digits are
;present in it. Display the result.   
.model small
.stack 100h
.data    
    prompt db 'Enter a string ',0Ah,'$'
    prompt_vowel db 0Ah,'vowel = $'
    prompt_consonant db 0Ah,'consonant = $'
    prompt_digits db 0Ah,'digits = $'
    vowels db 0
    consonants db 0
    digits db 0
.code
main proc
mov ax, @data
mov ds, ax  

mov cl,0

mov dx, offset prompt
mov ah, 9
int 21h                ;prompt to enter the string

mov dx, 0
mov bl, 10
ip:
    mov ah, 1
    int 21h
    cmp al, 13
    je pr_end
    mov bl,al

    call vowel
    cmp cl,0
    je checkConsonant
    inc vowels
    jmp outt
    checkConsonant:
        call consonant
    cmp cl,0
    je checkDigit
    inc consonants
    jmp outt
    checkDigit:
        call digit
    cmp cl,0
    je outt
    inc digits 
    outt:
    inc dx
jmp ip
pr_end:
mov dx, offset prompt_vowel
mov ah, 9
int 21h

mov bl,vowels
call printf

mov dx, offset prompt_consonant
mov ah, 9
int 21h

mov bl,consonants
call printf

mov dx, offset prompt_digits
mov ah, 9
int 21h

mov bl,digits
call printf

   mov ah,4Ch
   int 21h
main endp
;-------------------------------------------------
;                   vowel
;Task:      Returns cl = 1 if the character is a vowel
;Receives:  bl
;Returns:   cl
;-------------------------------------------------
vowel proc
    mov dl,bl
    and dl,11011111b

    cmp dl,65 ;A=65
    je incrementv

    cmp dl,69 ;E=69
    je incrementv

    cmp dl,73 ;I=73
    je incrementv

    cmp dl,79 ;O=79
    je incrementv

    cmp dl,85 ;U=85
    je incrementv
    mov cl,0
    jmp returnv

    incrementv:
        mov cl,1
    returnv:
        ret
vowel endp
;-------------------------------------------------
;               consonant
;Task:      Returns cl = 1 if the character is a vowel
;Receives:  bl,al
;Returns:   al
;-------------------------------------------------
consonant proc
    mov dl,bl
    and dl,11011111b
    cmp dl,64
    jg nextCheckC
    mov cl,0
    jmp returnc
    nextCheckC:
        cmp dl,91
        jl incrementc
        mov cl,0
        jmp returnc
    incrementc:
        mov cl,1
    returnc:
        ret
consonant endp
;-------------------------------------------------
;               digit
;Task:      Returns cl = 1 if the character is a vowel
;Receives:  bl
;Returns:   cl
;-------------------------------------------------
digit proc
    mov dl,bl
    cmp dl,47
    jg  nextCheckD
    mov cl,0
    jmp returnd
    nextCheckD:
        cmp dl,58
        jl incrementd
        mov cl,0
        jmp returnd
    incrementd:
        mov cl,1
    returnd:
        ret
digit endp 
;---------------------------------------------------------------
;               printf
;
;Task:      prints an integer
;Receives:  bx
;Returns:   void
;---------------------------------------------------------------
printf proc uses ax bx cx dx 
    mov ah,0
    mov bh,0
    mov dh,0
    mov ch,0

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

