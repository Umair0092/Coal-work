[org 0x0100]

	jmp start
mp :db 0
score:dw 0
top: 	dw 2,12,2,2,12,2 ;Starting Row
bottom: dw 10,22,24,10,22,24		     ;Ending   Row
left:	dw 2,2,18,50,50,2;Starting Column
right:	dw 16,16,44,70,70,70     ;Ending Column	     
message1: db 'End Game' , 0
msg: db 'score' ,0
msg1: db'brick game'
msgt:db'time left '
msg2:db'help'
msgl:db'left : a'
msgd:db 'down : s'
msgr:db'right :d'
msg4:db 'next'
msge:db 'end'
mov_var:db 0
lenght:dw 5,10,4,3,8
startp: dw 0
nextshapep: dw 1066
currentshape: db 0
nextshape: db 0
current_row: db 0
lc: db 5
save_di:dw 0
save_di2: dw 0
counter2:db 0
blackclr: db 0
mov_up: db 0
mov_down:db 0
mov_left:db 0
mov_right:db 0
row_counter:db 20
column_counter:db 24
startp2:dw 518
yes: db 1
can_play: db 1
can_not_mov:db 0
counter: db 20
;current_column:
next_piece_colour_index: dw 0
delay_centiseconds db 5 ; delay between frames in hundredths of a second
delay_stopping_point_centiseconds db 0 ; convenience variable used by the                                           ; delay subroutine
delay_initial db 0 ; another convenience variable used by the                        ; delay subroutine
random_number db 0 ; incremented by various events 
   

tope: 	dw 3;Starting Row
bottome: dw 13		     ;Ending   Row
lefte:	dw 15;Starting Column
righte:	dw 40
gameend:db'gameover'

min:	dw 0
s:		dw 50
ms:		dw 1000


oldkb:	dd 0 							;For the purpose of saving the old keyboard ISR
oldtb:dd 0



;Flags for other functions
startTimer:  db 0
settime: db 0

location:	db 6
	
	 startMsg: db 'Press space to Continue: '
 welcom:db 'Block Game'
startMenu:
        push es
        push ax
        push cx
        push di
        push si

        mov ax, 0xb800
        mov es, ax
        mov di, 1650
        mov cx, 10
        
        mov si, 0
       ; mov ax, 0xb877
     nextCharStMe:
        mov al, [welcom+ si]
        mov [es:di], ax
        add di, 2
        inc si
        loop nextCharStMe
		xor cx,cx
		mov cx,27
		mov si,0
		mov ax,0xb800
		mov di,1954
        nextCharStMen:
        mov al, [startMsg + si]
        mov [es:di], ax
        add di, 2
        inc si
        loop nextCharStMen
		

        mov ah, 0
	int 0x16
cmp al,' '
je o2
 jne end       
o2:pop si
        pop di
        pop cx
        pop ax
        pop es
ret
   
