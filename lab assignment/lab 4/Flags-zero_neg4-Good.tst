// Lab 4 Q3: zero_neg4 on Computer
load Computer.hdl,
compare-to Flags-zero_neg4-Good.cmp,
output-list time%S1.3.1 reset%B2.1.2 pc%D1.3.1 RAM16K[0]%D1.6.1 RAM16K[1]%D1.6.1 RAM16K[2]%D1.6.1;

ROM32K load zero.hack,
set RAM16K[0] -4,
set RAM16K[1] 9,
output;
repeat 20 {
    tick, tock,
}
output;
