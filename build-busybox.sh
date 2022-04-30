#!/bin/bash

if [ ! -e ./busybox-1.20.0.tar.bz2 ] ; then
    echo "Fetching busybox..."
    wget https://www.busybox.net/downloads/busybox-1.20.0.tar.bz2
fi

if [ ! -e ./busybox-1.20.0 ] ; then
    echo "Extracting busybox..."
    tar xf busybox-1.20.0.tar.bz2
    cp config-busybox-1.20.0 busybox-1.20.0/.config
    cd busybox-1.20.0
    patch include/libbb.h < ../busybox/libbb.h.patch
    cd ..
fi

make -C busybox-1.20.0 -j8

lzma -zc9 busybox-1.20.0/busybox > floppy/boot/busyboz
echo "Busybox is now installed to the floppy folder."

