%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0
i:
    dd 0
sizeof_struct:
    dd 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    push eax
    
   
    

for1:; for (int i = 0; i < n; i++) {
    push ebx
    xor ebx, ebx; ebx = 0
    mov eax, ecx ; eax = p
    add eax, [sizeof_struct]; eax = &p[i]

    xor edx, edx; edx = 0

    add eax, 2; eax = &p[i].prio

    mov dl, [eax]; dl = p[i].prio
    sub dl, 1; dl = p[i].prio - 1

    mov eax, prio_result; eax = prio_result

    imul edx, 4; edx = (p[i].prio - 1) * 4
    add eax, edx; eax = &prio_result[(p[i].prio - 1) * 4]

    xor esi, esi; esi = 0

    mov bx,  [eax]; bl = prio_result[(p[i].prio - 1) * 4]
    inc bx; bl = prio_result[(p[i].prio - 1) * 4] + 1
    mov [prio_result + edx], ebx; prio_result[(p[i].prio - 1) * 4] = prio_result[(p[i].prio - 1) * 4] + 1


    mov eax, time_result; eax = time_result

    add eax, edx; eax = &time_result[(p[i].prio - 1) * 4]

    mov si, [eax]; esi = time_result[(p[i].prio - 1) * 4]
    
    mov edi, ecx; edi = p
    add edi, [sizeof_struct]; edi = &p[i]

    add edi, 3; edi = &p[i].time
    mov ebx, edi; ebx = &p[i].time
    xor edi, edi; edi = 0

    mov di, word [ebx]; edi = p[i].time
    add esi, edi; esi = time_result[(p[i].prio - 1) * 4] + p[i].time
    mov [time_result + edx], esi; time_result[(p[i].prio - 1) * 4] =
                                ;time_result[(p[i].prio - 1) * 4] + p[i].time
    ;}
    mov edx, [sizeof_struct]; edx = sizeof(proc)
    add edx, 5; edx = sizeof(proc) + 5
    mov [sizeof_struct], edx; sizeof_struct = sizeof(proc) + 5
    mov eax, [i]; eax = i
    inc eax; eax = i + 1
    mov [i], eax; i = i + 1
    pop ebx
    cmp eax, ebx;if (i < n)
    jl for1;   
    pop eax
    mov edi, eax
    mov ecx, 4; ecx = 5


for2:; for (int i = 0; i < 5; i++) {
    mov eax, prio_result; eax = prio_result
    xor edx, edx; edx = 0
    
    push ecx
    imul ecx, 4; ecx = i * 4
    add eax, ecx; eax = &prio_result[i * 4]

    mov edx, [eax]; edx = prio_result[i * 4]

    mov eax, time_result; eax = time_result
    add eax, ecx; eax = &time_result[i * 4]
    mov esi, [eax]; esi = time_result[i * 4]

    xor eax, eax; eax = 0
    cmp edx, 0; if (prio_result[i * 4] == 0)
    jz for2_end

    mov ax, si; eax = time_result[i * 4]
    mov ebx, edi; ebx = proc_avg
    add ebx, ecx; ebx = &proc_avg[i * 4]
    
    push ecx
    xor ecx, ecx
    mov cx, dx; ecx = prio_result[i * 4]
    push edx
    xor edx, edx
    div cx; eax = time_result[i * 4] / prio_result[i * 4]

    mov word [ebx], ax; proc_avg[i * 4] = time_result[i * 4] / prio_result[i * 4]
    mov word [ebx + 2], dx; proc_avg[i * 4 + 1] = time_result[i * 4] / prio_result[i * 4]
    pop ecx
    pop ecx

for2_end:
    pop ecx
    dec ecx
    cmp ecx, 0; if (i >= 0)
    jge for2

    ;NU INTELEG DE CE NU MERGE
    ;TESTUL 1 merge, apoi nu stiu ce sa intampla si nu mai merge :(

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

;Am scris codul in C si apoi m-am folosit de el pentru a face codul in asm:
; #include <stdio.h>

; typedef struct proc {
;     short pid;
;     char prio;
;     short time; 
; }proc;

; typedef struct avg {
;     short quo;
;     short remain;
; }avg;

; int main()
; {
;     int prio_result[5];
;     for(int i = 0; i < 5; i++) {
;         prio_result[i] = 0;
;     }
;     int time_result[5];
;     for (int i = 0; i < 5; i++) {
;         time_result[i] = 0;
;     }
;     int n;
;     scanf("%d", &n);
;     proc p[13];
;     avg a[5];
;     for(int i = 0; i < 5; i++) {
;         a[i].quo = 0;
;         a[i].remain = 0;
;     }
;     for(int i = 0; i < n; i++) {
;         scanf("%hd %hhd %hd", &p[i].pid, &p[i].prio, &p[i].time);
;     }
;     printf("OUTPUT:\n");
;     for(int i = 0; i < n; i++) {
;         printf("%hd %hhd %hd\n", p[i].pid, p[i].prio, p[i].time);
;     }

;     for(int i = 0; i < n; i++) {
;         prio_result[p[i].prio - 1] += 1;
;         time_result[p[i].prio - 1] += p[i].time;
;     }
    
;     for (int i = 0; i < 5; i++)
;     {
;         printf("PRIO%d:%d  TIME%d:%d\n", 1, prio_result[i], 1, time_result[i]);
;     }
    
;     for(int i = 0; i < 5; i++) {
;         if(prio_result[i] != 0) {
;         a[i].quo = time_result[i] / prio_result[i];
;         a[i].remain = time_result[i] % prio_result[i];
;         }
;     }

;     for(int i = 0; i < 5; i++) {
;         printf("avg%d:%d\n", i + 1, a[i].quo);
;         printf("remain%d:%d\n", i + 1, a[i].remain);
;     }
;     return 0;
; }