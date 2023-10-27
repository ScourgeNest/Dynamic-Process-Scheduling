%include "../include/io.mac"

section .data

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    mov ecx, eax;for(int i = n - 1; i >= 0; i--) {
    dec ecx
for1:
    push ecx
    mov ecx, eax;for(int j = n - 1; j >= 0; j--) {
for2:
    dec ecx
    mov ebx, 5; ebx = 5
    push edx
    push eax
    push ecx
    mov eax, ecx
    imul eax, ebx; eax = ecx * 5
    add eax, 2; eax += 2
    add edx, eax; edx += eax
    mov esi, edx; esi = edx
    mov ebx, esi; ebx = esi
    sub ebx, 5; ebx -= 5
    xor eax, eax
    mov al, [esi]; eax = p[j].prio;
    mov cl, [ebx]; ecx = p[j - 1].prio;
    cmp al, cl; if(p[j].prio < p[j - 1].prio) {
    jge else_if
        push eax
        push edx
        push ecx
        sub esi, 2
        sub ebx, 2
        mov eax, [esi]; eax = p[j];
        mov ecx, [ebx]; ecx = p[j - 1];
        mov [esi], ecx; p[j] = p[j - 1];
        mov [ebx], eax; p[j - 1] = eax;
        pop ecx
        pop edx
        pop eax
        jmp final_loop
    ;}
else_if:; else if (p[j].prio == p[j - 1].prio) {
    xor eax, eax
    mov al, [esi]; eax = p[j].prio;
    mov cl, [ebx]; edi = p[j - 1].prio;
    cmp al, cl
    jnz final_loop
        add esi, 1
        add ebx, 1
        xor eax, eax
        mov ax, [esi]; eax = p[j].time;
        mov cx, [ebx]; edi = p[j - 1].time;
        cmp ax, cx; if(p[j].time < p[j - 1].time) {
        jge else_if_2
            push eax
            push edx
            push ecx
            sub esi, 3
            sub ebx, 3
            mov eax, [esi]; proc aux = p[j];
            mov ecx, [ebx]
            mov [esi], ecx; p[j] = p[j - 1];
            mov [ebx], eax; p[j - 1] = aux;
            pop ecx
            pop edx
            pop eax
            jmp final_loop
        ;}
else_if_2:; else if (p[j].time == p[j - 1].time) {
        xor eax, eax
        mov ax, [esi]; eax = p[j].time;
        mov cx, [ebx]; edi = p[j - 1].time;
        cmp ax, cx
        jnz final_loop
            sub esi, 3; esi = p[j].pid
            sub ebx, 3; ebx = p[j - 1].pid
            xor eax, eax
            mov ax, [esi]; eax = p[j].pid;
            mov cx, [ebx]; edi = p[j - 1].pid;
            cmp ax, cx; if(p[j].pid < p[j - 1].pid) {
            jge final_loop
            push eax
            push edx
            push ecx
            mov eax, [esi]; proc aux = p[j];
            mov ecx, [ebx]
            mov [esi], ecx; p[j] = p[j - 1];
            mov [ebx], eax; p[j - 1] = aux;
            pop ecx
            pop edx
            pop eax


final_loop:
    pop ecx
    pop eax
    pop edx
    cmp ecx, 1
    jg for2
    pop ecx
    cmp ecx, 1
    dec ecx
    jg for1
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

;Am scirs codul in C si l-am transformat in assembly:

; #include <stdio.h>

; typedef struct proc{
;     short pid;
;     char prio;
;     short time;
; }proc;

; int main ()
; {
;     int n;
;     scanf("%d", &n);
;     proc p[14];
;     for(int i = 0; i < n; i++) {
;         scanf("%hd %c %hd", &p[i].pid, &p[i].prio, &p[i].time);
;     }
;     printf("\n\n");
;     for(int i = 0; i < n; i++) {
;         printf("%hd %c %hd\n", p[i].pid, p[i].prio, p[i].time);
;     }
;     printf("\n\n");
;     //Bubble sort the vector of structs
;     for(int i = 0; i < n - 1; i++) {
;         for(int j = 0; j < n - 1; j++) {
;             if(p[j].prio > p[j + 1].prio) {
;                 proc aux = p[j];
;                 p[j] = p[j + 1];
;                 p[j + 1] = aux;
                
;             } else if (p[j].prio == p[j + 1].prio) {
;                 if(p[j].time > p[j + 1].time) {
;                     proc aux = p[j];
;                     p[j] = p[j + 1];
;                     p[j + 1] = aux;
;                 } else if (p[j].time == p[j + 1].time) {
;                     if(p[j].pid > p[j + 1].pid) {
;                         proc aux = p[j];
;                         p[j] = p[j + 1];
;                         p[j + 1] = aux;
;                     }
;                 }
;             }
;         }
;     }

;     for(int i = 0; i < n; i++) {
;         printf("%hd %c %hd\n", p[i].pid, p[i].prio, p[i].time);
;     }
;     return 0;
; }