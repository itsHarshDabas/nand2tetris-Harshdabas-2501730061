// Lab 2 Q2: 16-bit Register with sample inputs.
load Register.hdl,
compare-to Register-samples.cmp,
output-list time%S1.4.1 in%D1.6.1 load%B2.1.2 out%D1.6.1;

set in 12345, set load 1,
tick,
output;
tock,
output;

set in -1, set load 0,
tick,
output;
tock,
output;

set in -1234, set load 1,
tick,
output;
tock,
output;

set in 32767, set load 1,
tick,
output;
tock,
output;

set in 5, set load 0,
tick,
output;
tock,
output;
