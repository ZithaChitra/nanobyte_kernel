[org 0x7c00]
[bits 16]

start:
    jmp main


; Prints a string to the screen.
; Params:
;   - ds:si points to string
puts:
    ; save registers we will modify
    push si
    push ax


.loop:
    lodsb           ; loads next char in al
    or al, al       ; verify if next char is null ?
    jz .done

    mov ah, 0x0e
    ;mov bh, 0       ; set page number to 0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret



main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ;setup stack
    mov ss, ax
    mov sp, 0x7c00

    ; print message
    mov si, msg_hello
    call puts

    jmp $


msg_hello: db "Hello Friend" , 0
jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
