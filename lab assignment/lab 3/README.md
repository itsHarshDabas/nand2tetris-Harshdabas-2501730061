# Lab 3 – CPU, Assembly Programming and the Computer

**Course:** Nand to Tetris – I (ETCCNT301), K.R. Mangalam University  
**Name:** Harsh Dabas | **Roll no:** 2501730061  
**Tools:** Nand2Tetris CPU Emulator and Hardware Simulator (Projects 4 and 5), my assembler `capstone/assembler.py`

## What is in this folder

| File | What it is |
|---|---|
| `programs/arithmetic.asm`, `branching.asm`, `loop.asm` | Question 1 programs (with their `.hack` machine code) |
| `programs/add.asm`, `max.asm` | the two programs hand-encoded in Question 2 |
| `CPU.hdl`, `Computer.hdl`, `Memory.hdl` | Questions 3 and 4 (`ALU.hdl` is the Lab 1 ALU) |
| `*.tst`, `*.cmp`, `*.hack` | test scripts, expected output, and test ROMs |
| `output/` | CPU emulator traces (`*.json`, `loop_5_trace.md`) and simulator output (`*.out`) |

## Test results (chips)

| Test script | Result |
|---|---|
| CPU.tst (official) | ✅ PASS |
| CPU-external.tst (official) | ✅ PASS |
| ComputerAdd.tst (official) | ✅ PASS |
| ComputerMax.tst (official) | ✅ PASS |
| ComputerRect.tst (official) | ✅ PASS |
| ComputerLoop.tst (mine) | ✅ PASS |
| Memory-map.tst (mine) | ✅ PASS |

When a chip uses another chip (for example `CPU` uses `ALU`, `Computer` uses `Memory`), the simulator picks its own built-in version of that part. So each file is checked for correct wiring on top of the built-in parts.

## How the programs were run and checked
- Every `.asm` program was assembled with my assembler (`capstone/assembler.py`). The result is identical, line for line, to the output of the Nand2Tetris assembler code.
- Each program was run on the CPU emulator code of the Nand2Tetris web IDE, and a trace of every instruction was recorded (A, D, M before and after, next PC, RAM writes).
- I also checked every trace step by step against a second, separate model of the Hack CPU written in Python. All four runs agree in every step.
- Notation in the traces: **M** means `RAM[A]` (the RAM cell A points to). `A / D / M before` is the state just before the instruction runs and `A / D / M after` is the state after it.

---

## Question 1 – Hack assembly programs

### (a) Arithmetic: `programs/arithmetic.asm`
Computes `R2 = R0 + R1`, `R3 = R0 - R1` and `R4 = 2 * R2` with `R0 = 12` and `R1 = 5`.

```asm
// Lab 3 Q1(a): arithmetic.
// R0 = 12, R1 = 5.  R2 = R0 + R1,  R3 = R0 - R1,  R4 = 2 * R2.
@12
D=A
@R0
M=D
@5
D=A
@R1
M=D
@R0
D=M
@R1
D=D+M
@R2
M=D
@R0
D=M
@R1
D=D-M
@R3
M=D
@R2
D=M
D=D+M
@R4
M=D
(END)
@END
0;JMP
```

Trace (27 instructions):