start2:		call clrscr

			  push word [top]
			 push word [bottom]
			 push word [left]
			 push word [right]

			 call drawrect
			 push word [top+2]
			 push word [bottom+2]
			 push word [left+2]
			 push word [right+2]
			 call drawrect
			 push word [top+4]
			 push word [bottom+4]
			 push word [left+4]
			 push word [right+4]
			 call drawrect
			 push word [top+6]
			 push word [bottom+6]
			 push word [left+6]
			 push word [right+6]
			 call drawrect
			 push word [top+8]
			 push word [bottom+8]
			 push word [left+8]
			 push word [right+8]
			 call drawrect
			  mov ax, [left+2]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              mov ax, [top+2]
             add ax,2
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msg
              push ax ; push address of message
             push word [lenght] ; push message length
              call printstr 
			  
   xor ax,ax
   mov ax, word[score]
   push ax
   mov ax,2264
 push ax
   call printnum
	
	mov ax, [left]
              add ax,2
              push ax ; push x position
              mov ax, [top]
             add ax,2
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msg1
              push ax ; push address of message
             push word [lenght+2] ; push message length
              call printstr 
			  
			  mov ax, [left]
              add ax,2
              push ax ; push x position
              mov ax, [top]
             add ax,4
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msgt
              push ax ; push address of message
             push word [lenght+2] ; push message length
              call printstr 
			  
			  mov ax, [left+6]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              mov ax, [top+6]
             add ax,2
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msg4
              push ax ; push address of message
             push word [lenght+4] ; push message length
              call printstr 
			  mov ax, [left+8]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              mov ax, [top+8]
             add ax,2
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msg2
              push ax ; push address of message
             push word [lenght+4] ; push message length
              call printstr 
			  
			  ;msg left
			  mov ax, [left+8]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              mov ax, [top+8]
             add ax,3
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msgl
              push ax ; push address of message
             push word [lenght+8] ; push message length
              call printstr 
			  
			  ;msg right
			 
			 mov ax, [left+8]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              mov ax, [top+8]
             add ax,5
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msgr
              push ax ; push address of message
             push word [lenght+8] ; push message length
              call printstr 
			  
			  mov ax, [left+8]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              mov ax, [top+8]
             add ax,7
               push ax ; push y position
                mov ax, 6h ; blue on black attribute
              push ax ; push attribute
              mov ax, msgd
              push ax ; push address of message
             push word [lenght+8] ; push message length
              call printstr 
			  
			  
			;call Delay
			;call endscr
			push word [top+10]
			 push word [bottom+10]
			 push word [left+10]
			 push word [right+10]
			 call drawrect
			mov ax, [left+4]
              add ax,2
              push ax ; push x position
    ; xor ax,ax
              ;mov ax, [top+4]
             ;add ax,4
               ;push ax ; push y position
                ;mov ax, 7736h ; blue on black attribute
              ;push ax ; push attribute
              ;mov ax, msge
              ;push ax ; push address of message
            ;push word [lenght+6] ; push message length
              ;call printstr
			  mov ax,  30
 push ax ; push x position 
 mov ax, 4 
 push ax ; push y position 
 mov ax, 1 ; blue on black attribute 
 push ax ; push attribute 
 mov ax, msg 
 push ax   

			  
			  call gamestr
	b4:		  jmp end
			;call scrollup


printnum: push bp
 mov bp, sp
 push es
 push ax
 push bx
 push cx
 push dx
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov ax, [bp+6] ; load number in ax
 mov bx, 10 ; use base 10 for division
 mov cx, 0 ; initialize count of digits
nextdigit: mov dx, 0 ; zero upper half of dividend
 div bx ; divide by 10
 add dl, 0x30 ; convert digit into ascii value
 push dx ; save ascii value on stack
 inc cx ; increment count of values
 cmp ax, 0 ; is the quotient zero
 jnz nextdigit ; if no divide it again
mov di, [bp+4]
 nextpos: pop dx ; remove a digit from the stack
 mov dh, 0x07 ; use normal attribute
 mov [es:di], dx ; print char on screen
 add di,2; move to next screen location
 loop nextpos ; repeat for all digits on stack
 pop di
 pop dx
 pop cx
 pop bx
 pop ax
 pop es
 pop bp
 ret 4
			

			
			
		

		
			
gamestr:
push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov al, 80 ; load al with columns per row 
 mul byte [bp+8] ; multiply with y position 
 add ax, [bp+10] ; add x position 
 shl ax, 1 ; turn into byte offset 
 mov di,ax ; point di to required location 
 mov word[startp],di
mov cx,1
mov ax,0
call procedure_random_next_piece
mov byte[currentshape],al
mov dh,10
l5:
mov dl,al
mov di,[nextshapep]
mov ax,0
call procedure_random_next_piece
mov byte[nextshape],al
mov dl,[currentshape]
mov di,[startp]
mov byte[mov_down],0
mov byte[can_not_mov],0
mov byte[mov_left],0
mov byte[mov_right],0
call canmyplay
cmp byte[mp],1
jz ends
mo:
call movShape

b7:
mov word[save_di2],di
call check_is_line_full
;call can_play_game
b15:mov di,[save_di2]
mov byte[blackclr],9
mov di,[nextshapep]
mov dl,[nextshape]
call removeshape
mov byte[blackclr],0
mov di,[startp]
mov dl,[nextshape]
call shapeptr
mov al,[nextshape]
mov  byte[currentshape],al
mov byte[row_counter],20
mov ax,0
sub byte[counter],1
jnz l5



b16:pop di
 pop si
 pop cx
 pop ax 
 pop es 
 pop bp
jmp b4
;color1: mov ax,0xCC20
;jmp back

;color2: mov ax,0xAA20
;jmp back


