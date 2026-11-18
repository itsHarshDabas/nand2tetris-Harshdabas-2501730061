// Lab 4 - Q4: memory-mapped I/O. SCREEN = 16384 = 100000000000000, KBD = 24576 = 110000000000000 (15-bit addresses)
// Address bits [14][13]: 0x = RAM, 10 = Screen, 11 = Keyboard. The Memory chip routes load/read by these two bits.
// Program: if a key is pressed paint SCREEN[0] black, else white.
//   0  @KBD      0110000000000000   A = 24576
//   1  D=M       1111110000010000   D = keyboard value (ASCII, 0 = no key)
//   2  @PRESSED  0000000000001000
//   3  D;JNE     1110001100000101
//   4  @SCREEN   0100000000000000   A = 16384
//   5  M=0       1110101010001000   SCREEN[0] = 0 (white)
//   6  @LOOP     0000000000000000
//   7  0;JMP     1110101010000111
//   8  @SCREEN   0100000000000000
//   9  M=-1      1110111010001000   SCREEN[0] = 1111111111111111 (16 black pixels)
//  10  @LOOP     0000000000000000
//  11  0;JMP     1110101010000111
// Key=0: D=0, JNE not taken, PC 3 -> 4, writes 0 to RAM[16384]. Key 'K'=75: D=75, JNE taken PC 3 -> 8, writes -1 to RAM[16384].
// Memory decode (simulator): addr 16384 -> screenSel=1 | addr 24575 -> screenSel=1 | addr 24576 -> kbdSel=1, writes ignored | addr 100 -> RAM.

// // Lab 4 Q4: keyboard and screen (memory-mapped I/O).
// // Forever: if a key is pressed (KBD != 0) paint the first 16 pixels black (SCREEN[0] = -1),
// //          otherwise clear them (SCREEN[0] = 0).
// (LOOP)
// @KBD
// D=M        // read the keyboard register (RAM[24576])
// @PRESSED
// D;JNE      // key pressed?
// @SCREEN
// M=0        // no key: SCREEN[0] = 0 (white)
// @LOOP
// 0;JMP
// (PRESSED)
// @SCREEN
// M=-1       // key: SCREEN[0] = -1 (all 16 bits = 1, black)
// @LOOP
// 0;JMP
