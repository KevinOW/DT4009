        NAME    main
        PUBLIC  main
        SECTION .text : CODE (2)
        THUMB

main
        MOV R0, #0              ; (R0) <- 0
        MOV R1, #0              ; (R1) <- 0
        MOV R2, #0              ; (R2) <- 0

        MOV R3, #999            ; (R3) <- 999 in decimal

LOOP    CMP R0, R3             ; compare (R0) to 999
        BEQ STOP               ; equal -> jump to STOP

        ADD R0, R0, #1          ; increment R0 by 1
        ADD R2, R2, #1          ; increment R2 by 1
        CMP R2, #10             ; compare (R2) to 10
        BNE LOOP                ; different -> jump to LOOP, repeat

        MOV R2, #0              ; reset R2 to 0
        ADD R1, R1, #1          ; increment R1 by 1
        CMP R1, #10             ; compare (R1) to 10
        BNE LOOP                ; different -> jump to LOOP, repeat

        MOV R1, #0              ; reset R1 to 0
        B LOOP                  ; jump to LOOP, repeat

STOP    B STOP                  ; infinite loop

        END