| step | PC | instruction | binary | A / D / M before | A / D / M after | next PC | RAM write |
|---|---|---|---|---|---|---|---|
| 1 | 0 | `@12` | `0000000000001100` | 0 / 0 / 0 | 12 / 0 / 0 | 1 |  |
| 2 | 1 | `D=A` | `1110110000010000` | 12 / 0 / 0 | 12 / 12 / 0 | 2 |  |
| 3 | 2 | `@R0` | `0000000000000000` | 12 / 12 / 0 | 0 / 12 / 0 | 3 |  |
| 4 | 3 | `M=D` | `1110001100001000` | 0 / 12 / 0 | 0 / 12 / 12 | 4 | RAM[0] = 12 |
| 5 | 4 | `@5` | `0000000000000101` | 0 / 12 / 12 | 5 / 12 / 0 | 5 |  |
| 6 | 5 | `D=A` | `1110110000010000` | 5 / 12 / 0 | 5 / 5 / 0 | 6 |  |
| 7 | 6 | `@R1` | `0000000000000001` | 5 / 5 / 0 | 1 / 5 / 0 | 7 |  |
| 8 | 7 | `M=D` | `1110001100001000` | 1 / 5 / 0 | 1 / 5 / 5 | 8 | RAM[1] = 5 |
| 9 | 8 | `@R0` | `0000000000000000` | 1 / 5 / 5 | 0 / 5 / 12 | 9 |  |
| 10 | 9 | `D=M` | `1111110000010000` | 0 / 5 / 12 | 0 / 12 / 12 | 10 |  |
| 11 | 10 | `@R1` | `0000000000000001` | 0 / 12 / 12 | 1 / 12 / 5 | 11 |  |
| 12 | 11 | `D=D+M` | `1111000010010000` | 1 / 12 / 5 | 1 / 17 / 5 | 12 |  |
| 13 | 12 | `@R2` | `0000000000000010` | 1 / 17 / 5 | 2 / 17 / 0 | 13 |  |
| 14 | 13 | `M=D` | `1110001100001000` | 2 / 17 / 0 | 2 / 17 / 17 | 14 | RAM[2] = 17 |
| 15 | 14 | `@R0` | `0000000000000000` | 2 / 17 / 17 | 0 / 17 / 12 | 15 |  |
| 16 | 15 | `D=M` | `1111110000010000` | 0 / 17 / 12 | 0 / 12 / 12 | 16 |  |
| 17 | 16 | `@R1` | `0000000000000001` | 0 / 12 / 12 | 1 / 12 / 5 | 17 |  |
| 18 | 17 | `D=D-M` | `1111010011010000` | 1 / 12 / 5 | 1 / 7 / 5 | 18 |  |
| 19 | 18 | `@R3` | `0000000000000011` | 1 / 7 / 5 | 3 / 7 / 0 | 19 |  |
| 20 | 19 | `M=D` | `1110001100001000` | 3 / 7 / 0 | 3 / 7 / 7 | 20 | RAM[3] = 7 |
| 21 | 20 | `@R2` | `0000000000000010` | 3 / 7 / 7 | 2 / 7 / 17 | 21 |  |
| 22 | 21 | `D=M` | `1111110000010000` | 2 / 7 / 17 | 2 / 17 / 17 | 22 |  |
| 23 | 22 | `D=D+M` | `1111000010010000` | 2 / 17 / 17 | 2 / 34 / 17 | 23 |  |
| 24 | 23 | `@R4` | `0000000000000100` | 2 / 34 / 17 | 4 / 34 / 0 | 24 |  |
| 25 | 24 | `M=D` | `1110001100001000` | 4 / 34 / 0 | 4 / 34 / 34 | 25 | RAM[4] = 34 |
| 26 | 25 | `@END` | `0000000000011001` | 4 / 34 / 34 | 25 / 34 / 0 | 26 |  |
| 27 | 26 | `0;JMP` | `1110101010000111` | 25 / 34 / 0 | 25 / 34 / 0 | 25 |  |

**Result:** RAM[0] = 12, RAM[1] = 5, RAM[2] = 17, RAM[3] = 7, RAM[4] = 34. Correct: 12 + 5 = 17, 12 - 5 = 7, 2 × 17 = 34.

### (b) Branching: `programs/branching.asm`
Computes `R2 = max(R0, R1)`. It subtracts the two numbers and uses the conditional jump `D;JGT` to choose the branch.

```asm
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
```

**Run 1: R0 = 9, R1 = 14** (R0 − R1 = −5, not greater than 0, so the jump is NOT taken and R1 is copied):

| step | PC | instruction | binary | A / D / M before | A / D / M after | next PC | RAM write |
|---|---|---|---|---|---|---|---|
| 1 | 0 | `@R0` | `0000000000000000` | 0 / 0 / 9 | 0 / 0 / 9 | 1 |  |
| 2 | 1 | `D=M` | `1111110000010000` | 0 / 0 / 9 | 0 / 9 / 9 | 2 |  |
| 3 | 2 | `@R1` | `0000000000000001` | 0 / 9 / 9 | 1 / 9 / 14 | 3 |  |
| 4 | 3 | `D=D-M` | `1111010011010000` | 1 / 9 / 14 | 1 / -5 / 14 | 4 |  |
| 5 | 4 | `@R0_BIGGER` | `0000000000001100` | 1 / -5 / 14 | 12 / -5 / 0 | 5 |  |
| 6 | 5 | `D;JGT` | `1110001100000001` | 12 / -5 / 0 | 12 / -5 / 0 | 6 |  |
| 7 | 6 | `@R1` | `0000000000000001` | 12 / -5 / 0 | 1 / -5 / 14 | 7 |  |
| 8 | 7 | `D=M` | `1111110000010000` | 1 / -5 / 14 | 1 / 14 / 14 | 8 |  |
| 9 | 8 | `@R2` | `0000000000000010` | 1 / 14 / 14 | 2 / 14 / 0 | 9 |  |
| 10 | 9 | `M=D` | `1110001100001000` | 2 / 14 / 0 | 2 / 14 / 14 | 10 | RAM[2] = 14 |
| 11 | 10 | `@END` | `0000000000010000` | 2 / 14 / 14 | 16 / 14 / 0 | 11 |  |
| 12 | 11 | `0;JMP` | `1110101010000111` | 16 / 14 / 0 | 16 / 14 / 0 | 16 |  |
| 13 | 16 | `@END` | `0000000000010000` | 16 / 14 / 0 | 16 / 14 / 0 | 17 |  |
| 14 | 17 | `0;JMP` | `1110101010000111` | 16 / 14 / 0 | 16 / 14 / 0 | 16 |  |

