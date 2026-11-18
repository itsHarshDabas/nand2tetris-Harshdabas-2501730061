// Lab 2 - Q4: RAM64 = 8 x RAM8. 6-bit address = [high 3 bits: which RAM8][low 3 bits: register inside]
// e.g. address 38 = 100 110 -> RAM8 number 4, register 6.   address 9 = 001 001 -> RAM8 #1, register 1.

// RAM8: 8 registers. address picks which register is read / written.
CHIP RAM8 {
    IN in[16], load, address[3];
    OUT out[16];
    PARTS:
    DMux8Way(in=load, sel=address, a=la, b=lb, c=lc, d=ld, e=le, f=lf, g=lg, h=lh);
    Register(in=in, load=la, out=oa);
    Register(in=in, load=lb, out=ob);
    Register(in=in, load=lc, out=oc);
    Register(in=in, load=ld, out=od);
    Register(in=in, load=le, out=oe);
    Register(in=in, load=lf, out=of);
    Register(in=in, load=lg, out=og);
    Register(in=in, load=lh, out=oh);
    Mux8Way16(a=oa, b=ob, c=oc, d=od, e=oe, f=of, g=og, h=oh, sel=address, out=out);
}

// RAM64: 8 x RAM8. Top 3 address bits pick the part, the rest go inside.
CHIP RAM64 {
    IN in[16], load, address[6];
    OUT out[16];
    PARTS:
    DMux8Way(in=load, sel=address[3..5], a=la, b=lb, c=lc, d=ld, e=le, f=lf, g=lg, h=lh);
    RAM8(in=in, load=la, address=address[0..2], out=oa);
    RAM8(in=in, load=lb, address=address[0..2], out=ob);
    RAM8(in=in, load=lc, address=address[0..2], out=oc);
    RAM8(in=in, load=ld, address=address[0..2], out=od);
    RAM8(in=in, load=le, address=address[0..2], out=oe);
    RAM8(in=in, load=lf, address=address[0..2], out=of);
    RAM8(in=in, load=lg, address=address[0..2], out=og);
    RAM8(in=in, load=lh, address=address[0..2], out=oh);
    Mux8Way16(a=oa, b=ob, c=oc, d=od, e=oe, f=of, g=og, h=oh, sel=address[3..5], out=out);
}
