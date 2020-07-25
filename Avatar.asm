INCLUDE Irvine32.inc
.data
	arrayElems dword fire, water, earth 				; The Element Category using Array which contain 3 Char Element
	count dword 5									; Using Normal Loop count when you win within 5 times
	life byte 3
	bossLife dword 3
	Elem dword ?						
	name byte ?						
	nameUser byte 21 dup(0)
	
	note1 byte "Note: 0.Fire, 1.Water, 2.Earth", 0
	note2 byte "Water win againts FIRE & lose again EARTH, while FIRE will win agains EARTH",0
	line byte "=======================================",0
	str1 byte "Please enter your name => ", 0
	str2 byte "Congratulation you defeated the FireLord and Seal Vaatu, nows to put all thing to balance but that's story is for another time",0
	str3 byte "The Firelord has defeated the Avatar and the world is now belong to the Fire Nation",0
	str4 byte "Avatar: The legend of ",0
	strChoose byte "Choose your Element(Number) (0, 1, 2) => ",0
	strCheat byte "Don't try new things this is war keep a loo... and... you got hit by the grunt",0
	strWin byte "You Win, You chose ",0
	strDraw byte "You Draw, You chose ",0
	strLose byte "You Lose, You chose ",0
	fire byte "Fire",0
	water byte "Water",0
	earth byte "Earth",0
	soldier byte " Soldier Appear",0
	firelord byte "Fire lord use ",0
	firelord1 byte "From here on out its battle with the FireLord he will not reveal what he choose",0

	strStory1 byte "This is an Elseworld story where Aang doesn't runaway from his home and dies with air nomad",0
	strStory2 byte "Long ago the 4 nation live in peace. But, it all change when the fire nation attack",0
	strStory3 byte "Vaatu the dark spirit has taken over The Dark Avatar has reincarnated as an evil FireLord",0
	strStory4 byte "Raava the light spirit after lying dormant for years is now inside your body",0
	strStory5 byte "Now its up to you the Avatar to put a stop to FireLord and restore balance to the world",0

	strStory6 byte "The fire lord has conquer 2 other nation and genocide the Air Nomads",0
	strStory7 byte "Means the fire lord has army from water tribe, earth kingdom, and fire nation",0
	strStory8 byte "Also means that no one is an Airbender thus you cannot learn Airbending",0

	strStory9 byte "After a long of journey you intend to assault Firelord castle with your ally",0
	strStory10 byte "All of your ally is luring the soldier outside the castle while you sneak into it",0
	strStory11 byte "There is still a number of guard guarding the FireLord chamber",0

	strFLStory1 byte "You managed to enter Firelord chamber after beating those grunts",0
.code
;---------------------------------------------------------------------------------------
wFIRE:
	mov eax, 1100b
	call settextcolor
	mov esi,offset arrayElems
	mov edx, [esi]
	call writestring
	ret 0
wWATER:
	mov eax, 1001b
	call settextcolor
	mov esi,offset arrayElems+4
	mov edx, [esi]
	call writestring
	ret 0
wEARTH:
	mov eax, 0110b
	call settextcolor
	mov esi,offset arrayElems+8
	mov edx, [esi]
	call writestring
	ret 0
;---------------------------------------------------------------------------------------
whoseWin:
	mov eax, 1111b
	call settextcolor
	mov edx, offset strChoose	; mov edx to strChoose the option of "choose your number"
	call writestring			; calling StrChoose 
	call readint				; Read the output of : choose your Number (0, 1, 2)

	cmp eax, 2				; CEAT is dedicated for limiting the number can be choosen 0, 1 & 2 
	JG CEAT 
	cmp eax, 0 
	JL CEAT 
	JE J0					; chosen number equal 0
	cmp eax, 1
	JE J1					; chosen number equal 1
	JG J2					; chosen number equal 2

	JMP outWhoseWin
