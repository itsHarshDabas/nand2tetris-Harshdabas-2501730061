// Lab 1, Question 5: all 18 standard Hack ALU operations with x = 12, y = 5.
load ALU.hdl,
compare-to ALU-18.cmp,
output-list x%D1.6.1 y%D1.6.1 zx nx zy ny f no out%D1.6.1 zr ng;

set x 12,
set y 5;

// 0
set zx 1, set nx 0, set zy 1, set ny 0, set f 1, set no 0,
eval,
output;

// 1
set zx 1, set nx 1, set zy 1, set ny 1, set f 1, set no 1,
eval,
output;

// -1
set zx 1, set nx 1, set zy 1, set ny 0, set f 1, set no 0,
eval,
output;

// x
set zx 0, set nx 0, set zy 1, set ny 1, set f 0, set no 0,
eval,
output;

// y
set zx 1, set nx 1, set zy 0, set ny 0, set f 0, set no 0,
eval,
output;

// !x
set zx 0, set nx 0, set zy 1, set ny 1, set f 0, set no 1,
eval,
output;

// !y
set zx 1, set nx 1, set zy 0, set ny 0, set f 0, set no 1,
eval,
output;

// -x
set zx 0, set nx 0, set zy 1, set ny 1, set f 1, set no 1,
eval,
output;

// -y
set zx 1, set nx 1, set zy 0, set ny 0, set f 1, set no 1,
eval,
output;

// x+1
set zx 0, set nx 1, set zy 1, set ny 1, set f 1, set no 1,
eval,
output;

// y+1
set zx 1, set nx 1, set zy 0, set ny 1, set f 1, set no 1,
eval,
output;

// x-1
set zx 0, set nx 0, set zy 1, set ny 1, set f 1, set no 0,
eval,
output;

// y-1
set zx 1, set nx 1, set zy 0, set ny 0, set f 1, set no 0,
eval,
output;

// x+y
set zx 0, set nx 0, set zy 0, set ny 0, set f 1, set no 0,
eval,
output;

// x-y
set zx 0, set nx 1, set zy 0, set ny 0, set f 1, set no 1,
eval,
output;

// y-x
set zx 0, set nx 0, set zy 0, set ny 1, set f 1, set no 1,
eval,
output;

// x&y
set zx 0, set nx 0, set zy 0, set ny 0, set f 0, set no 0,
eval,
output;

// x|y
set zx 0, set nx 1, set zy 0, set ny 1, set f 0, set no 1,
eval,
output;
