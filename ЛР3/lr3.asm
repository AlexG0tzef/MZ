; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

.DATA
    zaprosA DB 'Input value A:',13,10,0
    zaprosC DB 'Input value C:',13,10,0
    zaprosD DB 'Input value D:',13,10,0
    zaprosK DB 'Input value K:',13,10,0
    Zero DB 13,10,'C = 0 zero division', 13, 10, 0
    buffer DB 10 dup ('0')
    Result DB 'Result=', 0
    val SDWORD 5

.DATA?
    X SDWORD ?
    AV SDWORD ?
    CV SDWORD ?
    DV SDWORD ?
    KV SDWORD ?
    ResStr DB 16 DUP (' '), 0

.CODE
   Start:
        Invoke StdOut, ADDR zaprosA
        Invoke StdIn, ADDR buffer, LengthOf buffer
        Invoke StripLF, ADDR buffer
        Invoke atol, ADDR buffer
        mov AV, EAX
        Invoke StdOut, ADDR zaprosC
        Invoke StdIn, ADDR buffer, LengthOf buffer
        Invoke StripLF, ADDR buffer
        Invoke atol, ADDR buffer
        mov CV, EAX
        cmp CV, 0
        je message
        Invoke StdOut, ADDR zaprosD
        Invoke StdIn, ADDR buffer, LengthOf buffer
        Invoke StripLF, ADDR buffer
        Invoke atol, ADDR buffer
        mov DV, EAX
        Invoke StdOut, ADDR zaprosK
        Invoke StdIn, ADDR buffer, LengthOf buffer
        Invoke StripLF, ADDR buffer
        Invoke atol, ADDR buffer
        mov KV, EAX
        cmp AV, 5
        jg greater
        mov EAX, DV
        imul val;d * 5
        jmp cont
greater:;a / c - k
        mov EAX, AV
        cdq
        idiv CV
        sub EAX, KV
   cont:mov X, EAX
        Invoke dwtoa, X, ADDR ResStr
        Invoke StdOut, ADDR Result
        Invoke StdOut, ADDR ResStr
        jmp endd
message:
      Invoke StdOut, ADDR Zero
 endd:Invoke StdIn, ADDR buffer, LengthOf buffer
      Invoke ExitProcess, 0       
End    Start
