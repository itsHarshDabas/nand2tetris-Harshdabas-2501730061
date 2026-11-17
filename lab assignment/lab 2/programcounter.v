CHIP PC {
    IN in[16], inc, load, reset;
    OUT out[16];
    PARTS:
    Inc16(in=prev, out=incd);
    Mux16(a=prev, b=incd, sel=inc,   out=o1);
    Mux16(a=o1,   b=in,   sel=load,  out=o2);
    Mux16(a=o2,   b=false, sel=reset, out=o3);
    Register(in=o3, load=true, out=out, out=prev);
}
