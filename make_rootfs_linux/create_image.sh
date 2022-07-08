#!/bin/bash

dd if=/dev/zero of=ubuntu.img bs=1M count=3000

mkfs.ext4 ubuntu.img

sudo mount ubuntu.img ubuntu-mount/

