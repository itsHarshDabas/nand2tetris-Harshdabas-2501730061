// Lab 3 Q4: Memory chip (RAM16K + Screen + Keyboard). Checks the three address ranges and their borders.
//   0 .. 16383 = RAM,  16384 .. 24575 = Screen,  24576 = Keyboard (read only, no key pressed = 0)
load Memory.hdl,
compare-to Memory-map.cmp,
output-list time%S1.4.1 in%D1.6.1 load%B2.1.2 address%B1.15.1 out%D1.6.1;

set in 111, set load 1, set address 0,
tick,
tock,
output;   // write 111 to 0

set in 222, set load 1, set address 16383,
tick,
tock,
output;   // write 222 to 16383

set in 333, set load 1, set address 16384,
tick,
tock,
output;   // write 333 to 16384

set in 444, set load 1, set address 24575,
tick,
tock,
output;   // write 444 to 24575

set in 555, set load 1, set address 24576,
tick,
tock,
output;   // write 555 to 24576

set in 0, set load 0, set address 0,
tick,
tock,
output;   // read 0

set in 0, set load 0, set address 16383,
tick,
tock,
output;   // read 16383

set in 0, set load 0, set address 16384,
tick,
tock,
output;   // read 16384

set in 0, set load 0, set address 24575,
tick,
tock,
output;   // read 24575

set in 0, set load 0, set address 24576,
tick,
tock,
output;   // read 24576

set in 0, set load 0, set address 8192,
tick,
tock,
output;   // read 8192

set in 0, set load 0, set address 20000,
tick,
tock,
output;   // read 20000
