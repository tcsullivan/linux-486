# linux-486

This repo provides the files necessary to build a Linux-based "operating system" for old i486 systems with at least 8MB of RAM. Build scripts for all components of the sysem are provided. An i486-linux toolchain is also built, enabling you to compile other programs for the system.

The generated boot floppy disk provides you with a Busybox system that is kept entirely in memory. uClibc's shared library files are also loaded into memory, allowing other programs to save on memory (as opposed to using static binaries).

A second floppy containing additional kernel modules can also be generated. Both floppies are ext2 formatted.

## Build requirements

* building tools (make, gcc, linux's requirements, etc.)
* bash
* wget
* tar, xz, bzip2

## Build steps

Run the build scripts in this order:

1. `build-toolchain.sh` (after this script, add ~/i486-linux/bin to your PATH)
2. `build-linux.sh`
3. `build-busybox.sh`
4. `build-floppy.sh`
5. `build-modules.sh`

After successful execution of all scripts, you should have `floppy.img` (boot image) and `modules.img` (modules). These can be `dd`'d to a 1.44M 3.5" floppy disk.

## Booting the system

The system requires an i486 or better processor, a 3.5" floppy drive, and at least 8MB of RAM (8320K for QEMU).

Notes:

* Once the system is booted, the floppy disk can be removed.
* root's password is `toor`.
* Mount the modules floppy to `/lib/modules`; then, use `modprobe` for loading and unloading.
* The `msdos` module may need to be loaded to read MS-DOS/FAT floppies.