;clr1: mov ax,0xCC20
;jmp Back2

;clr2: mov ax,0xAA20
;jmp Back2

;Color1: mov ax,0xCC20
;cmp dx,2
;jz Back2
;jmp Back

;Color2: mov ax,0xAA20
;cmp dx,2
;jz Back2
;jmp Back  

;endptr: mov ax, 36 
 ;push ax ; push x position 
 ;mov ax, 16 
 ;push ax ; push y position 
 ;mov ax, 1 ; blue on black attribute 
 ;push ax ; push attribute 
 ;mov ax, msg 
 ;push ax ; push address of message 
 ;call printstr1
 ;jmp l4
 
 ;clear_line:
 ;push cx
 ;push ax
 ;push bx
;mov byte[counter2],24
;sub di ,2
;mov ax,0x0720
;l9: 
 ;mov word[es:di],ax
 ;sub di,2
 ;sub byte[counter2],1
 ;jnz l9
 ;pop bx
 ;pop di
 ;pop ax
 ;pop cx
 ;ret
 
 canmyplay:
 pusha
 mov di,[startp]
 add di,160
 mov ax, word[es:di]
 cmp ax,0xA72A
 jz chng
 jnz e
 chng:
 mov byte[mp],1
 e:
 popa
 ret
 
 
 
 can_play_game:
 push ax
 push di
 mov di,[startp]
 cmp byte[nextshape],0
 jnz s9
 mov byte[counter],8
 l11:
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp2_b16
 add di,2
 sub byte[counter],1
 jnz l11
 pop ax
 pop di
 ret
 s9:cmp byte[nextshape],1
 jnz s10
 mov byte[counter],4
 p7: 
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp2_b16
 add di,2
sub byte[counter],1
 jnz p7
 add di,158
 mov byte[counter],4
 p8: 
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp2_b16
 add di,2
 sub byte[counter],1
 jnz p8
 pop ax
 pop di
 ret

 jmp2_b16:
 jmp b16
 
 s10: cmp byte[nextshape],2
 jnz s11
 mov byte[counter],4
 p9: 
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp_b16
 add di,2
sub byte[counter],1
 jnz p9
 add di,152
 mov byte[counter],4
 p12: 
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp_b16
 add di,2
 sub byte[counter],1
 jnz p12
 pop ax
 pop di
 ret
 s11:cmp byte[nextshape],3
 jnz s12
 mov byte[counter],8
 l12:
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp_b16
 add di,2
 sub byte[counter],1
 jnz l12
  mov byte[counter],2
 sub di,162
 p10: 
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp_b16
 add di,2
 sub byte[counter],1
 jnz p10
 pop ax
 pop di
 ret
 
 jmp_b16:
 jmp b16
 
 s12:cmp byte[nextshape],3
 jnz s13
 mov byte[counter],8
 l13:
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp_b16
 add di,2
 sub byte[counter],1
 jnz l13
  mov byte[counter],2
 sub di,168
 p11: 
 mov ax,[es:di]
 cmp al,0x2A
 jz jmp_b16
 add di,2
 sub byte[counter],1
 jnz p11
 pop ax
 pop di
 s13:ret
 
 
 
 ;
 check_is_line_full:
 push ax
 push bx
 push cx
 mov bx,0x702E
 mov di,[startp2]
 l8:
 cmp byte[yes],1
 
 jnz s7
 mov ax, word[es:di]
 
cmp al,0x2A
 jz s7
 mov byte[yes],0
 s7: add di,2
sub byte[column_counter],1
jnz l8 




mov word[save_di],di
cmp byte[yes],1
jnz s8


updatescore:
mov ax,word[score]
add ax,10
mov word[score],ax
push ax
mov ax,2264
 push ax
call printnum



mov byte[counter2],24
sub di ,2
mov ax,0x0720
l9: 
 mov word[es:di],ax
 sub di,2
 sub byte[counter2],1
 jnz l9
 ;cmp [row_counter]
 mov byte[column_counter],24
 mov bl,[row_counter]
 mov cl,20 
 sub cl,bl
 l10: sub di,160
 mov bx,[es:di]
 add di,160
 mov word[es:di],bx
add di,2
sub byte[column_counter],1
jnz l10
sub di,160
 mov bx,[es:di]
 add di,160
 mov word[es:di],bx
