// Lab 4 - Q3: when zr / ng matter
// ALU gives zr (out==0) and ng (out<0). jump = isC & ((j1&ng) | (j2&zr) | (j3&positive)), positive = !zr & !ng.
// Critical for conditional jumps, e.g. Max uses D;JGT on D = R0 - R1. Also 0;JMP: ALU out is 0 so zr=1.
// Tested with two deliberately wrong CPUs:
//   Bug A (positive ignores ng): Max(3,5) returns 3 instead of 5 (D=-2 counted as positive, jump taken wrongly).
//   Bug B (zr not used for JEQ): breaks JEQ and every 0;JMP -> PC runs past the end of the program;
//          zero-test with R0=-4 gives 0 instead of 1.
// Correct CPU, Max(3,5): cycle 5 D;JGT ALU=-2 ng=1 jump=0 -> PC 6.   Bug A: same row but jump=1 -> PC 10.
