// Lab 2 Q5: RAM8K. Writes at the first/last register of each block, then reads them back.
load RAM8K.hdl,
compare-to RAM8K-trace.cmp,
output-list time%S1.4.1 address%B1.14.1 in%D1.5.1 load%B2.1.2 out%D1.5.1;

set address 0, set in 211, set load 1,
tick,
tock,
output;   // write 211 to 0

set address 4095, set in 322, set load 1,
tick,
tock,
output;   // write 322 to 4095

set address 4096, set in 433, set load 1,
tick,
tock,
output;   // write 433 to 4096

set address 8191, set in 544, set load 1,
tick,
tock,
output;   // write 544 to 8191

set address 0, set in 0, set load 0,
tick,
tock,
output;   // read 0

set address 4095, set in 0, set load 0,
tick,
tock,
output;   // read 4095

set address 4096, set in 0, set load 0,
tick,
tock,
output;   // read 4096

set address 8191, set in 0, set load 0,
tick,
tock,
output;   // read 8191

set address 4096, set in 0, set load 0,
tick,
tock,
output;   // read 4096