sub di,208
mov byte[column_counter],24
dec cl
jnz l10
 mov bx,0x702E
 mov word[es:di],bx
s8:mov di,[save_di]
add di,112
;mov word[es:di],bx
mov byte[column_counter],24
mov byte[yes],1
sub byte[row_counter],1
jnz l8 
pop cx
 pop bx
 pop ax
 ret
 
procedure_generate_random_number:

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; advance random number
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov al, byte [random_number]
    add al, 31
    mov byte [random_number], al

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; divide by N and return remainder
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    div bl ; divide by N
    mov al, ah ; save remainder in al
    xor ah, ah
    
    ret

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; Create next piece
; 
;;;;;;;;;;;;;;;;s;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
shapeptr:
 cmp dl,0	
    jz Print_Shape1
	cmp dl,1
	jz Print_Shape2
	
	cmp dl,2
	jz Print_Shape3
	
	
	cmp dl,3
	jz Print_Shape4
	mov bh,0
	
    cmp dl,4
	jz Print_Shape5
     ret


procedure_random_next_piece:
    
    call procedure_delay ; advance random number (or seed for the initial call)
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; piece index will be randomly chosen from [0, 6] inclusive
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov bl, 5
    call procedure_generate_random_number ; choose a piece (in ax)
    mov word [next_piece_colour_index], ax ; save colour index
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; orientation will be randomly chosen from [0, 3] inclusive
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     cmp al,0	 ; orientations (in ax)
    jz Print_Shape1
	cmp al,1
	jz Print_Shape2
	
	cmp al,2
	jz Print_Shape3
	
	
	cmp al,3
	jz Print_Shape4
	b6:mov bh,0
	
    cmp al,4
	jz Print_Shape5
    b5: ret



Print_Shape1: call shape1
ret

Print_Shape2: call shape2
ret

Print_Shape3: call shape3
ret

Print_Shape4: call shape4
ret

Print_Shape5: call shape5
ret





 procedure_delay:
    push bx
    push cx
    push dx 
    push ax

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; read current system time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor bl, bl
    mov ah, 2Ch
    int 21h
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; advance random number
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov byte al, [random_number]
    add al, dl
    mov byte [random_number], al
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; store second
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov [delay_initial], dh
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; calculate stopping point, and do not adjust if the stopping point is in
    ; the next second
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    add dl, [delay_centiseconds]
    cmp dl, 100
    jb delay_second_adjustment_done
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; stopping point will cross into next second, so adjust
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    sub dl, 100
    mov bl, 1

delay_second_adjustment_done:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; save stopping point in centiseconds
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov [delay_stopping_point_centiseconds], dl

read_time_again:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; read system time again
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; int 21h
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; if we have to stop within the same second, ensure we're still within the
    ; same second
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    test bl, bl ; will we stop within the same second?
    je must_be_within_same_second
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; second will change, so we keep polling if we're still within
    ; the same second as when we started
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    cmp dh, [delay_initial]
    je read_time_again
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; if we're more than one second later than the second read when we entered
    ; the delay procedure, we have to stop
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    push dx
    sub dh, [delay_initial]
    cmp dh, 2
    pop dx
    jae done_delay
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; we're exactly one second after the initial second (when we entered the 
    ; delay procedure, which is where we expect the stopping point; therefore,
    ; we need to check if we've reached the stopping point
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    jmp check_stopping_point_reached
    
must_be_within_same_second: 
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; since we expect to stop within the same second, if current second is not
    ; what we already saved in delay_initial, then we're done
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    cmp dh, [delay_initial]
    jne done_delay
    
check_stopping_point_reached:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; keep reading system time if the current centisecond is below our stopping
    ; point in centiseconds
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    cmp dl, [delay_stopping_point_centiseconds]
    jb read_time_again

done_delay:
    pop ax
    pop dx
    pop cx
    pop bx
    
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 
 
 
	printstr1: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 push ds 
 pop es ; load ds in es 
 mov di, [bp+4] ; point di to string 
 mov cx, 0xffff ; load maximum number in cx 
 xor al, al ; load a zero in al 
 repne scasb ; find zero in the string 
 mov ax, 0xffff ; load maximum number in ax 
 sub ax, cx ; find change in cx 
 dec ax ; exclude null from length 
 jz exit ; no printing if string is empty
 mov cx, ax ; load string length in cx 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov al, 80 ; load al with columns per row 
 mul byte [bp+8] ; multiply with y position 
 add ax, [bp+10] ; add x position 
 shl ax, 1 ; turn into byte offset 
 mov di,ax ; point di to required location 
 mov si, [bp+4] ; point si to string 
 mov ah, [bp+6] ; load attribute in ah 
 cld ; auto increment mode 
