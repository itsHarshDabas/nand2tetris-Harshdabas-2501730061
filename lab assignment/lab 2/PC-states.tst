// Lab 2 Q6: PC chip, all 8 combinations of reset, load and inc.
// Before every combination the counter is set to 100 and the input in = 55.
load PC.hdl,
compare-to PC-states.cmp,
output-list time%S1.4.1 reset%B2.1.2 load%B2.1.2 inc%B2.1.2 in%D1.4.1 out%D1.4.1;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 0, set load 0, set inc 0,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 0, set load 0, set inc 1,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 0, set load 1, set inc 0,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 0, set load 1, set inc 1,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 1, set load 0, set inc 0,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 1, set load 0, set inc 1,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 1, set load 1, set inc 0,
tick,
tock,
output;

set in 100, set reset 0, set load 1, set inc 0,
tick,
tock,

set in 55, set reset 1, set load 1, set inc 1,
tick,
tock,
output;
