ORG 100h           ; Origin, to specify that the program starts at 100h (COM file format)

; Display message "Enter a digit: "
MOV DX, OFFSET msg_input  ; Load the address of the input prompt message
MOV AH, 09h        ; Function 09h of INT 21h is used to display a string
INT 21h            ; Call DOS interrupt to print the input message

; Read a single character from the user (digit)
MOV AH, 01h        ; Function 01h of INT 21h is used to read a character
INT 21h            ; Call DOS interrupt to get the character
MOV BL, AL         ; Store the input character in BL (keep AL unchanged for future use)

; Check if the character is a digit (0-9)
CMP AL, '0'        ; Compare AL with '0'
JL NotDigit        ; If the input is less than '0', it is not a digit
CMP AL, '9'        ; Compare AL with '9'
JG NotDigit        ; If the input is greater than '9', it is not a digit

; Print the message "The entered digit is: "
MOV DX, OFFSET msg_output  ; Load the address of the output message
MOV AH, 09h        ; Function 09h of INT 21h is used to display a string
INT 21h            ; Call DOS interrupt to print the output message

; Print the entered digit (stored in BL)
MOV DL, BL         ; Move the entered digit (from BL) to DL for display
MOV AH, 02h        ; Function 02h of INT 21h is used to print a single character
INT 21h            ; Call DOS interrupt to print the entered digit

JMP EndProgram     ; Jump to the end of the program

NotDigit:
; If the input is not a digit, display an error message
MOV DX, OFFSET msg_error  ; Load the address of the error message
MOV AH, 09h        ; Function 09h of INT 21h is used to display a string
INT 21h            ; Call DOS interrupt to print the error message

EndProgram:
; Terminate the program
MOV AH, 4Ch        ; Function 4Ch of INT 21h terminates the program
INT 21h            ; Call DOS interrupt to exit

msg_input  DB 'Enter a digit: $'                       ; Input prompt
msg_output DB 0Dh, 0Ah, 'The entered digit is: $'      ; Output message
msg_error  DB 0Dh, 0Ah, 'Error: Not a digit! $'        ; Error message

END                ; End of program