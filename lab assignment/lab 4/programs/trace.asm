// Lab 4 Q1/Q2 program: R0 = 7 - 5, then a conditional jump that depends on the ALU flags.
@7
D=A
@5
D=D-A      // D = 2
@R0
M=D        // RAM[0] = 2
@END
D;JGT      // D = 2 > 0, so the jump to END is taken (uses the zr / ng flags)
@R1        // skipped
M=1        // skipped
(END)
@END
0;JMP
