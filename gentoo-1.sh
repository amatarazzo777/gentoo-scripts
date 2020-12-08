#!/bin/bash
parted -a optimal /dev/sda mklabel gpt 
parted unit mib mkpart primary 1 3 
parted name 1 grub 
parted set 1 bios_grub on 
parted unit mib mkpart primary 3 131 
parted name 2 boot 
parted unit mib mkpart primary 131 643 
parted name 3 swap 
parted unit mib mkpart primary 643 --1 
parted name 4 rootfs 
parted set 2 boot on 
parted print
mkfs.fat -F 32 /dev/sda2
mkfs.ext4 /dev/sda4
mkswap /dev/sda3
swapon /dev/sda3
mount /dev/sda4 /mnt/gentoo
date
cd /mnt/gentoo
wget https://bouncer.gentoo.org/fetch/root/all/releases/arm64/autobuilds/20201004T190540Z/stage3-arm64-20201004T190540Z.tar.xz
openssl dgst -r -sha512 stage3-arm64-20201004T190540Z.tar.xz
tar xpvf stage3-*.tar.xz --attrs-include='*.*' --numeric-owner
wget https://github.com/amatarazzo777/gentoo-scripts/new/main/make.conf

exit 0

cp make.conf /mnt/gentoo/etc/portage/make.conf
mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf
mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/conf/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm
chmod 1777 /dev/shm
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/sda2 /boot
emerge-webrsync
emerge --sync
eselect profile list
emerge --ask --verbose --update --deep -newuse @world
echo "license software type --> @FREE defaulted
portageq envvar ACCEPT_LICENSE
echo "US/Arizona" > /etc/timezone
emerge --config sys-libs/timezone-data
echo 'en_US ISO-8859-1\n en_US.UTF-8 UTF-8\n' >> /etc/locale.gen
locale-gen
eselect local list
eselect local set 2
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
emerge --ask sys-kernel/gentoo-sources
ls -l /usr/src/linux
cd /usr/src/linux
make menuconfig


