.SUFFIXES:

# A changer
# export PATH := $(shell toolchain/use-it.sh):$(PATH) 

.PHONY: bin
build/unionos.bin: boot.o kernel.o 
	i686-elf-gcc -T linker.ld -o build/boot/unionOS.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

.PHONY: iso
iso: unionos.iso

unionos.iso: build/boot/unionOS.bin
	grub-mkrescue -o unionos.iso isodir

.PHONY: isozip
isozip: zip -r unionOS.zip build/boot/unionOS.iso