all:
	i486-linux-gcc \
	    -static -nostdlib -nostartfiles -ffreestanding -fno-pic -fno-pie \
	    -Os -ffunction-sections -fdata-sections -Wl,-gc-sections \
	    -Ilinux-headers \
	    init.c -o init
