nasm -f elf64 test3.asm -test3.lst
ld -o test3 test3.o
./test3
