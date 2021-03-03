#!/bin/bash

# get the new kernel version
NEWVER=$(eselect kernel list | tail -1 | sed -n 's/.*linux-\(.*\)\s.*/\1/p')
if [ ${#NEWVER} -gt 0 ]; then
    # delete the old kernel
    find /boot -maxdepth 1 -type f -name "*" ! -name "*$NEWVER" ! -name "refind_linux.conf" -exec rm -v {} \;

    # build an initramfs
    genkernel --xfsprogs --luks --lvm --keymap --install initramfs

    # rebuild externel kernel modules
    emerge -av --exclude=sys-kernel/gentoo-kernel @module-rebuild
else
    echo "Uhh oh, couldn't find the new version for some reason"
fi
