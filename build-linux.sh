#!/bin/bash

if [ ! -e ./linux-5.17.2.tar.xz ] ; then
    echo "Fetching Linux..."
    wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.17.2.tar.xz
fi

if [ ! -e ./linux-5.17.2 ] ; then
    echo "Extracting Linux..."
    tar xf ./linux-5.17.2.tar.xz
    cp config-5.17.2tiny ./linux-5.17.2/.config
    
    cd ./linux-5.17.2
    
    echo "Patching Linux..."
    patch usr/gen_initramfs.sh < ../linux/patches/gen_initramfs.sh.patch
    # TODO: Other patches necessary? They do save some space...
else
    cd ./linux-5.17.2
fi

echo "Creating initramfs file structure..."
sudo rm -rf initrd
mkdir -p initrd/{bin,dev/pts,etc/init.d,lib/modules,mnt,proc,root,run,sys}
cp ../linux/{fstab,group,inittab,passwd} initrd/etc

make -C ../preinit
cp ../preinit/init initrd/init

echo "Calling sudo to create initramfs's /dev/console..."
sudo mknod initrd/dev/console c 5 1

echo "Building Linux..."
make -j8

echo "Calling sudo to copy bzImage to the floppy folder..."
sudo cp arch/x86/boot/bzImage ../floppy/boot/bzImage

