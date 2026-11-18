// Lab 1, Question 4: Add16 tested with sample 16-bit inputs.
// Expected results were computed with an independent Python model.
load Add16.hdl,
compare-to Add16-samples.cmp,
output-list a%B1.16.1 b%B1.16.1 out%B1.16.1;

set a %B0000000000000101,
set b %B0000000000000011,
eval,
output;   // 5 + 3

set a %B0000000000000111,
set b %B0000000000000001,
eval,
output;   // 7 + 1: the carry ripples through bits 0, 1 and 2

set a %B0111111111111111,
set b %B0000000000000001,
eval,
output;   // 32767 + 1: overflow, the result wraps to -32768

set a %B1111111111111111,
set b %B0000000000000001,
eval,
output;   // -1 + 1: the carry out of bit 15 is dropped, result 0

set a %B1111111111111011,
set b %B0000000000000011,
eval,
output;   // -5 + 3 = -2 (two's complement)