**Result:** RAM[0] = 9, RAM[1] = 14, RAM[2] = 14.

**Run 2: R0 = 20, R1 = 6** (R0 − R1 = 14 > 0, so the jump IS taken to `R0_BIGGER`):

| step | PC | instruction | binary | A / D / M before | A / D / M after | next PC | RAM write |
|---|---|---|---|---|---|---|---|
| 1 | 0 | `@R0` | `0000000000000000` | 0 / 0 / 20 | 0 / 0 / 20 | 1 |  |
| 2 | 1 | `D=M` | `1111110000010000` | 0 / 0 / 20 | 0 / 20 / 20 | 2 |  |
| 3 | 2 | `@R1` | `0000000000000001` | 0 / 20 / 20 | 1 / 20 / 6 | 3 |  |
| 4 | 3 | `D=D-M` | `1111010011010000` | 1 / 20 / 6 | 1 / 14 / 6 | 4 |  |
| 5 | 4 | `@R0_BIGGER` | `0000000000001100` | 1 / 14 / 6 | 12 / 14 / 0 | 5 |  |
| 6 | 5 | `D;JGT` | `1110001100000001` | 12 / 14 / 0 | 12 / 14 / 0 | 12 |  |
| 7 | 12 | `@R0` | `0000000000000000` | 12 / 14 / 0 | 0 / 14 / 20 | 13 |  |
| 8 | 13 | `D=M` | `1111110000010000` | 0 / 14 / 20 | 0 / 20 / 20 | 14 |  |
| 9 | 14 | `@R2` | `0000000000000010` | 0 / 20 / 20 | 2 / 20 / 0 | 15 |  |
| 10 | 15 | `M=D` | `1110001100001000` | 2 / 20 / 0 | 2 / 20 / 20 | 16 | RAM[2] = 20 |
| 11 | 16 | `@END` | `0000000000010000` | 2 / 20 / 20 | 16 / 20 / 0 | 17 |  |
| 12 | 17 | `0;JMP` | `1110101010000111` | 16 / 20 / 0 | 16 / 20 / 0 | 16 |  |

**Result:** RAM[0] = 20, RAM[1] = 6, RAM[2] = 20. Both branches were exercised and both give the maximum.

### (c) Loop: `programs/loop.asm`
Computes `R1 = 1 + 2 + ... + R0` with `R0 = 5`. The variables get RAM addresses in the order they first appear: `n` = RAM[16], `sum` = RAM[17], `i` = RAM[18]. The loop checks `i - n > 0` at the top with `D;JGT`, adds `i` to `sum`, increments `i` and jumps back with `0;JMP`.

```asm
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
```

The full trace has 90 instructions and is saved in [`output/loop_5_trace.md`](output/loop_5_trace.md). The start (first 12 instructions) and the end (last 3) are shown here:

