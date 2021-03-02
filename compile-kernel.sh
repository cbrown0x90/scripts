#!/bin/bash

# get relevant kernel versions
#OLDVER=$(eselect kernel list | awk -F "-" '$3 ~ "*" {print $2}')
NEWVER=$(eselect kernel list | tail -1 | sed -n 's/.*linux-\(.*\)\s.*/\1/p')
if [ ${#NEWVER} -gt 0 ]; then
    #OLDVER=$(eselect kernel list | awk -F "-" '$1 ~ "[1]" {print $2}')
    #NEWVER=$(pwd | awk -F "-" '{print $2}')
    #NEWVER=$(eselect kernel list | awk -F "[ -]" '$8 ~ "*" {print $7}')

    # copy old config
    #cp -v /usr/src/linux/.config .config

    # build & install the kernel
    #make -j12
    #make modules_install
    #make install

    # delete the old kernel
    #rm -v /boot/*.old
    #rm -v /boot/*.img
    #rm -v /boot/*$OLDVER
    find /boot -maxdepth 1 -type f -name "*" ! -name "*$NEWVER" ! -name "refind_linux.conf" -exec rm -v {} \;

    # set the new kernel
    #KERNUM=$(eselect kernel list | awk -v ver=$NEWVER '$2 ~ ver {print substr($1, index($1, "[") + 1, index($1, "]") - 2)}')
    #eselect kernel set $KERNUM

    # build an initramfs
    genkernel --xfsprogs --luks --lvm --keymap --install initramfs

    # update refind config
    sed -i "s/initramfs-\S*\.img/initramfs-$NEWVER.img/g" "/boot/refind_linux.conf"

    # rebuild externel kernel modules
    emerge -av --exclude=sys-kernel/gentoo-kernel @module-rebuild
else
    echo "Uhh oh, couldn't find the new version for some reason"
fi
