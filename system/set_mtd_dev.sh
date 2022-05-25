#!/bin/sh
# default total_size is 4 MiB, which may be too small for use
# here I set it to 262144 kiB, ie 256 MByte
modprobe mtdram total_size=262144

# /proc/mtd should have an entry mtd0 now
# /dev/mtd0 created automatically
modprobe mtdchar
modprobe mtdblock

# write the image to /dev/mtd0
dd if=/tmp/rootfs.jffs2 of=/dev/mtd0

#mount jffs2
mount -t jffs2 -o ro /dev/mtdblock0 /mnt/jffs2
umount /mnt/jffs2

#卸载之前安装的模块
#umount /mnt/jffs2
#rmmod jffs2 mtdblock mtdchar mtdram mtd_blkdevs mtd

#cramfs 文件系统的安装与此类似.
