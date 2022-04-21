#!/bin/bash

cp base.img floppy.img
sudo mount -oloop floppy.img /mnt
sudo chown -R root:root floppy/
sudo rsync -av floppy/ /mnt/
df -h /mnt
sudo umount /mnt
