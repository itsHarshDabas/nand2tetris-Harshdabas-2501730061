// Lab 2 Q3: RAM8 (gate level). Four+ addresses written; all 8 registers printed after every write.
load RAM8View.hdl,
compare-to RAM8-trace.cmp,
output-list time%S1.4.1 address%D1.7.1 in%D1.4.1 load%B2.1.2 r0%D1.4.1 r1%D1.4.1 r2%D1.4.1 r3%D1.4.1 r4%D1.4.1 r5%D1.4.1 r6%D1.4.1 r7%D1.4.1 out%D1.4.1;

set address 0, set in 11, set load 1,
tick,
tock,
output;   // write 11 into register 0

set address 3, set in 33, set load 1,
tick,
tock,
output;   // write 33 into register 3

set address 5, set in 55, set load 1,
tick,
tock,
output;   // write 55 into register 5

set address 7, set in 77, set load 1,
tick,
tock,
output;   // write 77 into register 7

set address 3, set in 99, set load 1,
tick,
tock,
output;   // write 99 into register 3

set address 5, set in 0, set load 0,
tick,
tock,
output;   // read register 5 (load = 0, nothing changes)

set address 0, set in 0, set load 0,
tick,
tock,
output;   // read register 0 (load = 0, nothing changes)