nextchar1: lodsb ; load next char in al 
 stosw ; print char/attribute pair 
 loop nextchar1 ; repeat for the whole string 
exit: pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 8 
	

;movshape: 
   

printstr: push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov al, 80 ; load al with columns per row
 mul byte [bp+10] ; multiply with y position
 add ax, [bp+12] ; add x position
 shl ax, 1 ; turn into byte offset
 mov di,ax ; point di to required location
 mov si, [bp+6] ; point si to string
 mov cx, [bp+4] ; load length of string in cx
 mov ah, [bp+8] ; load attribute in ah
nextchar: mov al, [si] ; load next char of string
 mov [es:di], ax ; show this char on screen
 add di, 2 ; move to n
 add si, 1 ; move to next char in string
 loop nextchar ; repeat the operation cx times
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 10
 jmp end
 
 
bshape:
mov ax,0
ret


shape1: ;push all regs
push di
push ax
push cx
push es
 mov ax, 0xb800 
 mov es, ax ; point es to video base  
 mov cx,8
 mov ax,0xA72A
 cmp byte[blackclr],9
 jnz p
 mov ax,0
 p: mov [es:di],ax
 add di,2
 dec cx
 jnz p
 pop es
pop cx
pop ax
pop di
ret




shape2: ;push all regs
push di
push ax
push cx
push es
 mov ax, 0xb800 
 mov es, ax ; point es to video base  
 mov cx,4
 mov ax,0xB72A
 cmp byte[blackclr],9
 jnz p2
 mov ax,0
 p2: mov [es:di],ax
 add di,2
 dec cx
 jnz p2
 add di,158
 mov cx,4

 p3: mov [es:di],ax
 add di,2
 dec cx
 jnz p3

pop es
pop cx
pop ax
pop di
ret





shape3: ;push all regs
push di
push ax
push cx
push es

 mov ax, 0xb800 
 mov es, ax ; point es to video base  
 mov cx,4
 mov ax,0xC72A
 cmp byte[blackclr],9
 jnz p4
 mov ax,0
 p4: mov [es:di],ax
 add di,2
 dec cx
 jnz p4
 add di,152
 mov cx,4

 p5: mov [es:di],ax
 add di,2
 dec cx
 jnz p5
pop es
pop cx
pop ax
pop di
ret

;push all regs

shape4: ;push all regs
push bp
 push es 
 push ax 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
XOR ax,ax 
mov ax,0xD72A
;mov al,0
 mov cx,8
 cmp byte[blackclr],9
 jnz p1
 mov ax,0
 p1: mov [es:di],ax
 add di,2
 dec cx
 jnz p1
 mov cx,2
 sub di,162
 m2:
 mov [es:di],ax
 sub di,2
 dec cx
 jnz m2
 
pop di
pop ax
pop es
pop bp
ret

shape5: ;push all regs
push bp
 push es 
 push ax 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
XOR ax,ax 
mov ax,0xE72A
;mov al,0
 mov cx,8
 cmp bx,9
 cmp byte[blackclr],9
 jnz p6
 mov ax,0
 p6: mov [es:di],ax
 add di,2
 dec cx
 jnz p6
 mov cx,2
 sub di,168
 m5:
 mov [es:di],ax
 sub di,2
 dec cx
 jnz m5
 
pop di
pop ax
pop es
pop bp
ret



end:

mov ax, 0x4c00
int 21h


endscr:			mov ax, 0xb800
				mov es, ax				;Loading the video memory

				xor di,di

				mov ax,0x0720
				mov cx,2000

				cld
				rep stosw
			
				ret


clrscr:			mov ax, 0xb800
				mov es, ax				;Loading the video memory

				xor di,di

				mov ax,0x0720
				mov cx,2000
				cld
				rep stosw
				ret
