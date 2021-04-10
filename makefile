.SUFFIXES:

# A changer
# export PATH := $(shell toolchain/use-it.sh):$(PATH) 

.PHONY: bin
isodir/unionos.bin: boot.o kernel.o 
	i686-elf-gcc -T linker.ld -o isodir/unionos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

.PHONY: iso
iso: unionos.iso

unionos.iso: isodir/unionos.bin
	grub-mkrescue -o unionos.iso isodir

.PHONY: isozip
isozip: zip -r unionos.zip isodir/unionos.iso