J0:							; user is 0.Fire...
	cmp Elem, 1				; First Expression of the Element Fight 
	JE J0_1					; if eax = 0, Elem = 1 (lose) --> fire vs water (random element)
	JG J0_2					; if eax = 0, Elem = 2 (win) --> fire vs earth (random element)
	

	mov edx, offset strDraw		; For if eax = 0, Elem = 0 (draw) no need to jump, fire vs fire (random element). print draw instead.
	call writestring
	call wFire
	mov eax, 1111b
	call settextcolor
	call crlf
	inc ecx					; Increase the next battle round after drawing the battle  
	JMP outWhoseWin			; Loop after finishing the game for the next obstacle to succeed
J0_1:
	mov edx, offset strLose		; condition fire (user input) vs water (random element) --> print lose in this round
	call writestring
	call wFire
	call crlf
	mov eax, 1111b
	call settextcolor
	inc ecx					; increase the battle round to the next round 
	dec life					; decrease the game life when losing battle 
	JMP outWhoseWin
J0_2:
	mov edx, offset strWin		; condition fire (user input) vs earth (random element) --> print win in this round	
	call writestring
	call wFire
	mov eax, 1111b
	call settextcolor
	call crlf
	JMP outWhoseWin 

J1:							; user choose 1. water
	cmp Elem, 1
	JL J1_0					; if eax = 1, Elem = 0 (win) --> water vs fire (random element)
	JG J1_2					; if eax = 1, Elem = 2 (lose) --> water vs earth (random element)

	mov edx, offset strDraw		; For if eax = 0, Elem = 0 (draw) no need to jump, water vs water (random element). print draw instead.
	call writestring
	call wWater
	mov eax, 1111b
	call settextcolor
	call crlf
	inc ecx 
	JMP outWhoseWin
J1_0:
	mov edx, offset strWin		; condition water (random element) vs fire (user input) --> print win in this round
	call writestring
	call wWater
	mov eax, 1111b
	call settextcolor
	call crlf
	JMP outWhoseWin 
J1_2:
	mov edx, offset strLose		; condition water (random element) vs earth (user input) --> print lose in this round
	call writestring
	call wWater
	mov eax, 1111b
	call settextcolor
	call crlf
	inc ecx					; go to the next round by increasing ecx
	dec life					; decrease game life
	JMP outWhoseWin 

J2:							; user choose 2. Earth
	cmp Elem, 1
	JL J2_0					; if eax = 2, Elem = 0 (lose) --> Earth vs fire (random element)
	JE J2_1					; if eax = 2, Elem = 1 (win) --> earth vs water (random element)
	
	mov edx, offset strDraw		; For if eax = 0, Elem = 0 (draw) no need to jump, earth vs earth (random element). print draw instead. 
	call writestring
	call wEarth
	mov eax, 1111b
	call settextcolor
	call crlf
	inc ecx					; go to the next round by increasing ecx
	JMP outWhoseWin
J2_0:
	mov edx, offset strLose		; condition earth (user input) vs fire (random element) --> print lose in this round
	call writestring
	call wEarth
	mov eax, 1111b
	call settextcolor
	call crlf
	inc ecx					; go to the next round by increasing ecx
	dec life					; decrease game life 
	JMP outWhoseWin 
J2_1:
	mov edx, offset strWin		; condition earth (user input) vs water (random element) --> print win in this round
	call writestring
	call wEarth
	mov eax, 1111b
	call settextcolor
	call crlf
	JMP outWhoseWin 
CEAT:
	mov edx, offset strCheat		; condition for user inserted wrong number (not in between 0-2) --> print freaking cheater
	call writestring				
	call crlf						
	dec life					; Decrease game life when Cheat Happening by entering the wrong number of optional Weapon 

outWhoseWin:					; After Determine which win
	ret 0					; When executing a near return, the processor pops the return instruction pointer (offset) from the top 

;--------------------------------------------------------------------------------
writeElem:
	cmp Elem, 1
	JE wtr
	JG eth
fre:
	call wFire						; print Fire
	jmp nextStep
