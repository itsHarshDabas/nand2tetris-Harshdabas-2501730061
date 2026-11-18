// Lab 1 - Q2: XOR, Mux, Mux4Way16, DMux
// Xor = a.b' + a'.b     Mux: out = a.sel' + b.sel     DMux: a = in.sel', b = in.sel
// XOR truth table:  00->0  01->1  10->1  11->0
// Mux (a b sel -> out): 000->0 001->0 010->0 011->1 100->1 101->0 110->1 111->1
// DMux (in sel -> a b): 00->10  01->01  10->00  11->00 ... (in=1: sel=0 gives a=1, sel=1 gives b=1; in=0: both 0)

// Xor gate: out = (a and not b) or (not a and b)
CHIP Xor {
    IN a, b;
    OUT out;

    PARTS:
    Not(in=a, out=nota);
    Not(in=b, out=notb);
    And(a=a, b=notb, out=w1);
    And(a=nota, b=b, out=w2);
    Or(a=w1, b=w2, out=out);
}

// 2-way multiplexer: out = a if sel = 0, out = b if sel = 1
// out = (a and not sel) or (b and sel)
CHIP Mux {
    IN a, b, sel;
    OUT out;

    PARTS:
    Not(in=sel, out=notsel);
    And(a=a, b=notsel, out=w1);
    And(a=b, b=sel, out=w2);
    Or(a=w1, b=w2, out=out);
}

// 4-way 16-bit multiplexor: sel 00=a, 01=b, 10=c, 11=d
CHIP Mux4Way16 {
    IN a[16], b[16], c[16], d[16], sel[2];
    OUT out[16];
    PARTS:
    Mux16(a=a, b=b, sel=sel[0], out=ab);
    Mux16(a=c, b=d, sel=sel[0], out=cd);
    Mux16(a=ab, b=cd, sel=sel[1], out=out);
}

// Demultiplexor: {a, b} = {in, 0} if sel = 0, {0, in} if sel = 1
CHIP DMux {
    IN in, sel;
    OUT a, b;

    PARTS:
    Not(in=sel, out=notsel);
    And(a=in, b=notsel, out=a);
    And(a=in, b=sel, out=b);
}
