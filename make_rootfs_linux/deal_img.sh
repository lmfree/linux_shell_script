#!/bin/bash

#sudo cp -rfp rootfs/*   ubuntu-mount/  &&  sudo umount ubuntu-mount

#对rootfs.img进行检查（ext2、ext3、ext4文件格式），-p表示自动修复，-f表示强制检查
e2fsck -p -f ubuntu.img

#对rootfs.img的大小进行调整，并将实际大小信息同步到内核中。
resize2fs  ubuntu.img


