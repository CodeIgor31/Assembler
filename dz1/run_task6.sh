nasm -f elf64 dz.asm -dz.lst
ld -o dz dz.o
./dz
