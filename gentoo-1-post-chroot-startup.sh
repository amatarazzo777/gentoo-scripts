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
eselect locale set en_US.UTF8
env-update
source /etc/profile
export PS1="(chroot) ${PS1}"

# download the kernel sources and configure
emerge sys-kernel/gentoo-sources
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
emerge --noreplace net-misc/netifrc

echo 'modules="wpa_supplicant"' > /etc/conf.d/net 
echo 'config_eth0="dhcp"' > /etc/conf.d/net 


#setup networking to start at login
cd /etc/init.d
ln -s net.lo net.wlp2s0
rc-update add net.wlp2s0 default

emerge app-admin/sysklogd
rc-update add sysklogd default

emerge net-misc/dhcpcd
emerge net-wireless/iw 
emerge net-wireless/wpa_supplicant

ctrl_interface=/var/run/wpa_supplicant
  
mkdir /etc/wpa_supplicant

read -p "Enter the default network SSID: " ssid
read -p "Enter the password for it: " password_ssid

echo '
# Ensure that only root can read the WPA configuration
ctrl_interface_group=0
  
# Let wpa_supplicant take care of scanning and AP selection
ap_scan=1
  
# Simple case: WPA-PSK, PSK as an ASCII passphrase, allow all valid ciphers
network={
  ssid="${ssid}"
  psk="${ssid_password"
  # The higher the priority the sooner we are matched
  priority=5
}' > /etc/wpa_supplicant/wpa_supplicant.conf

echo 'Not enter the root pass for the system. You must remember this password.'
passwd



echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
