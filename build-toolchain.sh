#!/bin/bash

if [ ! -e ./buildroot-2022.02.1.tar.xz ] ; then
    echo "Fetching buildroot..."
    wget https://buildroot.org/downloads/buildroot-2022.02.1.tar.xz
fi

if [ ! -e ./buildroot-2022.02.1 ] ; then
    echo "Extracting buildroot..."
    tar xf buildroot-2022.02.1.tar.xz

    cp config-buildroot-2022.02.1 buildroot-2022.02.1/.config
    cp config-uclibc buildroot-2022.02.1/config-uclibc
fi

echo "Building with sudo..."
sudo make -C buildroot-2022.02.1 toolchain -j8

echo "Installing i486-linux toolchain to ~ (and adding to PATH)..."
cp -R buildroot-2022.02.1/output/host ~/i486-linux
export PATH=$PATH:~/i486-linux/bin

echo "Copying libc files to the floppy folder..."
mkdir floppy/lib
sudo strip buildroot-2022.02.1/output/target/lib/ld-uClibc-1.0.40.so
sudo strip buildroot-2022.02.1/output/target/lib/libuClibc-1.0.40.so
sudo bash -c "lzma -zc9 buildroot-2022.02.1/output/target/lib/ld-uClibc-1.0.40.so > floppy/lib/lduClibc.lzm"
sudo bash -c "lzma -zc9 buildroot-2022.02.1/output/target/lib/libuClibc-1.0.40.so > floppy/lib/libc.lzm"

