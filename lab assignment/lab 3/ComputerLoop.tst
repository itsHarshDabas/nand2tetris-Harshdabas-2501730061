// Lab 3 Q4 (extra ROM): the Computer chip runs my loop.hack (R1 = 1 + 2 + ... + R0).
// R0 = 5, so the program must leave 15 in RAM[1] (the variables are n = RAM[16], sum = RAM[17], i = RAM[18]).
load Computer.hdl,
compare-to ComputerLoop.cmp,
output-list time%S1.3.1 reset%B2.1.2 ARegister[]%D1.7.1 DRegister[]%D1.7.1 PC[]%D0.4.0 RAM16K[0]%D1.7.1 RAM16K[1]%D1.7.1 RAM16K[16]%D1.7.1 RAM16K[17]%D1.7.1 RAM16K[18]%D1.7.1;

ROM32K load loop.hack,
set RAM16K[0] 5,
output;

repeat 10 {
    tick, tock, output;
}
repeat 80 {
    tick, tock,
}
output;
