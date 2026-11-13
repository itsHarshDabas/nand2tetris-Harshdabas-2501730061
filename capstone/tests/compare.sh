#!/bin/bash
# Assemble each test program with my assembler and compare with the
# output of the official Nand2Tetris assembler (saved as *.official.hack).
cd "$(dirname "$0")/asm"
for f in Add Max Rect Pong; do
    python3 ../../assembler.py $f.asm $f.hack > /dev/null
    if cmp -s $f.hack $f.official.hack; then
        echo "$f.asm : MATCH ($(wc -l < $f.hack) instructions)"
    else
        echo "$f.asm : DIFFERENT"
    fi
done
