// Lab 2 - Q6: Program Counter. Priority: reset > load > inc.
// State transition (counter = 100, in = 55) after one clock:
//   reset load inc -> out
//     0     0    0 -> 100 (hold)
//     0     0    1 -> 101
//     0     1    0 -> 55
//     0     1    1 -> 55  (load wins)
//     1     x    x -> 0   (reset wins)

// Program counter. Priority: reset > load > inc.
// if reset: out=0   else if load: out=in   else if inc: out=out+1   else: out=out
CHIP PC {
    IN in[16], load, inc, reset;
    OUT out[16];
    PARTS:
    Inc16(in=cur, out=plus1);
    Mux16(a=cur, b=plus1, sel=inc, out=o1);
    Mux16(a=o1, b=in, sel=load, out=o2);
    Mux16(a=o2, b=false, sel=reset, out=o3);
    Register(in=o3, load=true, out=cur, out=out);
}