wtr:
	call wWater						; print Water
	jmp nextStep
eth:
	call wEarth						; print Earth
nextStep:
	mov eax, 0111b
	call settextcolor
	ret 0
;-----------------------------------------------------------------------------
fightMinion:
	call crlf
	mov eax, 3
	call randomrange				; Call Random element to battle 
	mov Elem, eax					; save the element to battle 
	
	call writeElem					; call random element (fire, water, or earth)
	mov edx, offset soldier
	call writestring

	call crlf
	call whoseWin

	ret 0
;-----------------------------------------------------------------------------
fightBoss:						; fighting bos, bos element will not appear first. it will appear after user inserting the input.
	mov eax, 3
	call randomrange
	mov Elem, eax
	call crlf
	call whosewin
	
	mov edx, offset firelord			; strBoss2
	call writestring
	
	call writeElem

	call crlf

	ret 0
;------------------------------------------------------------------------------
main PROC
	mov eax, 1111b
	call settextcolor
	mov edx, offset str1			; calling Str1  " Please enter your name => "
	call writestring
	mov edx, offset nameUser			; input the name 
	mov ecx, (sizeof nameUser)-1
	call readstring
	
	mov eax, 00010111b
	call settextcolor
	mov edx, offset line
	call writestring
	call crlf
	mov edx, offset str4			; calling Str4 "Avatar: The legend of ... "
	call writestring
	mov edx, offset nameUser			; Outputting Name
	call writestring
	call crlf
	mov edx, offset line
	call writestring
	call crlf

	mov eax, 1000b					; print story line (intro)
	call settextcolor
	mov edx, offset strStory1
	call writestring
	call crlf
	mov edx, offset strStory2
	call writestring
	call crlf
	mov edx, offset strStory3
	call writestring
	call crlf
	mov edx, offset strStory4
	call writestring
	call crlf
	mov edx, offset strStory5
	call writestring
	call crlf
	call crlf

	mov edx, offset strStory6
	call writestring
	call crlf
	mov edx, offset strStory7
	call writestring
	call crlf
	mov edx, offset strStory8
	call writestring
	call crlf
	call crlf

	mov edx, offset strStory9
	call writestring
	call crlf
	mov edx, offset strStory10
	call writestring
	call crlf
	mov edx, offset strStory11
	call writestring
	call crlf
	call crlf
	mov edx, offset line
	call writestring
	call crlf

	mov edx, offset note1			   ; The note of the Optional weapon choice 
	call writestring
	call crlf
	mov edx, offset note2
	call writestring
	call crlf
;---------------------------------------------------------------------------------
	mov ecx, count
L1:						; First LOOP of Temporary Life
	cmp life, 0			; is life > 0 
	je DEAD				; no: is life > 0 

	call fightMinion    ; if life > 0 

	loop L1             ; repeat the Loop
;-------------------------------------------------------------------------
	call crlf
	mov eax, 1011b
	call settextcolor
	mov edx, offset strFLStory1
	call writestring
	call crlf
	mov edx, offset firelord1		; Boss fight
	call writestring
	call crlf
	
	mov edx, offset note1
	call writestring
	call crlf
	mov edx, offset note2
	call writestring
	call crlf

	mov edx, offset line
	call writestring
	call crlf
;------------------------------------------------------------------------
	mov ecx, bossLife
L2:	
	cmp life, 0
	je DEAD

	call fightBoss

	loop L2
;------------------------------------------------------------------------
	jmp WON 
DEAD:
	call crlf
	mov edx, offset line
	call writestring
	call crlf
	mov edx, offset str3		; You lose "Game Over"
	call writestring
	call crlf
	JMP OUTT
WON:
	call crlf
	mov edx, offset line
	call writestring
	call crlf
	mov edx, offset str2		; You win "Congratulation"
	call writestring
	call crlf
OUTT:
	mov edx, offset line
	call writestring
	call crlf
	call waitmsg				
	exit
main ENDP
;---------------------------------------------------------------------------------
END main