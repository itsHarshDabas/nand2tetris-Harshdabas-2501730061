// Lab 2 Q4: RAM64 (gate level). address[6] = [high 3 bits -> which RAM8][low 3 bits -> register inside it].
load RAM64.hdl,
compare-to RAM64-trace.cmp,
output-list time%S1.4.1 address%B1.7.1 in%D1.4.1 load%B2.1.2 out%D1.4.1;

set address 0, set in 11, set load 1,
tick,
tock,
output;   // write 11 to address 0

set address 9, set in 22, set load 1,
tick,
tock,
output;   // write 22 to address 9

set address 38, set in 33, set load 1,
tick,
tock,
output;   // write 33 to address 38

set address 63, set in 44, set load 1,
tick,
tock,
output;   // write 44 to address 63

set address 0, set in 0, set load 0,
tick,
tock,
output;   // read address 0

set address 9, set in 0, set load 0,
tick,
tock,
output;   // read address 9

set address 38, set in 0, set load 0,
tick,
tock,
output;   // read address 38

set address 63, set in 0, set load 0,
tick,
tock,
output;   // read address 63

set address 1, set in 0, set load 0,
tick,
tock,
output;   // read address 1
