// Lab 3 - Q5: fetch-decode-execute trace, 3 consecutive instructions (from the arithmetic program)
// Fetch: read ROM[PC]. Decode: bit15=0 -> A-instruction (A=value); bit15=1 -> C-instruction (a, comp, dest, jump). Execute: ALU, write D/A/M, PC=PC+1 (or A if jump).
//   D=D+M    PC 11 -> 12   before A=1 D=12 M=5   after A=1 D=17 M=5   bits 1111000010010000
//   @R2      PC 12 -> 13   before A=1 D=17 M=5   after A=2 D=17 M=0   bits 0000000000000010
//   M=D      PC 13 -> 14   before A=2 D=17 M=0   after A=2 D=17 M=17   bits 1110001100001000
// Result: D = D + RAM[1] = 12 + 5 = 17, then A = 2, then RAM[2] = 17.
