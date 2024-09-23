.MODEL SMALL
.STACK 100H
.DATA
array DB 10 DUP (?)  
occurrences DB 10 DUP (0) 
sum DB ?  
mes1 DB "Enter a number between 0 and 9: $"
mes2 DB "The result = $"
mes3 DB "The result is even$"
mes4 DB "The result is odd$"
.CODE
MAIN PROC
    MOV AX, SEG array  ; initialize data segment
    MOV DS, AX

    ; asking user
    MOV CX, 10  ; 
    MOV SI, 0  ; the array index
    MOV AH, 01H  ; prepare for input

inputfromuser:
    MOV DX, OFFSET mes1  ; print 
    INT 21H  ; read 
    SUB AL, 48  ; change to binary from ascii
    MOV [SI], AL  ; save in array
    INC SI  ; increment array index
    LOOP inputfromuser

    ;find the sum and accurance
    MOV BX, 0 
    MOV SI, 0 

findsum:
    MOV AL, [SI]  ; get the num from array
    ADD BX, AL  ; add to sum
    MOV DL, [occurrences + AL]  ; give occurrences for the num
    INC DL  ; increment occurrences
    MOV [occurrences + AL], DL  ; save new occurrences
    INC SI  ; increment array index
    LOOP findsum

    ; check if sum is even or odd
    MOV AL, sum  ; move sum to AL
    AND AL, 1  ; bitwise ////
    JZ even  ; if 0 so its even 

odd:
    MOV DX, OFFSET mes2
    INT 21H
    MOV AH, 09H
    MOV DL, 0DH   
    INT 21H
    MOV DL, 0AH  
    INT 21H
    MOV DX, OFFSET mes4
    INT 21H
    JMP done

even:
   
    MOV DX, OFFSET mes2
    INT 21H
    MOV AH, 09H
    MOV DL, 0DH  ; carriage return
    INT 21H
    MOV DL, 0AH  ; line feed
    INT 21H
    MOV DX, OFFSET mes3
    INT 21H

done:
    MOV AH, 4CH  
    INT 21H
MAIN ENDP
END MAIN
