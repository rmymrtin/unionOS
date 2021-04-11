rm boot.o kernel.o
i686-elf-as boot.s -o boot.o; i686-elf-g++ -c kernel/kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti