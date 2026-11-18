// Lab 4 Q3: Max.hack with RAM[0] = 3, RAM[1] = 5 on the correct CPU. Signals are printed once per cycle.
load TraceComputer.hdl,
compare-to FlagTrace.cmp,
output-list time%S1.4.1 pc%D1.3.1 instr%B1.16.1 alu%D1.6.1 zrOut%B2.1.2 ngOut%B2.1.2 jumpOut%B2.1.2 aReg%D1.6.1 dReg%D1.6.1 RAM16K[2]%D1.4.1;

ROM32K load Max.hack,
set RAM16K[0] 3,
set RAM16K[1] 5,
eval, output;

repeat 14 {
    tick,
    tock, eval, output;
}
