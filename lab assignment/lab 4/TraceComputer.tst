// Lab 4 Q1/Q2: runs trace.hack on the Computer and prints the internal signals after every tick and tock.
load TraceComputer.hdl,
compare-to TraceComputer.cmp,
output-list time%S1.4.1 reset%B2.1.2 pc%D1.3.1 instr%B1.16.1 loadAOut%B2.1.2 loadDOut%B2.1.2 writeM%B2.1.2 alu%D1.6.1 zrOut%B2.1.2 ngOut%B2.1.2 jumpOut%B2.1.2 aReg%D1.6.1 dReg%D1.6.1 memOut%D1.6.1 RAM16K[0]%D1.4.1;

ROM32K load trace.hack,
eval, output;

repeat 11 {
    tick, output;
    tock, eval, output;
}
