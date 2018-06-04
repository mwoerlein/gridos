CC = g++
CFLAGS = -fno-rtti -fno-exceptions -fno-pie -m32 -I.

multiboot2.kernel: boot.o kernel.o
	echo "creating $@"
	ld -s --oformat binary -Ttext 0x60000 -m elf_i386 -o $@ boot.o kernel.o

%.o: %.c
	$(CC) $(CFLAGS) -c $<
        
%.o: %.S
	$(CC) $(CFLAGS) -c $<
