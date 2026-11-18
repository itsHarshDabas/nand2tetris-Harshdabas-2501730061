// Lab 4 Q4: address decoding of the memory map, as the I/O program uses it.
load MemoryView.hdl,
compare-to MemoryView.cmp,
output-list time%S1.4.1 address%B1.15.1 load%B2.1.2 in%D1.6.1 out%D1.6.1 ramSel%B2.1.2 screenSel%B2.1.2 kbdSel%B2.1.2 loadRamOut%B2.1.2 loadScreenOut%B2.1.2;

set address 100, set in 5, set load 1,
tick,
tock,
eval,
output;   // write 5 to 100

set address 16384, set in -1, set load 1,
tick,
tock,
eval,
output;   // write -1 to 16384

set address 16384, set in 0, set load 1,
tick,
tock,
eval,
output;   // write 0 to 16384

set address 24575, set in -1, set load 1,
tick,
tock,
eval,
output;   // write -1 to 24575

set address 24576, set in 0, set load 0,
tick,
tock,
eval,
output;   // read 24576

set address 24576, set in 7, set load 1,
tick,
tock,
eval,
output;   // write 7 to 24576
