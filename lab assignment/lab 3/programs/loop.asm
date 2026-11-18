// Lab 3 Q1(c): loop.  R1 = 1 + 2 + ... + R0
@R0
D=M
@n
M=D        // n = R0
@sum
M=0
@i
M=1
(LOOP)
@i
D=M
@n
D=D-M      // D = i - n
@STOP
D;JGT      // if i > n leave the loop
@i
D=M
@sum
M=D+M      // sum = sum + i
@i
M=M+1      // i = i + 1
@LOOP
0;JMP
(STOP)
@sum
D=M
@R1
M=D
(END)
@END
0;JMP
