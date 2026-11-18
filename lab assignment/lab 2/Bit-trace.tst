// Lab 2 Q1: Bit chip, tick/tock trace. Each step: set inputs, tick (clock rises), tock (clock falls).
load Bit.hdl,
compare-to Bit-trace.cmp,
output-list time%S1.4.1 in%B2.1.2 load%B2.1.2 out%B2.1.2;

set in 1, set load 1,
tick,
output;
tock,
output;

set in 0, set load 0,
tick,
output;
tock,
output;

set in 0, set load 1,
tick,
output;
tock,
output;

set in 1, set load 0,
tick,
output;
tock,
output;

set in 1, set load 1,
tick,
output;
tock,
output;

set in 0, set load 0,
tick,
output;
tock,
output;