| step | PC | instruction | binary | A / D / M before | A / D / M after | next PC | RAM write |
|---|---|---|---|---|---|---|---|
| 1 | 0 | `@R0` | `0000000000000000` | 0 / 0 / 5 | 0 / 0 / 5 | 1 |  |
| 2 | 1 | `D=M` | `1111110000010000` | 0 / 0 / 5 | 0 / 5 / 5 | 2 |  |
| 3 | 2 | `@n` | `0000000000010000` | 0 / 5 / 5 | 16 / 5 / 0 | 3 |  |
| 4 | 3 | `M=D` | `1110001100001000` | 16 / 5 / 0 | 16 / 5 / 5 | 4 | RAM[16] = 5 |
| 5 | 4 | `@sum` | `0000000000010001` | 16 / 5 / 5 | 17 / 5 / 0 | 5 |  |
| 6 | 5 | `M=0` | `1110101010001000` | 17 / 5 / 0 | 17 / 5 / 0 | 6 | RAM[17] = 0 |
| 7 | 6 | `@i` | `0000000000010010` | 17 / 5 / 0 | 18 / 5 / 0 | 7 |  |
| 8 | 7 | `M=1` | `1110111111001000` | 18 / 5 / 0 | 18 / 5 / 1 | 8 | RAM[18] = 1 |
| 9 | 8 | `@i` | `0000000000010010` | 18 / 5 / 1 | 18 / 5 / 1 | 9 |  |
| 10 | 9 | `D=M` | `1111110000010000` | 18 / 5 / 1 | 18 / 1 / 1 | 10 |  |
| 11 | 10 | `@n` | `0000000000010000` | 18 / 1 / 1 | 16 / 1 / 5 | 11 |  |
| 12 | 11 | `D=D-M` | `1111010011010000` | 16 / 1 / 5 | 16 / -4 / 5 | 12 |  |
| 88 | 25 | `M=D` | `1110001100001000` | 1 / 15 / 0 | 1 / 15 / 15 | 26 | RAM[1] = 15 |
| 89 | 26 | `@END` | `0000000000011010` | 1 / 15 / 15 | 26 / 15 / 0 | 27 |  |
| 90 | 27 | `0;JMP` | `1110101010000111` | 26 / 15 / 0 | 26 / 15 / 0 | 26 |  |

**Result:** RAM[0] = 5, RAM[1] = 15, RAM[16] = 5, RAM[17] = 15, RAM[18] = 6. So `R1 = 1 + 2 + 3 + 4 + 5 = 15`, and the loop ran 5 times (i ends at 6, which is when `i - n > 0` stops it).

---

## Question 2 – Hand-encoding two Hack programs to binary

**Rules used.**
- **A-instruction** `@value`: `0` followed by the value as 15 bits.
- **C-instruction** `dest=comp;jump`: `1 1 1 a c1 c2 c3 c4 c5 c6 d1 d2 d3 j1 j2 j3`.
  - `a = 0` when the ALU uses A, `a = 1` when it uses M.
  - `c1..c6` choose the ALU function (for example `D+A` = `000010`, `D+M` = `000010` with `a = 1`, `D-M` = `010011`, `A` = `110000`, `M` = `110000` with `a = 1`, `D` = `001100`).
  - `d1 d2 d3` = destination bits for A, D, M. `M=D` is `001`, `D=A` is `010`.
  - `j1 j2 j3` = jump on out < 0, out = 0, out > 0. `JGT` = `001`, `JMP` = `111`, no jump = `000`.

### Program 1: `programs/add.asm` (RAM[0] = 2 + 3)
```asm
// Hand-encoded program 1: RAM[0] = 2 + 3
@2
D=A
@3
D=D+A
@0
M=D
```

| PC | assembly | fields (`111` a c1..c6 d1d2d3 j1j2j3) | breakdown | machine code |
|---|---|---|---|---|
| 0 | `@2` | `0` `000000000000010` | A-instruction: `0` + 15-bit value 2 | `0000000000000010` |
| 1 | `D=A` | `111` `0` `110000` `010` `000` | comp `A` = `0110000`; dest `D` = `010`; jump `null` = `000` | `1110110000010000` |
| 2 | `@3` | `0` `000000000000011` | A-instruction: `0` + 15-bit value 3 | `0000000000000011` |
| 3 | `D=D+A` | `111` `0` `000010` `010` `000` | comp `D+A` = `0000010`; dest `D` = `010`; jump `null` = `000` | `1110000010010000` |
| 4 | `@0` | `0` `000000000000000` | A-instruction: `0` + 15-bit value 0 | `0000000000000000` |
| 5 | `M=D` | `111` `0` `001100` `001` `000` | comp `D` = `0001100`; dest `M` = `001`; jump `null` = `000` | `1110001100001000` |

### Program 2: `programs/max.asm` (RAM[2] = max(RAM[0], RAM[1]))
This is the same algorithm as the branching program, with the jump targets written as numbers (10, 12, 14) so that it can be encoded by hand.

