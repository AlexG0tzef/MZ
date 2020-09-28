; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    13,10,"Press Enter to Exit",0AH,0DH,0
ErrMsg DB    'Cannot divide by zero!',0

         .DATA
WhatIsCalculated    DB      'c = a*(a+b/4)/(k-1)',13,10,0
GetA                DB      'Input value of a:',13,10,0
GetK                DB      'Input value of k:',13,10,0
GetB                DB      'Input value of b:',13,10,0
result              DB      'C = ',0
fore                DWORD   4
resultstr           DB      16 DUP (' '),0

         .DATA?
         
B                   DWORD   ?
K                   DWORD   ?
A                   DWORD   ?
D                   DWORD   ?
X                   DWORD   ?
buffer              DB      16  DUP (?)
inbuf               DB      100 DUP (?)
         .CODE
         ;Invoke StdOut,ADDR zapros
;        Invoke StdIn,ADDR buffer,LengthOf buffer
 ;       Invoke StripLF,ADDR buffer
 ;       Invoke atol,ADDR buffer
        
;output: Invoke dwtoa,result,ADDR resstr
;        Invoke StdOut,ADDR result
    
Start:
         Invoke StdOut,ADDR WhatIsCalculated    ;show expression
         Invoke StdOut,ADDR GetA                ;addr getd - address of getd
         Invoke StdIn,ADDR buffer,LengthOf buffer   ; ââîä A
         Invoke StripLF,ADDR buffer 
         Invoke atol,ADDR buffer
         mov A,EAX
         Invoke StdOut,ADDR GetK   
         Invoke StdIn,ADDR buffer,LengthOf buffer   ; ââîä K
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer
         mov K,EAX
         Invoke StdOut,ADDR GetB    
         Invoke StdIn,ADDR buffer,LengthOf buffer   ; ââîä Â
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer
         mov B,EAX
         
         mov ECX,K ; ECX
         sub ECX,1 ; k-1 
         cmp ECX, 0
         je err

         mov EAX,B ; b â EAX
         cdq ; EAX -> EDX:EAX
         idiv DWORD PTR fore ;EAX= (EDX:EAX):fore
         add EAX,A ;EAX= (EDX:EAX):fore + A
         imul A ;EAX= ((EDX:EAX):fore + A)*A)
         cdq ; EAX -> EDX:EAX
         idiv DWORD PTR ECX ;EAX = (EDX:EAX):ECX
         mov X,EAX
         

         Invoke dwtoa,X,ADDR resultstr
         Invoke StdOut,ADDR result  ; âûâîä ðåçóëüòàòà
         Invoke StdOut,ADDR resultstr
         XOR    EAX,EAX
         jmp ner
         
     err:Invoke StdOut,ADDR ErrMsg
         XOR    EAX,EAX	
                  
     ner:Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		

         Invoke ExitProcess,0
         End    Start
