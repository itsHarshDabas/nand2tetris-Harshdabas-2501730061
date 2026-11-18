// Lab 1 - Q5: Hack ALU
// zx: x=0   nx: x=!x   zy: y=0   ny: y=!y   f: 1 -> x+y, 0 -> x&y   no: out=!out   zr: out==0   ng: out<0
// Function table (zx nx zy ny f no):
//   0   101010   1   111111   -1  111010   x   001100   y   110000   !x  001101   !y  110001
//  -x   001111  -y   110011   x+1 011111   y+1 110111   x-1 001110   y-1 110010   x+y 000010
//  x-y  010011  y-x  000111   x&y 000000   x|y 010101
// All 18 pass the simulator (x=12, y=5: e.g. x+y=17, x-y=7, y-x=-7, x&y=4, x|y=13).

// Hack ALU.
// zx: x=0   nx: x=!x   zy: y=0   ny: y=!y
// f:  out = x+y if 1, x&y if 0   no: out=!out
// zr = 1 if out == 0,  ng = 1 if out < 0
CHIP ALU {
    IN x[16], y[16], zx, nx, zy, ny, f, no;
    OUT out[16], zr, ng;
    PARTS:
    // prepare x
    Mux16(a=x, b=false, sel=zx, out=x1);
    Not16(in=x1, out=notx1);
    Mux16(a=x1, b=notx1, sel=nx, out=x2);
    // prepare y
    Mux16(a=y, b=false, sel=zy, out=y1);
    Not16(in=y1, out=noty1);
    Mux16(a=y1, b=noty1, sel=ny, out=y2);
    // compute
    And16(a=x2, b=y2, out=xandy);
    Add16(a=x2, b=y2, out=xplusy);
    Mux16(a=xandy, b=xplusy, sel=f, out=o1);
    // negate output
    Not16(in=o1, out=noto1);
    Mux16(a=o1, b=noto1, sel=no, out=out, out[0..7]=lo, out[8..15]=hi, out[15]=ng);
    // zero flag
    Or8Way(in=lo, out=orlo);
    Or8Way(in=hi, out=orhi);
    Or(a=orlo, b=orhi, out=nz);
    Not(in=nz, out=zr);
}
