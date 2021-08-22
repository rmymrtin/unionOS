rm boot.o kernel.o
i686-elf-as boot.s -o boot.o;
cd kernel
i686-elf-g++ -o kernel.o kernel.cpp gdt.cpp memory.cpp -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti