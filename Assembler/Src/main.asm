.386
.model flat
EXTERN _ExitProcess@4:NEAR
EXTERN  _WriteFile@20:NEAR
EXTERN  _GetStdHandle@4:NEAR
.const
	Message db "Hello, World!",0
	MsgLength dd (MsgLength - Message - 1)
.code
_START:
	; DWORD bytes;
	mov ebp, esp
	sub esp, 4

	; hStdOut = GetstdHandle( STD_OUTPUT_HANDLE )
	; Значение -11 соответствует STD_OUTPUT_HANDLE.
	; Подробнее здесь: https://msdn.microsoft.com/ru-ru/library/windows/desktop/ms683231%28v=vs.85%29.aspx
	push -11
	call _GetStdHandle@4
	mov ebx, eax

	; WriteFile( hStdOut, message, length( message ), &bytes, 0 );
	; Аргументы вставляет на стек в обратном порядке.
	; 0
	push 0
	; &bytes
	lea eax, [ebp-4]
	push eax
	; length( message )
	mov eax, MsgLength
	push eax
	; message
	push offset Message
	; hStdOut
	push ebx
	call _WriteFile@20

	; ExitProcess( 0 )
	push 0
	call _ExitProcess@4
end _START