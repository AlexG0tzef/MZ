         .586
         .MODEL  flat
         .DATA
         .CODE
         public _simbol_count
         externdef _Get_rez:near 
_simbol_count proc
		
		 PUSH EBP
         MOV EBP, ESP
         MOV EDI, [EBP+8] ;EDI = str

		 MOV ECX, 256
		 MOV AL, 0
         REPNE SCASB
         MOV EAX, 256
         SUB EAX, ECX
         MOV ECX, EAX
         DEC ECX
		 MOV EBX, ECX
         PUSH EBX
         call _Get_rez
         POP EBX    
         MOV ESP, EBP
         POP EBP
         ret
_simbol_count endp
         END
         