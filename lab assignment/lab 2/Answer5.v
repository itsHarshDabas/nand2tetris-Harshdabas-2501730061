// Lab 2 - Q5: RAM512, RAM4K, RAM8K, RAM16K (each = 8 (or 2 / 4) of the previous one; top address bits pick the copy)
// RAM512: addr[6..8] -> RAM64   RAM4K: addr[9..11] -> RAM512   RAM8K: addr[12] -> RAM4K   RAM16K: addr[12..13] -> RAM4K
// Latency (gate-delay model, not measured): read = 1 + 9*levels, write = 3 + 6*levels + 1
//   RAM8 10/10   RAM64 19/16   RAM512 28/22   RAM4K 37/28   RAM8K 40/30   RAM16K 43/32   (read/write)
//   Grows with log(size). In the simulator every size takes 1 clock cycle.

// RAM512: 8 x RAM64. Top 3 address bits pick the part, the rest go inside.
CHIP RAM512 {
    IN in[16], load, address[9];
    OUT out[16];
    PARTS:
    DMux8Way(in=load, sel=address[6..8], a=la, b=lb, c=lc, d=ld, e=le, f=lf, g=lg, h=lh);
    RAM64(in=in, load=la, address=address[0..5], out=oa);
    RAM64(in=in, load=lb, address=address[0..5], out=ob);
    RAM64(in=in, load=lc, address=address[0..5], out=oc);
    RAM64(in=in, load=ld, address=address[0..5], out=od);
    RAM64(in=in, load=le, address=address[0..5], out=oe);
    RAM64(in=in, load=lf, address=address[0..5], out=of);
    RAM64(in=in, load=lg, address=address[0..5], out=og);
    RAM64(in=in, load=lh, address=address[0..5], out=oh);
    Mux8Way16(a=oa, b=ob, c=oc, d=od, e=oe, f=of, g=og, h=oh, sel=address[6..8], out=out);
}

// RAM4K: 8 x RAM512. Top 3 address bits pick the part, the rest go inside.
CHIP RAM4K {
    IN in[16], load, address[12];
    OUT out[16];
    PARTS:
    DMux8Way(in=load, sel=address[9..11], a=la, b=lb, c=lc, d=ld, e=le, f=lf, g=lg, h=lh);
    RAM512(in=in, load=la, address=address[0..8], out=oa);
    RAM512(in=in, load=lb, address=address[0..8], out=ob);
    RAM512(in=in, load=lc, address=address[0..8], out=oc);
    RAM512(in=in, load=ld, address=address[0..8], out=od);
    RAM512(in=in, load=le, address=address[0..8], out=oe);
    RAM512(in=in, load=lf, address=address[0..8], out=of);
    RAM512(in=in, load=lg, address=address[0..8], out=og);
    RAM512(in=in, load=lh, address=address[0..8], out=oh);
    Mux8Way16(a=oa, b=ob, c=oc, d=od, e=oe, f=of, g=og, h=oh, sel=address[9..11], out=out);
}

// 8K memory: 8192 16-bit registers = two RAM4K chips.
// address[12] (the top bit) picks the RAM4K, address[0..11] picks the register inside it.
CHIP RAM8K {
    IN in[16], load, address[13];
    OUT out[16];

    PARTS:
    DMux(in=load, sel=address[12], a=la, b=lb);
    RAM4K(in=in, load=la, address=address[0..11], out=oa);
    RAM4K(in=in, load=lb, address=address[0..11], out=ob);
    Mux16(a=oa, b=ob, sel=address[12], out=out);
}

// RAM16K: 4 x RAM4K. Top 2 address bits pick the RAM4K.
CHIP RAM16K {
    IN in[16], load, address[14];
    OUT out[16];
    PARTS:
    DMux4Way(in=load, sel=address[12..13], a=la, b=lb, c=lc, d=ld);
    RAM4K(in=in, load=la, address=address[0..11], out=oa);
    RAM4K(in=in, load=lb, address=address[0..11], out=ob);
    RAM4K(in=in, load=lc, address=address[0..11], out=oc);
    RAM4K(in=in, load=ld, address=address[0..11], out=od);
    Mux4Way16(a=oa, b=ob, c=oc, d=od, sel=address[12..13], out=out);
}
