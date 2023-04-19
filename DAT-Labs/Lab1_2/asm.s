        NAME    main
        PUBLIC  main
        SECTION .text : CODE (2)
        THUMB

main
        MOV R0, #0x0         ; (R0) <- 0
        MOV R1, #0x0         ; (R1) <- 0
        MOV R2, #0x0         ; (R2) <- 0
        MOV R3, #0x999       ; (R3) <- 999

LOOP    CMP R0, R3           ; compare (R0) to (R3) = 999
        BEQ STOP             ; equal -> jump to STOP
        CMP R2, #99          ; compare (R2) to 999
        BNE FIRSTIF          ; jump -> FIRSTIF 
        MOV R1, #0           ; (R1) <- 0
        MOV R2, #0           ; (R2) <- 0
        ADD R0, #103         ; increment R0 by 1
        B LOOP               ; jump -> LOOP
        
FIRSTIF CMP R1, #0X9         ; compare (R1) to 9
        BEQ LOOP1            ; jump -> LOOP1
        ADD R0, R0, #1       ; increment (R0) by 1
        ADD R1, R1, #1       ; increment (R1) by 1
        ADD R2, R2, #1       ; increment (R2) by 1
        B LOOP

LOOP1   MOV R1, #0X0         ; (R1) <- 0
        ADD R2, #1           ; increment (R2) by 1
        ADD R0, #7           ; increment (R2) by 7
        B LOOP               ; jump -> LOOP
        
STOP    B STOP               ; infinite loop
        END