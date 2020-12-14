#!/bin/bash

#create partitions, the sizes are from the example gentoo
parted -s -a optimal /dev/sda \
  mklabel gpt \
  unit mib \
  mkpart primary 1 3 \
  name 1 grub \
  set 1 bios_grub on \
  mkpart primary 3MB 131MB \
  name 2 boot \
  mkpart primary 131MB 643MB \
  name 3 swap \
  mkpart primary 643 1000GB \
  name 4 rootfs  \
  set 2 boot on

#the file systems are set for UEFI therefore 3 has to be fat32
mkfs.fat -F 32 /dev/sda2
mkfs.ext4 -F -F /dev/sda4
mkswap /dev/sda3
swapon /dev/sda3
parted -s /dev/sda unit mib print

#mount file system of storafe partition, ext4 and download stage 3
mount /dev/sda4 /mnt/gentoo
date
cd /mnt/gentoo
wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20201206T214503Z/stage3-amd64-20201206T214503Z.tar.xz
openssl dgst -r -sha512 sstage3-amd64-20201206T214503Z.tar.xz
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

#download configuration make files, post chroot startup and kernel build settings
wget https://raw.githubusercontent.com/amatarazzo777/gentoo-scripts/main/gentoo-1-post-chroot-startup.sh
wget https://raw.githubusercontent.com/amatarazzo777/gentoo-scripts/main/kernel_config

# place settings into appropiate positions within the build tree
sed -i 's/COMMON_FLAGS="/COMMON_FLAGS="--march=native' /mnt/gentoo/etc/portage/make.conf
echo "MAKEOPTS=\"-j4\"" > /mnt/gentoo/etc/portage/make.conf

echo "GENTOO_MIRRORS=\"http://gentoo.cs.utah.edu\""
#mirror is set to utah.edu so skips ui selection of fast mirrors
# mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf

mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

#kernel profile compilation flags
cp kernel_config /mnt/gentoo/usr/src/linux/.config

#mount system folders
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

#test shared memory usage as a drive, needed
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm
chmod 1777 /dev/shm

#kick off next part of building and kernel selections
chroot /mnt/gentoo /bin/bash -c "sh gentoo-1-post-chroot-startup_auto_genkernel.sh"

umount -R /mnt/gentoo

echo "======================finshed"
echo "
  Now you may us the 'reboot' command. And remove the USB stick."
echo "and after rebooting, add your user account using the 
'useradd -m -G users,wheel,audio -s /bin/bash larry' command. You will log in as root."
