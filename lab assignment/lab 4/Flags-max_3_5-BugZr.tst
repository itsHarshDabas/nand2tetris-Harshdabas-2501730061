// Lab 4 Q3: max_3_5 on ComputerBugZr
load ComputerBugZr.hdl,
compare-to Flags-max_3_5-BugZr.cmp,
output-list time%S1.3.1 reset%B2.1.2 pc%D1.3.1 RAM16K[0]%D1.6.1 RAM16K[1]%D1.6.1 RAM16K[2]%D1.6.1;

ROM32K load Max.hack,
set RAM16K[0] 3,
set RAM16K[1] 5,
output;
repeat 20 {
    tick, tock,
}
output;
