# linux-486

This repo provides the files necessary to build a Linux-based "operating system" for old i486 systems with at least 8MB of RAM.

The generated single floppy disk image allows you to boot into a Busybox system that is kept entirely in memory, freeing up the floppy disk drive for other disks/data.

The boot process goes:
* GRUB 0.96 boots Linux.
* Linux loads an embedded initramfs with a "preinit" init binary.
* "preinit" mounts the floppy disk, decompresses busybox into the root ramdisk filesystem, then unmounts the floppy.
* busybox runs its own init process, bringing you to a shell.

To test the floppy image with QEMU, provide at least 8320K of RAM.

