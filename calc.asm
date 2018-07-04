org	256

begin:		mov	ah, 9
		mov	dx, cal
		int	21h
		mov	dx, clr
		int	21h
		mov	dx, pls
		int	21h
		mov	dx, clr
		int	21h
		mov	dx, mns
		int	21h
		mov	dx, clr
		int	21h
		mov	dx, krt
		int	21h
		mov	dx, clr
		int	21h
		mov	dx, dln
		int	21h
		mov	dx, clr
		int	21h
		mov	dx, mn1
		int	21h
		mov	dx, clr
		int	21h
;------------------------
vstup0: 	mov	ah, 1
		int	21h

		cmp	al, 49
		jb	vstup0
		cmp	al, 52
		ja	vstup0

		xor	ah, ah
		push	ax

		mov	ah, 9
		mov	dx, clr
		int	21h
		mov	dx, inp
		int	21h
		mov	dx, clr
		int	21h

		push	0
vstup1: 	mov	ah, 1
		int	21h

		cmp	al, 13
		je     endOfVstup1
		cmp	al, 48
		jb	vstup1
		cmp	al, 57
		ja	vstup1

		sub	al, '0'
		mov	bl, al
		pop	ax
		shl	ax, 1
		mov	dx, ax
		shl	ax, 2
		add	ax, dx
		add	ax, bx
		push	ax

		jmp	vstup1

endOfVstup1:	mov	ah, 9
		mov	dx, clr
		int	21h
		mov	dx, inp
		int	21h
		mov	dx, clr
		int	21h

		push	0
vstup2: 	mov	ah, 1
		int	21h

		cmp	al, 13
		je     vypocet
		cmp	al, 48
		jb	vstup2
		cmp	al, 57
		ja	vstup2

		sub	al, '0'
		mov	bl, al
		pop	ax
		shl	ax, 1
		mov	dx, ax
		shl	ax, 2
		add	ax, dx
		add	ax, bx
		push	ax

		jmp	vstup2

vypocet:	mov	ah, 9
		mov	dx, clr
		int	21h
		mov	dx, res
		int	21h
		mov	dx, clr
		int	21h

		pop	bx
		pop	ax
		pop	dx

		cmp	dx, 49
		je	scitanie
		cmp	dx, 50
		je	odcitanie
		cmp	dx, 51
		je	nasobenie
		cmp	dx, 52
		je	delenie

scitanie:	add	ax, bx
		jmp	vysledok
odcitanie:	sub	ax, bx
		jmp	vysledok
nasobenie:	mul	bx
		jmp	vysledok
delenie:	cmp	bx, 0
		jz	divError
		div	bl
		jmp	vysledok

vysledok:	mov	di, 0
cyklus1:	div	byte [bas]
		and	dx, 0
		mov	dl, ah
		push	dx
		inc	di
		and	ah, 0
		cmp	ax, 0
		jne	cyklus1

		mov	ah, 2h
cyklus2:	pop	dx
		add	dx, '0'
		int	21h
		dec	di
		jnz	cyklus2
;------------
opakuj: 	mov	ah, 9
		mov	dx, clr
		int	21h
		mov	dx, mn2
		int	21h
		mov	dx, clr
		int	21h

		mov	ah, 1h
		int	21h

		cmp	al, 'n'
		je	koniec
		cmp	al, 'y'
		jne	opakuj

		mov	ah, 9
		mov	dx, clr
		int	21h
		jmp	begin

koniec: 	int	20h

divError:	mov	ah, 9
		mov	dx, zer
		int	21h
		jmp	opakuj

;---------------

bas:		db 10
clr:		db 13, 10, '$'
cal:		db 'Kalkulacka$'
pls:		db '1. +$'
mns:		db '2. -$'
krt:		db '3. *$'
dln:		db '4. /$'
mn1:		db 'Press 1-4 to continue:$'
mn2:		db 'Press y/n to continue:$'
inp:		db 'Enter operand:$'
res:		db 'Result:$'
zer:		db 'Division by Zero!$'
