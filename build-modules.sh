#!/bin/bash

echo "Building ./modules/ floppy folder..."

rm -rf ./modules
INSTALL_MOD_PATH=$(pwd)/modules make -C linux-5.17.2 modules_install
mv modules/lib/modules/* modules/
rmdir modules/lib/modules modules/lib
rm modules/5.17.2clyne/{source,build}
find modules/ -type f -name "*.ko" -exec strip --strip-debug {} \;
du -sh ./modules

echo "Creating modules.img..."

dd if=/dev/zero of=modules.img bs=1k count=1440
mkfs.vfat -F 12 modules.img
sudo mount -oloop modules.img /mnt
sudo cp -R modules/* /mnt/
sudo chown root:root /mnt/*
df -h /mnt
sudo umount /mnt

