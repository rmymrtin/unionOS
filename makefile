KERNEL := unionOS
KERNEL_DIR = kernel

OCC = i686-elf-as
CC = i686-elf-g++
CFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

LD = i686-elf-gcc
LDFLAGS := \
	-nostdlib \
	-T linker.ld \
	-z max-page-size=0x1000 \

#	:= -T linker.ld -z max-page-size=0x1000\ -nostdlib 

QEMU = qemu-system-x86_64
QEMU_CORES = 2
QEMU_PARAMS_NODEBUG = -no-reboot -vga std -D ./log.txt -d int,guest_errors -m 512M -boot d -M q35  -serial mon:stdio -m 1G -smp $(CORE_NUM) -cdrom
QEMU_PARAMS_DEBUG = -S -gdb tcp::9000

SRCDIRS := $(shell find ./$(KERNEL_DIR) -type d)
CFILES := $(shell find ./$(KERNEL_DIR) -type f -name '*.cpp')
SFILES := $(shell find ./$(KERNEL_DIR) -type f -name '*.s')
OBJ = $(SFILES:%.s=%.o)
OBJ += $(CFILES:%.cpp=%.o)

.PHONY: unionOS.bin unionOS.iso clean

## .S in .O
%.o: %.s
	@$(OCC) -o $@ $<

## .C in .O
%.o: %.c
	@$(CC) -o $@ $(CFLAGS) -c $<

unionOS.bin: $(OBJ)
	@$(LD) $(LDFLAGS) $(OBJ) -o $@

unionOS.iso: 
	@grub-mkrescue -o build/unionOS.iso isodir

clean:
	@rm boot.o kernel.o isodir/boot/unionOS.bin
	@rm -rf -d build