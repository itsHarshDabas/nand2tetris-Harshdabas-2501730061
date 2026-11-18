// Lab 2 - Q1: Bit chip (1 DFF + Mux). load=1: stores in. load=0: keeps old value.
// Tick-tock trace: (in=1,load=1) tick: out still 0, tock: out=1 | (in=0,load=0) out stays 1 | (in=0,load=1) out=0

// 1-bit register: if load, out(t+1) = in(t), else out(t+1) = out(t)
CHIP Bit {
    IN in, load;
    OUT out;
    PARTS:
    Mux(a=dout, b=in, sel=load, out=d);
    DFF(in=d, out=dout, out=out);
}