```asm
// Hand-encoded program 2: RAM[2] = max(RAM[0], RAM[1])
@0
D=M
@1
D=D-M
@10
D;JGT
@1
D=M
@12
0;JMP
@0
D=M
@2
M=D
@14
0;JMP
```

| PC | assembly | fields (`111` a c1..c6 d1d2d3 j1j2j3) | breakdown | machine code |
|---|---|---|---|---|
| 0 | `@0` | `0` `000000000000000` | A-instruction: `0` + 15-bit value 0 | `0000000000000000` |
| 1 | `D=M` | `111` `1` `110000` `010` `000` | comp `M` = `1110000`; dest `D` = `010`; jump `null` = `000` | `1111110000010000` |
| 2 | `@1` | `0` `000000000000001` | A-instruction: `0` + 15-bit value 1 | `0000000000000001` |
| 3 | `D=D-M` | `111` `1` `010011` `010` `000` | comp `D-M` = `1010011`; dest `D` = `010`; jump `null` = `000` | `1111010011010000` |
| 4 | `@10` | `0` `000000000001010` | A-instruction: `0` + 15-bit value 10 | `0000000000001010` |
| 5 | `D;JGT` | `111` `0` `001100` `000` `001` | comp `D` = `0001100`; dest `null` = `000`; jump `JGT` = `001` | `1110001100000001` |
| 6 | `@1` | `0` `000000000000001` | A-instruction: `0` + 15-bit value 1 | `0000000000000001` |
| 7 | `D=M` | `111` `1` `110000` `010` `000` | comp `M` = `1110000`; dest `D` = `010`; jump `null` = `000` | `1111110000010000` |
| 8 | `@12` | `0` `000000000001100` | A-instruction: `0` + 15-bit value 12 | `0000000000001100` |
| 9 | `0;JMP` | `111` `0` `101010` `000` `111` | comp `0` = `0101010`; dest `null` = `000`; jump `JMP` = `111` | `1110101010000111` |
| 10 | `@0` | `0` `000000000000000` | A-instruction: `0` + 15-bit value 0 | `0000000000000000` |
| 11 | `D=M` | `111` `1` `110000` `010` `000` | comp `M` = `1110000`; dest `D` = `010`; jump `null` = `000` | `1111110000010000` |
| 12 | `@2` | `0` `000000000000010` | A-instruction: `0` + 15-bit value 2 | `0000000000000010` |
| 13 | `M=D` | `111` `0` `001100` `001` `000` | comp `D` = `0001100`; dest `M` = `001`; jump `null` = `000` | `1110001100001000` |
| 14 | `@14` | `0` `000000000001110` | A-instruction: `0` + 15-bit value 14 | `0000000000001110` |
| 15 | `0;JMP` | `111` `0` `101010` `000` `111` | comp `0` = `0101010`; dest `null` = `000`; jump `JMP` = `111` | `1110101010000111` |

**Check:** my assembler produces exactly this binary for both programs, and the binary is identical to the official `Add.hack` and `Max.hack` files of the course.

---

## Question 3 – CPU chip

The CPU has three parts: the **A register**, the **D register**, and the **ALU**, plus the jump and control logic.

- `isA = !instruction[15]` and `isC = instruction[15]` decide the instruction type.
- A gets either the instruction (A-instruction) or the ALU output (a C-instruction with `d1 = 1`). `loadA = isA OR (isC AND d1)`.
- D loads the ALU output when `isC AND d2`.
- The ALU's second input is A or `inM` depending on the `a` bit (`instruction[12]`). The six `c` bits drive `zx nx zy ny f no`.
- `writeM = isC AND d3`. `addressM` is the A register. `outM` is the ALU output.
- Jump: `jump = isC AND ((j1 AND ng) OR (j2 AND zr) OR (j3 AND positive))`, where `positive = !zr AND !ng`. When `jump = 1`, the PC loads A, otherwise it counts up. `reset` sends PC to 0.

