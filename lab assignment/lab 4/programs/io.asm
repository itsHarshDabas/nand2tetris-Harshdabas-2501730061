// Lab 4 Q4: keyboard and screen (memory-mapped I/O).
// Forever: if a key is pressed (KBD != 0) paint the first 16 pixels black (SCREEN[0] = -1),
//          otherwise clear them (SCREEN[0] = 0).
(LOOP)
@KBD
D=M        // read the keyboard register (RAM[24576])
@PRESSED
D;JNE      // key pressed?
@SCREEN
M=0        // no key: SCREEN[0] = 0 (white)
@LOOP
0;JMP
(PRESSED)
@SCREEN
M=-1       // key: SCREEN[0] = -1 (all 16 bits = 1, black)
@LOOP
0;JMP
