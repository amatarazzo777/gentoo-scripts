#!/bin/sh

# the environment has changed to chroot user to compile
# the sources from various sources on the internet. This includes
# the emerge gentoo libraries and the modified platform specific kernel
# the kernel is bot uilt in the next stage, the gentoo libraries are
source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/sda2 /boot
emerge-webrsync
emerge --sync
eselect profile list
emerge --ask --verbose --update --deep -newuse @world

#accepts the free software license versitiliy for different types 
#of commercialization using the gentoo
echo "license software type --> @FREE defaulted"
portageq envvar ACCEPT_LICENSE

#time zone and locale generation, The system seems to have one that is not 
#identified yet, but it is related to the size of the characters. For labeling 
# and commonality, english is added and set as the defau;lt. most likely they are the same
# systems, - unknown
echo "US/Arizona" > /etc/timezone
emerge --config sys-libs/timezone-data
cp locale.gen /etc/locale.gen
locale-gen

#select the os profile for gentoo
eselect locale list
eselect locale set en_US.utf8
env-update
source /etc/profile
export PS1="(chroot) ${PS1}"

# download the kernel sources and configure
emerge --ask sys-kernel/gentoo-sources
ls -l /usr/src/linux
cp kernel_config /usr/src/linux/.config
cd /usr/src/linux

# make menuconfig
#the make menuconfig is commented out because the kernel_config file is downloaded from repository
#that is the settings were previously set with the options I like and saved to the internet
#or emailed rather using curl.
make
make modules_install
make install

# as well genkernel can be used which is a loarge build, but builds all devices
# emerge --ask sys-kernel/genkernel
#echo "/dev/sda2	/boot	ext2	defaults	0 2" > /mnt/gentoo/etc/fstab

emerge --ask sys-kernel/linux-firmware

#change the host name
sed -i 's/HOSTNAME="livecd"/HOSTNAME="lenovo"/g' /etc/conf.d/hostname

echo 'dns_domain_lo=\"cppuxnetwork\"' > /etc/conf.d/net

#add networking to the install
emerge --ask --noreplace net-misc/netifrc

echo 'config_eth0="dhcp"' > /etc/conf.d/net 

#setup networking to start at login
cd /etc/init.d
ln -s net.lo net.wlp2s0
rc-update add net.wlp2s0 default

emerge --ask app-admin/sysklogd
rc-update add sysklogd default

emerge --ask net-misc/dhcpcd
emerge --ask net-wireless/iw net-wireless/wpa_supplicant

echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge --ask sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

echo "Before rebooting use 'passwd' command to set the root password."
