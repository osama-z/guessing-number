.686
.MODEL flat, stdcall
.STACK
INCLUDE Irvine32.inc


.data

rules1 BYTE "GAME RULES : 1) I pick a number between 0 and 30.",0
rules2 BYTE "             2) You guess a number.",0
rules3 BYTE "             3) If you guess the right number, you win the game ,from first try you win 50$ ,second try you win 25$ , otherwise you win 10$ . ",0
rules4 BYTE "             4) If you guess the wrong number, then I will tell you whether the number I picked is higher or lower, and you will continue guessing.",0
rules5 BYTE "             5) Every time you guess a wrong number , you will lose 5 dollars. If you run out of money, you lose the game.",0

cost_msg BYTE   " Enter the cost , should be greater than 5 $ or equal : ",0
cost_end BYTE   " your money is run out , GAME OVER",0
rest_cost BYTE  " Take the rest of your money + win money  : ",0

mainMsg BYTE    " Enter a number between 0 and 30: ",0
lessMsg BYTE    " Oh NO! The number is less then your guess",0
equalMsg BYTE   "  WOW! Your guess is correct number , you win 10$ : ",0
equalMsg_first BYTE   "  UwU! Your guess is correct from first try ,,exellent work, you win 50 $ : ",0
equalMsg_second BYTE   "  OwO! Your guess is correct from second try ,,good work, you win 25 $: ",0
greaterMsg BYTE " Oh! The number is greater then your guess",0
number_try_msg BYTE " Numer of try you have : ",0

random DWORD ?
life DWORD 0
cost DWORD ?
rest_cost_1 DWORD 0
try DWORD ?

.code
main proc
	call Randomize


	mov eax, 30

	call RandomRange            ; put random number
	mov random, eax
	call writedec

	mov eax , yellow+(black*16)  ; print notic
	call setTextColor

	mov edx, OFFSET rules1        
	call WriteString
	call Crlf
	mov edx, OFFSET rules2
	call WriteString
    call Crlf
	mov edx, OFFSET rules3
	call WriteString
	call Crlf
	mov edx, OFFSET rules4
	call WriteString
	call Crlf
	mov edx, OFFSET rules5
	call WriteString
	call Crlf
	call Crlf

	mov eax , lightmagenta+(black*16)      ; print cost
	call setTextColor

	enter_again:               
	mov edx, OFFSET cost_msg
	call WriteString
    call ReadInt
	mov cost , eax

	cmp cost , 5
	jl enter_again

	mov edx , 0
	mov ebx , 5
	div ebx 
	mov try , eax           ; number of try 
	mov rest_cost_1 , edx   ;rest of money 

	mov edx, OFFSET number_try_msg  ;msg number of try have 
	call WriteString
    call WriteDec
	

	call crlf
	call crlf

while_start:
  sub cost , 5 

	
	    mov eax , white+(black*16)     ; color main msg
	    call setTextColor
	    inc life

	    mov edx, OFFSET mainMsg   ; print main msg of game and read number
		call WriteString

		call ReadInt                  
		call Crlf

		cmp eax, random          ; compare input number and random number 
		jl less
		je equal
		jg greater

	

	less:

	    mov eax , lightred+(black*16)
	    call setTextColor
		mov edx, OFFSET greaterMsg
		call WriteString

		call crlf
		call crlf
		call crlf

	    cmp cost , 5
	    jge while_start
	    jl quit

	equal:
		mov eax , lightgreen+(black*16)
	    call setTextColor
	

		cmp life , 1
		je first_try

		cmp life , 2
		je second_try

		otherwise:
		mov edx, OFFSET equalMsg
		call WriteString

		mov eax, random
		call WriteDec
		add cost , 10
		call crlf
		call crlf
		jmp done
		
		first_try: 
		mov edx, OFFSET equalMsg_first
		call WriteString

		mov eax, random
		call WriteDec
	    add cost , 50
		call crlf
		call crlf
		jmp done

		second_try:
		mov edx, OFFSET equalMsg_second
		call WriteString
		
		mov eax, random
		call WriteDec
		add cost , 25
		call crlf
		call crlf
		jmp done




	greater:
		mov eax , lightred+(black*16)
	    call setTextColor
		mov edx, OFFSET lessMsg
		call WriteString

		call crlf
		call crlf
		call crlf

	    cmp cost , 5
	    jge while_start
	    jl quit

	quit:
	    mov eax , red+(black*16)
	    call setTextColor
		mov edx , OFFSET cost_end
		call WriteString
		call crlf


   done:
		mov eax , white+(black*16)
	    call setTextColor
		
		mov edx , OFFSET rest_cost
		call WriteString
		mov eax , cost
		call WriteInt
		call crlf
		call crlf
		
	
exit
main endp
end main
