        NAME main
        PUBLIC main
        SECTION .text: CODE (2)
        THUMB

main
        ; Initialize variables
        MOVS R5, #0     ; Sum of all elements
        LDR R6, =999    ; Minimum value (initialize to large number)
        LDR R7, =0      ; Maximum value (initialize to small number)
        LDR R0, =Vector ; Address of first element in vector
        LDR R1, =20     ; Number of elements in vector

loop
       ; Load current element into R2
        LDR R2, [R0], #4

        ; Update minimum value if necessary
        CMP R2, R6
        BLT update_min

        ; Update maximum value if necessary
        CMP R2, R7
        BGT update_max

        ; Add current element to sum
        ADDS R5, R5, R2

        ; Decrement loop counter
        SUBS R1, R1, #1

        ; Continue loop if more elements remain
        BNE loop

        ; Calculate average value
        MOV R8, R5     ; Copy sum to R8
        MOV R9, #20    ; Number of elements (could be calculated based on size of Vector)
        BL divu        ; R8 = R8 / R9

STOP    B STOP         ; Stop program (infinite loop)

update_min
       ; Update minimum value
       MOV R6, R2
       B loop

update_max
       ; Update maximum value
       MOV R7, R2
       B loop
divu
       ; Unsigned integer division (R0 / R1)
       ; Assumes R1 > 0 and result fits in 32 bits
       PUSH {LR}       ; Save return address
       MOV R2, #0      ; Initialize quotient to zero
divu_loop
       CMP R0, R1      ; Compare dividend and divisor
       BLT divu_end    ; End of division if dividend < divisor
       ADD R2, R2, #1  ; Increment quotient
       SUB R0, R0, R1  ; Subtract divisor from dividend
       B divu_loop     ; Continue division
divu_end
       MOV R0, R2      ; Return quotient in R0
       POP {PC}        ; Restore return address and return

       ALIGNROM 2
       DATA
Vector
       DC32 14, 25, 2, 27, 3
       DC32 22, 13, 4, 24, 6
       DC32 26, 18, 8, 15, 9
       DC32 28, 10, 7, 17, 5
       END