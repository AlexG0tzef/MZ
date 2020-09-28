; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

.DATA
    zapros DB 'Input element:', 13, 10, 0
    before DB 'Before editing:', 13, 10, 0
    after DB 'After editing:', 13, 10, 0
    buffer DB 10 dup ('0')
    Result DB ' ', 0
    Ent DB 13, 10, 0
    str_len word 6
    AR SDWORD 24 DUP (0)
    ResStr DB 16 DUP (' '), 0

.CODE
  Start:
        ;input
        mov ECX, 0
  input:cmp ECX, 23
        jg endinp
        push ECX
        Invoke StdOut, ADDR zapros
        Invoke StdIn, ADDR buffer, LengthOf buffer
        Invoke StripLF, ADDR buffer
        Invoke atol, ADDR buffer
        pop ECX
        mov AR[ECX*4], EAX
        inc ECX
        jmp input
 endinp:;Array entered
        Invoke StdOut, ADDR before
        call OUTPUT
        ;editing array
        mov EBX, 0;summ
        mov ECX, 0;index
   cycl:cmp ECX, 23
        jg endcycl
        cmp AR[ECX * 4], 0
        jge plus
        add EBX, AR[ECX * 4]
   plus:mov EAX, ECX
        cdq
        div str_len
        cmp EDX, 5
        jne this_ro
        cmp EBX, 0
        je this_ro
        mov AR[ECX * 4 - 20], EBX
        mov EBX, 0
this_ro:inc ECX
        jmp cycl
endcycl:Invoke StdOut, ADDR after
        call OUTPUT
        Invoke StdIn, ADDR buffer, LengthOf buffer
        Invoke ExitProcess, 0
        OUTPUT PROC
            push ECX
            push EAX
            ;output
            mov ECX, 0
     output:cmp ECX, 23
            jg endoutp
            mov EAX, ECX
            push ECX
            Invoke dwtoa, AR[EAX*4], ADDR ResStr
            Invoke StdOut, ADDR Result
            Invoke StdOut, ADDR ResStr
            pop ECX
            mov EAX, ECX
            cdq
            div str_len
            cmp EDX, 5
            jne no1310
            push ECX
            Invoke StdOut, ADDR Ent
            pop ECX
     no1310:inc ECX
            jmp output
    endoutp:pop EAX
            pop ECX
            ret
        OUTPUT endp
        End    Start
