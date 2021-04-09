# .PHONY: bin
# bin: i686-elf-gcc -T linker.ld -o isodir/unionos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

# .PHONY: iso
# iso: grub-mkrescue -o unionos.iso isodir

# .PHONY: isozip
# isozip: zip -r unionos.zip isodir/unionos.iso