  NAME main
  PUBLIC main
  SECTION .text: CODE (2)
  THUMB

main
  ; Initialize variables
  LDR R1, =Vector     ; Load the address of the vector
  MOV R6, #0x999      ; Initialize R6 with the largest possible value
  MOV R7, #0          ; Initialize R7 with 0
  MOV R8, #0          ; Initialize R8 with 0
  MOV R9, #20         ; Initialize R9 with the length of the vector
  
  ; Loop through the vector
loop
  LDR R2, [R1], #4    ; Load the next element of the vector
  CMP R2, R6          ; Check if the current element is less than R6
  IT LT               ; Conditionally execute the next instruction if less than
  MOVLT R6, R2        ; If so, update R6 with the new minimum value
  CMP R2, R7          ; Check if the current element is greater than R7
  IT GT               ; Conditionally execute the next instruction if greater than
  MOVGT R7, R2        ; If so, update R7 with the new maximum value
  ADD R8, R8, R2      ; Add the current element to R8
  SUBS R9, R9, #1     ; Decrement the loop counter
  BNE loop            ; If R9 is not zero, continue the loop
  
  ; Calculate the average
  MOV R2, #20         ; Load the length of the vector into R2
  MOV R3, #0          ; Initialize R3 with 0
  MOV R4, R8          ; Copy the sum into R4
  CMP R2, #0          ; Check if the length of the vector is zero
  BEQ STOP            ; If so, skip the division
  MOV R0, R4          ; Copy the sum into R0
  MOV R1, R2          ; Copy the length of the vector into R1
  BL unsigned_divide  ; Call the unsigned_divide function to divide R0 by R1
  MOV R3, R0          ; Copy the result into R3
  
STOP    B STOP              ; Stop the program

unsigned_divide
  PUSH {R4, LR}       ; Save the current value of R4 and LR on the stack
  MOV R3, #0          ; Initialize R3 with 0
  DIVLOOP:
    CMP R0, R1        ; Check if R0 is less than R1
    BLO DIVEND        ; If so, end the division loop
    ADD R3, R3, #1    ; Increment the quotient
    SUB R0, R0, R1    ; Subtract R1 from R0
    B DIVLOOP         ; Continue the division loop
  DIVEND:
    POP {R4, PC}      ; Restore the original value of R4 and LR and return


    ALIGNROM 2
    DATA
Vector
    DC32 14, 25, 2, 27, 3
    DC32 22, 13, 4, 24, 6
    DC32 26, 18, 8, 15, 9
    DC32 28, 10, 7, 17, 5
    END