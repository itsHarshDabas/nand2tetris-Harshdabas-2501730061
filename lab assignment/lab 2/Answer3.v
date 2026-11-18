// Lab 2 - Q3: RAM8 = DMux8Way(load) + 8 Registers + Mux8Way16(read)
// Trace (all registers r0..r7 after each write):
//   write 11 @0 -> 11 0 0 0 0 0 0 0
//   write 33 @3 -> 11 0 0 33 0 0 0 0
//   write 55 @5 -> 11 0 0 33 0 55 0 0
//   write 77 @7 -> 11 0 0 33 0 55 0 77
//   write 99 @3 -> 11 0 0 99 0 55 0 77

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
