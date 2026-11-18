// Lab 3 - Q1: Hack assembly programs (run on the CPU emulator)

// (a) Arithmetic - result: R2=17, R3=7, R4=34
// // Lab 3 Q1(a): arithmetic.
// // R0 = 12, R1 = 5.  R2 = R0 + R1,  R3 = R0 - R1,  R4 = 2 * R2.
// @12
// D=A
// @R0
// M=D
// @5
// D=A
// @R1
// M=D
// @R0
// D=M
// @R1
// D=D+M
// @R2
// M=D
// @R0
// D=M
// @R1
// D=D-M
// @R3
// M=D
// @R2
// D=M
// D=D+M
// @R4
// M=D
// (END)
// @END
// 0;JMP

// (b) Branching - R2 = max(R0,R1). R0=9,R1=14 -> R2=14.  R0=20,R1=6 -> R2=20
// // Lab 3 Q1(b): conditional jumps.  R2 = max(R0, R1)
// @R0
// D=M
// @R1
// D=D-M      // D = R0 - R1
// @R0_BIGGER
// D;JGT      // if R0 - R1 > 0 jump
// @R1        // else R1 is the max (or equal)
// D=M
// @R2
// M=D
// @END
// 0;JMP
// (R0_BIGGER)
// @R0
// D=M
// @R2
// M=D
// (END)
// @END
// 0;JMP

// (c) Loop - R1 = 1+2+..+R0. R0=5 -> R1=15
// // Lab 3 Q1(c): loop.  R1 = 1 + 2 + ... + R0
// @R0
// D=M
// @n
// M=D        // n = R0
// @sum
// M=0
// @i
// M=1
// (LOOP)
// @i
// D=M
// @n
// D=D-M      // D = i - n
// @STOP
// D;JGT      // if i > n leave the loop
// @i
// D=M
// @sum
// M=D+M      // sum = sum + i
// @i
// M=M+1      // i = i + 1
// @LOOP
// 0;JMP
// (STOP)
// @sum
// D=M
// @R1
// M=D
// (END)
// @END
// 0;JMP