```hdl
// Hack CPU: A register, D register, ALU and PC.
// instruction[15] = 0 -> A-instruction (load the value into A)
// instruction[15] = 1 -> C-instruction: 111 a cccccc ddd jjj
//   a      = instruction[12]      (0: ALU uses A, 1: ALU uses M)
//   c1..c6 = instruction[11..6]   (zx nx zy ny f no)
//   d1..d3 = instruction[5..3]    (store in A, D, M)
//   j1..j3 = instruction[2..0]    (jump if out<0, out=0, out>0)
CHIP CPU {
    IN  inM[16],         // M value input  (M = contents of RAM[A])
        instruction[16], // Instruction for execution
        reset;           // 1 = restart the program (PC = 0)

    OUT outM[16],        // M value output
        writeM,          // Write to M?
        addressM[15],    // Address in data memory (of M)
        pc[15];          // address of next instruction

    PARTS:
    // ---- decode ----
    Not(in=instruction[15], out=isA);
    And(a=instruction[15], b=true, out=isC);

    // ---- A register ----
    // A-instruction: A = instruction. C-instruction: A = ALU output.
    Mux16(a=instruction, b=aluOut, sel=isC, out=aIn);
    And(a=isC, b=instruction[5], out=cLoadA);
    Or(a=isA, b=cLoadA, out=loadA);
    ARegister(in=aIn, load=loadA, out=aOut, out[0..14]=addressM);

    // ---- D register ----
    And(a=isC, b=instruction[4], out=loadD);
    DRegister(in=aluOut, load=loadD, out=dOut);

    // ---- ALU: x = D, y = A or M ----
    Mux16(a=aOut, b=inM, sel=instruction[12], out=aOrM);
    ALU(x=dOut, y=aOrM,
        zx=instruction[11], nx=instruction[10],
        zy=instruction[9],  ny=instruction[8],
        f=instruction[7],   no=instruction[6],
        out=aluOut, out=outM, zr=zr, ng=ng);

    // ---- write M ----
    And(a=isC, b=instruction[3], out=writeM);

    // ---- jump logic ----
    Not(in=zr, out=nzr);
    Not(in=ng, out=nng);
    And(a=nzr, b=nng, out=pos);              // out > 0
    And(a=instruction[2], b=ng,  out=jlt);
    And(a=instruction[1], b=zr,  out=jeq);
    And(a=instruction[0], b=pos, out=jgt);
    Or(a=jlt, b=jeq, out=j1);
    Or(a=j1, b=jgt, out=j2);
    And(a=isC, b=j2, out=jump);

    // ---- program counter ----
    PC(in=aOut, load=jump, inc=true, reset=reset, out[0..14]=pc);
}
```

Results: the official `CPU.tst` and `CPU-external.tst` both pass (see the table at the top). The first rows of `CPU.tst`:

```text
|time| inM  |  instruction   |reset| outM  |writeM |addre| pc  |DRegiste|
|0+  |     0|0011000000111001|  0  |      0|   0   |    0|    0|      0 |
|1   |     0|0011000000111001|  0  |      0|   0   |12345|    1|      0 |
|1+  |     0|1110110000010000|  0  |  12345|   0   |12345|    1|  12345 |
|2   |     0|1110110000010000|  0  |  12345|   0   |12345|    2|  12345 |
|2+  |     0|0101101110100000|  0  |      0|   0   |12345|    2|  12345 |
|3   |     0|0101101110100000|  0  |      0|   0   |23456|    3|  12345 |
|3+  |     0|1110000111010000|  0  |  11111|   0   |23456|    3|  11111 |
|4   |     0|1110000111010000|  0  |  12345|   0   |23456|    4|  11111 |
|4+  |     0|0000001111101000|  0  | -11111|   0   |23456|    4|  11111 |
|5   |     0|0000001111101000|  0  | -11111|   0   | 1000|    5|  11111 |
|5+  |     0|1110001100001000|  0  |  11111|   1   | 1000|    5|  11111 |
```

---

## Question 4 – Computer chip (CPU + ROM + Memory)

`Computer` connects the ROM32K (program), the CPU, and the Memory. The CPU's `pc` output goes to the ROM address, the ROM's `out` is the instruction, and `addressM`, `outM`, `writeM` and `inM` connect to the Memory.

```hdl
// The Hack computer: CPU + ROM32K (instruction memory) + Memory (data memory).
// reset = 1 starts the program from instruction 0.
CHIP Computer {
    IN reset;

    PARTS:
    ROM32K(address=pc, out=instruction);
    CPU(inM=memOut, instruction=instruction, reset=reset,
        outM=outM, writeM=writeM, addressM=addressM, pc=pc);
    Memory(in=outM, load=writeM, address=addressM, out=memOut);
}
```

`Memory` is one 32K address space split in three: addresses 0 to 16383 are RAM, 16384 to 24575 are the screen, and 24576 is the keyboard.

