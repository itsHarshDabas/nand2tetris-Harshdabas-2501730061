// Lab 4 - Q2: fetch-decode-execute timing
// The Hack CPU is single-cycle: PC -> ROM -> decode -> ALU -> flags -> jump logic all happen through gates inside ONE clock cycle.
// The clock edge only stores the results (A, D, RAM, new PC).
//   D=D-A (cycle 3): fetch, decode, execute all done at time 3 (instr visible, ALU out = 2). D = 2 at time 4.
//   @R0   (cycle 4): fetch/decode/execute done at time 4. A = 0 at time 5.
//   M=D   (cycle 5): done at time 5 (writeM=1, ALU = 2). RAM[0] = 2 at time 5+ (clock edge), readable at cycle 6.
// Critical path: PC -> ROM32K -> decode -> ALU -> zr/ng -> jump logic -> PC input. Clock period must be longer than that.