Delay:
push cx
push ax
mov ax, 0x004ff
mainloop:
mov cx , 0x0fff
SetDelay:
dec cx
jnz SetDelay
sub ax, 1
jnz mainloop
pop ax
pop cx
ret
drawrect:		push bp
				mov  bp, sp
				pusha


				

				mov al, 80
				mul byte [bp + 10] 
				add ax,  [bp + 6]		 
				shl ax, 1
				mov di, ax

				push di					;Saving for later use


					;Storing the attribute


			;Calculating the width of the rectangle

				mov cx, [bp + 4]
				sub cx, [bp + 6]

				push cx 				;Saving for later use

				mov ax, 0x702A

loop1:			rep stosw






				pop bx

				pop di

				push bx

				dec bx	
				shl bx, 1

				add di, 160


				;Calculating the height of the rectangle

				mov cx, [bp + 8]
				sub cx, [bp + 10] 

				sub cx, 2 				;Excluding the top and bottom row
				
				mov ax, 0x702A

loop2:			mov si, di

				mov word [es:si], ax

				add si, bx

				mov word [es:si], ax

				sub si, bx

				add di, 160

				loop loop2
				pop cx

				mov ax, 0x702A

loop3:			rep stosw


 return:			popa
				 pop bp
				 ret 8		

removeshape:
mov byte[blackclr],9
cmp dl,0
jz shape1

cmp dl,1
jz shape2

cmp dl,2
jz shape3

cmp dl,3
jz shape4

cmp dl,4
jz shape5
;jmp b7
ret

check_can_mov_up:
push di
push ax
push cx
cmp di,1020
jz b9
mov byte[mov_up],1
b9:

pop cx
pop ax
pop di
ret
 
 
 check_can_mov_down:
 ;call canmyplay
 push di
push ax
push cx
mov cx,8
mov ax,0xb800
mov es,ax
add di,160
;call shape5

cmp dl,2
jnz s2
add di,160
mov cx,4

s2:cmp dl,1
jnz l6
mov cx,3
l7:mov ax, word[es:di]
add di,2
cmp al,0x2A
jz flag_up1
dec cx
jnz l7
mov cx,4
add di,160



l6: mov ax, word[es:di]
cmp al,0x2A
jnz skip1
call flag_up1
skip1: add di,2
dec cx
jnz l6

b10:pop cx
pop ax
pop di
cmp byte[mov_down],1
jz s1
ret

flag_up1:
mov byte[mov_down],1
mov byte[can_not_mov],1
jmp b10





movShape: push bp
 pusha
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
XOR ax,ax
mov bl,15
l3: 
mov ah,0
int 16h
cmp byte[mp],1
jz ends
cmp al,0x77
jz up
cmp al,0x73
jz down
cmp al,0x61
jz left2
cmp al,0x64
jz right2
jmp l3

b2:
cmp dl,0
jz print_Shape1

cmp dl,1
jz print_Shape2

cmp dl,2
jz print_Shape3

cmp dl,3
jz print_Shape4

cmp dl,4
jz print_Shape5

b3:
cmp byte[can_not_mov],1
jnz l3
s1:popa
jmp b7


up:
call check_can_mov_up
cmp byte[mov_up],1
mov byte[mov_up],0
jz b2
call removeshape
mov byte[blackclr],0
sub di,160
jmp b2

down:
call check_can_mov_down
cmp byte[mov_down],1
jz s1
call removeshape
mov byte[blackclr],0
add di,160
jmp b2

left2:
call can_mov_left2
call removeshape
mov byte[blackclr],0
sub di,2
jmp b2

right2:
call can_mov_right
call removeshape
mov byte[blackclr],0
add di,2
jmp b2

print_Shape1: call shape1
jmp b3

print_Shape2: call shape2
jmp b3

print_Shape3: call shape3
jmp b3

print_Shape4: call shape4
jmp b3

print_Shape5: call shape5
jmp b3



flag_up2:
mov byte[mov_left],1
mov byte[can_not_mov],1
ret
jmp_b14;
jmp b14


can_mov_left2:
push di
push ax
push cx

cmp byte[currentshape],0
jnz x3
sub di,2
mov ax, word[es:di]
cmp al,0x2A
jnz jmp_b14
call flag_up2

x3:cmp byte[currentshape],2
jnz x4
sub di,2
mov ax, word[es:di]
cmp al,0x2A
jnz j5
call flag_up2
j5: add di,160
mov ax, word[es:di]
cmp al,0x2A
jnz b14
call flag_up2