```hdl
// Hack data memory: 32K address space.
//   0     - 16383 : RAM (RAM16K)
//   16384 - 24575 : Screen memory map (8K)
//   24576         : Keyboard memory map
// Addresses above 24576 are invalid.
// address[14] = 0 -> RAM;  address[13..14] = 10 -> Screen;  11 -> Keyboard
CHIP Memory {
    IN in[16], load, address[15];
    OUT out[16];

    PARTS:
    // route the load bit: a/b = RAM, c = Screen, d = Keyboard (read only)
    DMux4Way(in=load, sel=address[13..14], a=loadRam1, b=loadRam2, c=loadScreen, d=loadKbd);
    Or(a=loadRam1, b=loadRam2, out=loadRam);

    RAM16K(in=in, load=loadRam, address=address[0..13], out=ramOut);
    Screen(in=in, load=loadScreen, address=address[0..12], out=screenOut);
    Keyboard(out=kbdOut);

    Mux4Way16(a=ramOut, b=ramOut, c=screenOut, d=kbdOut, sel=address[13..14], out=out);
}
```

### Test ROM programs (4 programs, all pass)
| ROM | What it does | Test | Result |
|---|---|---|---|
| `Add.hack` | RAM[0] = 2 + 3 | `ComputerAdd.tst` | ✅ pass |
| `Max.hack` | RAM[2] = max(RAM[0], RAM[1]) (run with 3, 5 and then 23456, 12345) | `ComputerMax.tst` | ✅ pass |
| `Rect.hack` | draws a rectangle on the screen | `ComputerRect.tst` | ✅ pass |
| `loop.hack` (mine, from Question 1) | R1 = 1 + 2 + 3 + 4 + 5 | `ComputerLoop.tst` | ✅ pass |

`ComputerAdd` output:
```text
|time |reset|ARegister|DRegister|PC[]|RAM16K[0]|RAM16K[1]|RAM16K[2]|
| 0   |  0  |       0 |       0 |   0|       0 |       0 |       0 |
| 1   |  0  |       2 |       0 |   1|       0 |       0 |       0 |
| 2   |  0  |       2 |       2 |   2|       0 |       0 |       0 |
| 3   |  0  |       3 |       2 |   3|       0 |       0 |       0 |
| 4   |  0  |       3 |       5 |   4|       0 |       0 |       0 |
| 5   |  0  |       0 |       5 |   5|       0 |       0 |       0 |
| 6   |  0  |       0 |       5 |   6|       5 |       0 |       0 |
| 7   |  1  |       0 |       5 |   0|       0 |       0 |       0 |
| 8   |  0  |       2 |       5 |   1|       0 |       0 |       0 |
| 9   |  0  |       2 |       2 |   2|       0 |       0 |       0 |
| 10  |  0  |       3 |       2 |   3|       0 |       0 |       0 |
| 11  |  0  |       3 |       5 |   4|       0 |       0 |       0 |
| 12  |  0  |       0 |       5 |   5|       0 |       0 |       0 |
| 13  |  0  |       0 |       5 |   6|       5 |       0 |       0 |
```

`ComputerLoop` output (first 10 cycles, then the state after 90 cycles; RAM[1] = 15 is the answer, and the variables are RAM[16] = n, RAM[17] = sum, RAM[18] = i):
```text
|time |reset|ARegister|DRegister|PC[]|RAM16K[0]|RAM16K[1]|RAM16K[16|RAM16K[17|RAM16K[18|
| 0   |  0  |       0 |       0 |   0|       5 |       0 |       0 |       0 |       0 |
| 1   |  0  |       0 |       0 |   1|       5 |       0 |       0 |       0 |       0 |
| 2   |  0  |       0 |       5 |   2|       5 |       0 |       0 |       0 |       0 |
| 3   |  0  |      16 |       5 |   3|       5 |       0 |       0 |       0 |       0 |
| 4   |  0  |      16 |       5 |   4|       5 |       0 |       5 |       0 |       0 |
| 5   |  0  |      17 |       5 |   5|       5 |       0 |       5 |       0 |       0 |
| 6   |  0  |      17 |       5 |   6|       5 |       0 |       5 |       0 |       0 |
| 7   |  0  |      18 |       5 |   7|       5 |       0 |       5 |       0 |       0 |
| 8   |  0  |      18 |       5 |   8|       5 |       0 |       5 |       0 |       1 |
| 9   |  0  |      18 |       5 |   9|       5 |       0 |       5 |       0 |       1 |
| 10  |  0  |      18 |       1 |  10|       5 |       0 |       5 |       0 |       1 |
| 90  |  0  |      26 |      15 |  26|       5 |      15 |       5 |      15 |       6 |
```

