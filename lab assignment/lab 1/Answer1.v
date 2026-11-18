// Lab 1 - Q1: NOT, AND, OR using only NAND
// NOT = NAND(a,a) -> a'   AND = NAND(NAND(a,b),NAND(a,b)) -> a.b   OR = NAND(a',b') -> a+b

// Not gate built from ONE Nand gate.
// Tie both inputs together: Nand(a, a) = not(a and a) = not a
CHIP Not {
    IN in;
    OUT out;

    PARTS:
    Nand(a=in, b=in, out=out);
}

// And gate built from TWO Nand gates.
// And(a, b) = Not(Nand(a, b)), and Not is a Nand with both inputs tied.
CHIP And {
    IN a, b;
    OUT out;

    PARTS:
    Nand(a=a, b=b, out=nandab);
    Nand(a=nandab, b=nandab, out=out);
}

// Or gate built from THREE Nand gates (De Morgan).
// a or b = not(not a and not b) = Nand(Not a, Not b)
CHIP Or {
    IN a, b;
    OUT out;

    PARTS:
    Nand(a=a, b=a, out=nota);
    Nand(a=b, b=b, out=notb);
    Nand(a=nota, b=notb, out=out);
}
