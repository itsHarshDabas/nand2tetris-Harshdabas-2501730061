// Lab 4 - Q5: Hack toolchain vs real C toolchain
// Hack: Prog.jack -> compiler -> .vm -> VM translator -> .asm -> ASSEMBLER -> .hack -> LOADER (IDE copies words into ROM32K) -> CPU
// C:    prog.c -> compiler -> prog.s -> ASSEMBLER -> prog.o (object: machine code + symbol table + relocations)
//          -> LINKER (joins .o files + libc, resolves symbols, applies relocations) -> ELF executable
//          -> LOADER (OS execve: maps segments into virtual memory, sets up stack, ld.so loads shared libs) -> process
// Differences:
//   Assembler: Hack gives final addresses directly; real assembler makes relocatable object files.
//   Linker: Hack has none (VM translator merges everything into one .asm); C needs one to combine files/libraries.
//   Loader: Hack just copies words into ROM at address 0; OS loader uses virtual memory, permissions, dynamic libraries.
//   Format: Hack = text of 16-bit words; C = ELF with headers/sections/symbols.
// Security:
//   Hack: code is in ROM (cannot be injected) but RAM has no protection/bounds, so overflows can overwrite data/return addresses.
//   Real: NX/W^X, ASLR (loader), stack canaries (compiler), RELRO (linker). Linker/loader attack points: LD_PRELOAD / library path
//   hijacking, vulnerable static libraries, supply-chain attacks on the toolchain.
