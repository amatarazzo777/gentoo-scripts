#!/bin/sh
clear
echo "==============================[kernel config]===="
echo "After selecting so many options, you can save it by emailing it to yourself."
echo "Then the next time you build gentoo, you can incorporate the settings by "
echo "pasteing into the kernel_config file. These settings will be persistent when "
echo "the gentoo-1.sh script is ran if you change that file."
echo "Also note that in order for curl commands to work with the gmail system,"
echo "you must go into your google account settings->security and turn on \"less secure apps access\""
read -p "Enter email to send kernel_config to: " kernel_email
read -p "Enter the password for email: " password_email

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
emerge --verbose --update --deep --newuse @world

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

make menuconfig

cp /usr/src/linux/.config kernel_config

curl --ssl-reqd \
  --url 'smtps://smtp.gmail.com:465' \
  --user '${kernel_email}:${password_email}' \
  --mail-from '${kernel_email}' \
  --mail-rcpt '${kernel_email}' \
  --upload-file kernel_config
  
#the make menuconfig ishere to allow lasr minute editing befoer building. 
# the kernel_config file is downloaded from repository
#that is the settings were previously set with the options I like and saved to the internet
#or emailed rather using curl. Make sure you have your wireless drivers selected.
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

#add networking wireless wpa to the install
emerge --noreplace net-misc/netifrc

emerge app-admin/sysklogd
rc-update add sysklogd default

emerge net-misc/dhcpcd
emerge net-wireless/iw 
emerge net-wireless/wpa_supplicant

#setup network to login to when starting
cp /etc/conf.d/net /mnt/gentoo/etc/conf.d/net
mkdir /mnt/gentoo/etc/wpa_supplicant
cp /etc/wpa_supplicant/wpa_supplicant.conf /mnt/gentoo/erc/wpa_supplicant/wpa_supplicant.conf

echo 'modules_${iface}="wpa_supplicant"' > /etc/conf.d/net
echo 'wpa_supplicant_${iface}="-Dnl80211,wext"' > /etc/conf.d/net 

echo 'config_${iface}="dhcp"' > /etc/conf.d/net 

#setup networking to start at login
cd /etc/init.d
ln -s net.lo net.${iface}
rc-update add net.${iface} default

#root password set--
echo "======================================[SYSTEM ROOT PASSWORD]============"
echo 'Enter the root pass for the system. You must remember this password.'
passwd

#setup boot foe efi using grub
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