x4:cmp byte[currentshape],3
jnz x5
sub di,2
mov ax, word[es:di]
cmp al,0x2A
jnz j6
call flag_up2
j6: sub di,148
mov ax, word[es:di]
cmp al,0x2A
jnz b14
call flag_up2

x5:
cmp byte[currentshape],4
jnz x6
sub di,2
mov ax, word[es:di]
cmp al,0x2A
jnz j7
call flag_up2
j7: sub di,154
mov ax, word[es:di]
cmp al,0x2A
jnz b14
call flag_up2
x6:
cmp byte[currentshape],1
jnz b14
sub di,2
mov ax, word[es:di]
cmp al,0x2A
jnz j8
call flag_up2
j8:
add di,166
mov ax, word[es:di]
cmp al,0x2A
jnz b14
call flag_up2
b14:pop cx
pop ax
pop di
cmp byte[mov_left],1
jz s1
ret


jmp_b13;
jmp b13

can_mov_right:
 push di
push ax
push cx

cmp byte[currentshape],0
jnz s3
add di,16
mov ax, word[es:di]
cmp al,0x2A
jnz jmp_b13
call flag_up3
s3:
cmp byte[currentshape],2
jnz s4
add di,8
mov ax, word[es:di]
cmp al,0x2A
jnz j1
call flag_up3
j1: add di,160
mov ax, word[es:di]
cmp al,0x2A
jnz b13
call flag_up3
s4:
cmp byte[currentshape],3
jnz s5
add di,16
mov ax, word[es:di]
cmp al,0x2A
jnz j2
call flag_up3
j2: sub di,160
mov ax, word[es:di]
cmp al,0x2A
jnz b13
call flag_up3
s5:
cmp byte[currentshape],4
jnz s6
add di,16
mov ax, word[es:di]
cmp al,0x2A
jnz j3
call flag_up3
j3:
sub di,166
mov ax, word[es:di]
cmp al,0x2A
jnz b13
call flag_up3
s6: 
cmp byte[currentshape],1
jnz b13
add di,8
mov ax, word[es:di]
cmp al,0x2A
jnz j4
call flag_up3
j4:
add di,166
mov ax, word[es:di]
cmp al,0x2A
jnz b13
call flag_up3
b13:pop cx
pop ax
pop di
cmp byte[mov_right],1
jz s1
ret


flag_up3:
mov byte[mov_right],1
mov byte[can_not_mov],1
ret

check1:
mov ax, word[es:di]
cmp al,0x2A
ret

ends: pusha
call clrscrtime
  push word [tope]
			 push word [bottome]
			 push word [lefte]
			 push word [righte]
			 call drawrect
mov si, 0
       ; mov ax, 0xb877
	   mov cx, 8
	   mov di,1000
	   mov ah,0xc2
     nextCharStM:
        mov al, [gameend+ si]
        mov [es:di], ax
        add di, 2
        inc si
        loop nextCharStM
		mov cx,5
		add di ,304
		mov si,0
		 nextCh:
        mov al, [msg+ si]
        mov [es:di], ax
        add di, 2
        inc si
        loop nextCh
		
		xor ax,ax
   mov ax, word[score]
   push ax
   ; mov ax,2264
 ; push ax
 add di,4
 push di
   call printnum
		
		popa
		ret


clrscrtime:		pusha
			push es
			
			mov ax, 0xb800
			mov es, ax
			xor di, di
			mov ax, 0x720
			mov cx, 2000
			
			cld
			rep stosw
			
			pop es
			popa
			ret

		

kbisr:		    push ax

			    in  al, 0x60
			    
			    ;Checking release code only

			    ;cmp al,185		;checking for 'R'
			    jmp  startTime
				;jnz modChanger
			   
			   



;Scenarios when space key is released

 startTime:		cmp al, 185
				jnz oldKbHandler
				
				cmp byte [cs:startTimer], 1		;If Timer is already started then do nothing
				;jz  check0
				
				mov byte [cs:startTimer], 1 	;Else start the timer 

 

				
EOI1:			mov al, 0x20 					;End of Interrupt Signal
				out 0x20,al
				
				pop ax
				iret
				


oldKbHandler:	pop ax
				jmp far [cs:oldkb]


