all:
	gcc -m32 -march=i486 -mtune=i486 -fno-if-conversion -fno-if-conversion2 \
	    -static -nostdlib -nostartfiles -ffreestanding -fno-pic -fno-pie \
	    -Os -ffunction-sections -fdata-sections -Wl,-gc-sections \
	    -Ilinux-headers \
	    init.c -o init
