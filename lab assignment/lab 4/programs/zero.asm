// Lab 4 Q3 program: R1 = 0 if R0 == 0, otherwise R1 = 1.  Uses D;JEQ, which depends on the zr flag.
@R0
D=M
@IS_ZERO
D;JEQ      // jump only if the ALU output is zero (zr = 1)
@R1
M=1
@END
0;JMP
(IS_ZERO)
@R1
M=0
(END)
@END
0;JMP