;-------------------------------------------------------------------------------------------------------------------

;-------------------------------------------------------------------------------------------------------------------


;To print the number on screen

timeprintstr:	push bp
			mov bp, sp
			pusha
			
			push es
			
			mov ax, 0xb800
			mov es, ax
			
			mov di, [bp+4]					;Location
			mov ax, [bp+6]					;Number
			
			mov bx, 10
			mov cx, 0
			

nextdigittime:	mov dx, 0
			div bx
			add dl, 0x30
			push dx
			inc cx
			cmp ax, 0
			jnz nextdigittime
			
			cmp cx, 1
			jnz nextpostime
			mov byte [es:di], '0'
			add di, 2
			
			
nextpostime:	pop dx
			mov dh, 0x07
			mov [es:di], dx
			add di, 2
			loop nextpostime
			
			pop es
			popa
			pop bp
			ret 4





printTime:	push bp
			mov bp,sp
			pusha

			push es

			mov ax, 0xB800
			mov es, ax

			mov di, [bp+4]					

			
			; add di, 6
			; mov byte [es:di], ':'


			
			push word [bp+8]
			add di, 6
			push di
			call timeprintstr
			

			;Printing Colon
			add di, 6
			mov byte [es:di], ':'


			;Printing seconds
			push word [bp+6]
			add di, 2
			push di
			call timeprintstr
			

			

			pop es

			popa
			pop bp
			ret 6


;-------------------------------------------------------------------------------------------------------------------
		



				
				
 Watch:	pusha
			push es
			
			
			push word [cs:min]
			push word [cs:s]	

			push 1124
			call printTime
				
			cmp byte [cs:startTimer], 1
			jnz dEOI							;Using two jumps because of the short range of near jump


			
			
changeTime:	cmp word [cs:min], 0
			jz checksec
sub word [cs:ms], 55
			cmp word[cs:ms], 65
			jae printcurr
			
			mov word [cs:ms], 1000
			dec word[cs:s]
			cmp word [cs:s], 0
			jnz printcurr
			
			mov word [cs:s], 60
			dec word[cs:min]
			cmp word [cs:min], 0
			jz checksec
			jnz printcurr
			jz oldtbhand
			
			
			;jmp printcurr
			
			
checksec:

 sub word [cs:ms], 55
			cmp word[cs:ms], 65
			jae printcurr
			
			mov word [cs:ms], 1000
			dec word[cs:s]
			cmp word [cs:s], 0
			jnz printcurr
			jz endtime
		

 dEOI:		jmp EOI 					


oldtbhand:pop ax
jmp far [cs:oldtb] 


 printcurr:	cmp byte [cs:settime], 1
 			jnz eEOI						

 			mov byte [cs:settime], 0

 			; push word [cs:ms]
		    ; push word [cs:s]
	 	   push word [cs:min]
			push word [cs:s]	

 			;Position Calculation
 			mov al, 80
 			mul byte [cs:location]
 			shl ax, 1

 			add byte [cs:location], 2

 			push ax
 			call printTime

 			jmp EOI

			

 eEOI:	   jmp EOI 							


 
 
			

EOI:		mov al, 0x20
			out 0x20, al
			
returntime:		pop es
			popa
			iret

			
start:		 mov ax, 0
			 mov es, ax
			
			
			 
			 mov ax, [es:9*4]
			 mov [oldkb],ax
			 mov ax, [es:9*4+2]
			 mov [oldkb+2], ax
			
			
			 call clrscrtime

			 ;Hooking the interrupts
			 
			 cli
			 call startMenu
			 ;Keyboard Interrupt
			 mov word [es:9*4], kbisr
			 mov [es:9*4+2], cs
			
			 ;Timer Interrupt
			 sti

			  mov ax, [es:8*4]
			 mov [oldtb],ax
			 mov ax, [es:8*4+2]
			 mov [oldtb+2], ax
			cli 
			
			 ;call clrscr
			 
			 mov word [es:8*4], Watch
			 mov [es:8*4+2], cs
			 
			 sti
			 
			 jmp near start2
			 call clrscr
			 ;Making it TSR 
			 mov dx, start
			 add dx, 15
			 mov cl, 4
			 shr dx, cl
			 
			
			 endtime:
			 call ends
			 mov ax, 0x3100
			 int 21h