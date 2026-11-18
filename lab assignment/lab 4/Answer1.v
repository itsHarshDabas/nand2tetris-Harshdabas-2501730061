// Lab 4 - Q1: signal trace (from the simulator), program: @7 D=A @5 D=D-A @R0 M=D @END D;JGT ...
// For A-instructions the ALU output is ignored (loadD=0, writeM=0).
//   cycle  0  PC= 0  @7       loadA=1 loadD=0 writeM=0 ALU= 0 zr=1 ng=0 jump=0 A= 0 D=0
//   cycle  1  PC= 1  D=A      loadA=0 loadD=1 writeM=0 ALU= 7 zr=0 ng=0 jump=0 A= 7 D=0
//   cycle  2  PC= 2  @5       loadA=1 loadD=0 writeM=0 ALU= 7 zr=0 ng=0 jump=0 A= 7 D=7
//   cycle  3  PC= 3  D=D-A    loadA=0 loadD=1 writeM=0 ALU= 2 zr=0 ng=0 jump=0 A= 5 D=7
//   cycle  4  PC= 4  @R0      loadA=1 loadD=0 writeM=0 ALU= 0 zr=1 ng=0 jump=0 A= 5 D=2
//   cycle  5  PC= 5  M=D      loadA=0 loadD=0 writeM=1 ALU= 2 zr=0 ng=0 jump=0 A= 0 D=2
//   cycle  6  PC= 6  @END     loadA=1 loadD=0 writeM=0 ALU= 0 zr=1 ng=0 jump=0 A= 0 D=2
//   cycle  7  PC= 7  D;JGT    loadA=0 loadD=0 writeM=0 ALU= 2 zr=0 ng=0 jump=1 A=10 D=2
//   cycle  8  PC=10  @END     loadA=1 loadD=0 writeM=0 ALU= 2 zr=0 ng=0 jump=0 A=10 D=2
//   cycle  9  PC=11  0;JMP    loadA=0 loadD=0 writeM=0 ALU= 0 zr=1 ng=0 jump=1 A=10 D=2
//   cycle 10  PC=10  @END     loadA=1 loadD=0 writeM=0 ALU= 2 zr=0 ng=0 jump=0 A=10 D=2
//   cycle 11  PC=11  0;JMP    loadA=0 loadD=0 writeM=0 ALU= 0 zr=1 ng=0 jump=1 A=10 D=2
// cycle 3 D=D-A: ALU = 7-5 = 2.  cycle 5 M=D: writeM=1, RAM[0]=2.  cycle 7 D;JGT: ALU=2, zr=0, ng=0 -> jump=1, PC 7 -> 10.