The expected rows of `ComputerLoop.cmp` were checked against my Python CPU model (A, D and PC match at every printed cycle).

### Memory map test (`Memory-map.tst`)
Writes to the first and last cell of the RAM and screen ranges and to the keyboard address, then reads them back. The keyboard cell is read-only: writing 555 there has no effect and it reads 0 (no key pressed).

```text
| time |   in   |load |     address     |  out   |
| 1    |    111 |  1  | 000000000000000 |    111 |
| 2    |    222 |  1  | 011111111111111 |    222 |
| 3    |    333 |  1  | 100000000000000 |    333 |
| 4    |    444 |  1  | 101111111111111 |    444 |
| 5    |    555 |  1  | 110000000000000 |      0 |
| 6    |      0 |  0  | 000000000000000 |    111 |
| 7    |      0 |  0  | 011111111111111 |    222 |
| 8    |      0 |  0  | 100000000000000 |    333 |
| 9    |      0 |  0  | 101111111111111 |    444 |
| 10   |      0 |  0  | 110000000000000 |      0 |
| 11   |      0 |  0  | 010000000000000 |      0 |
| 12   |      0 |  0  | 100111000100000 |      0 |
```

---

## Question 5 – Manual fetch–decode–execute trace (3 consecutive instructions)

The three instructions come from `arithmetic.asm` (PC = 11, 12, 13). Just before them, `R0 = 12`, `R1 = 5`, A = 1 (pointing to R1) and D = 12.

| # | instruction | PC before | A / D / M before | A / D / M after | PC after |
|---|---|---|---|---|---|
| 1 | `D=D+M` | 11 | 1 / 12 / 5 | 1 / 17 / 5 | 12 |
| 2 | `@R2` | 12 | 1 / 17 / 5 | 2 / 17 / 0 | 13 |
| 3 | `M=D` | 13 | 2 / 17 / 0 | 2 / 17 / 17 | 14 |

#### Instruction 1: `D=D+M` (PC = 11)
- **Fetch:** PC = 11, so the CPU reads ROM[11] = `1111000010010000`.
- **Decode:** Bit 15 = `1`, so this is a **C-instruction**. a = `1` (ALU y input is M = RAM[A]), c1..c6 = `000010` → computes `D+M`, dest = `010` → `D`, jump = `000` → `no jump`.
- **Execute:** ALU output = `D+M` evaluated with D = 12 and M = 5. D ← 17.
- **PC update:** no jump, so PC ← PC + 1 = 12.
- **State after:** A = 1, D = 17, M = RAM[1] = 5, PC = 12.

#### Instruction 2: `@R2` (PC = 12)
- **Fetch:** PC = 12, so the CPU reads ROM[12] = `0000000000000010`.
- **Decode:** Bit 15 = `0`, so this is an **A-instruction**. The 15-bit value `000000000000010` = 2 is loaded into A.
- **Execute:** No ALU work. A ← 2. D and RAM are unchanged.
- **PC update:** no jump, so PC ← PC + 1 = 13.
- **State after:** A = 2, D = 17, M = RAM[2] = 0, PC = 13.

#### Instruction 3: `M=D` (PC = 13)
- **Fetch:** PC = 13, so the CPU reads ROM[13] = `1110001100001000`.
- **Decode:** Bit 15 = `1`, so this is a **C-instruction**. a = `0` (ALU y input is A), c1..c6 = `001100` → computes `D`, dest = `001` → `M`, jump = `000` → `no jump`.
- **Execute:** ALU output = `D` evaluated with D = 17 and A = 2. The result 17 is written to RAM[2] (writeM = 1).
- **PC update:** no jump, so PC ← PC + 1 = 14.
- **State after:** A = 2, D = 17, M = RAM[2] = 17, PC = 14.

**Result of the three instructions:** `D = 12 + RAM[1] = 17`, then `A = 2`, then `RAM[2] = 17`. So the sum is saved in R2, as the program intends. The Hack computer does fetch, decode and execute inside one clock cycle (one tick-tock), so each instruction above takes exactly one cycle.

All values in the table were checked against the emulator trace of `arithmetic.asm` (steps 12, 13 and 14 in `output/arithmetic.json`) and the Python model.
