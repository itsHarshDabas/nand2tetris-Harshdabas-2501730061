// Lab 1 - Q3: Half adder and Full adder
// HalfAdder: sum = a xor b, carry = a.b      FullAdder: sum = (a xor b) xor c, carry = a.b + (a xor b).c
// Carry propagation example a=1 b=1 c=1: HA1 -> s1=0, c1=1; HA2 (s1 + c) -> sum=1, c2=0; carry = c1 OR c2 = 1  => 1+1+1 = 11 (binary)

// Adds two bits: sum = a xor b, carry = a and b
CHIP HalfAdder {
    IN a, b;
    OUT sum, carry;
    PARTS:
    Xor(a=a, b=b, out=sum);
    And(a=a, b=b, out=carry);
}

// Adds three bits using two half adders
CHIP FullAdder {
    IN a, b, c;
    OUT sum, carry;
    PARTS:
    HalfAdder(a=a, b=b, sum=s1, carry=c1);
    HalfAdder(a=s1, b=c, sum=sum, carry=c2);
    Or(a=c1, b=c2, out=carry);
}
