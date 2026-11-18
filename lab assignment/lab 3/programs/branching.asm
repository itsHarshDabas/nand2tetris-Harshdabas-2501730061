// Lab 3 Q1(b): conditional jumps.  R2 = max(R0, R1)
@R0
D=M
@R1
D=D-M      // D = R0 - R1
@R0_BIGGER
D;JGT      // if R0 - R1 > 0 jump
@R1        // else R1 is the max (or equal)
D=M
@R2
M=D
@END
0;JMP
(R0_BIGGER)
@R0
D=M
@R2
M=D
(END)
@END
0;JMP
