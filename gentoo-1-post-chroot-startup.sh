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
echo "license software type --> @FREE defaulted
portageq envvar ACCEPT_LICENSE

#time zone and locale generation, The system seems to have one that is not 
#identified yet, but it is related to the size of the characters. For labeling 
# and commonality, english is added and set as the defau;lt. most likely they are the same
# systems, - unknown
echo "US/Arizona" > /etc/timezone
emerge --config sys-libs/timezone-data
echo 'en_US ISO-8859-1\n en_US.UTF-8 UTF-8\n' >> /etc/locale.gen
locale-gen

#select the os profile for gentoo
eselect local list
eselect local set 2
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

# download the kernel sources and configure
emerge --ask sys-kernel/gentoo-sources
ls -l /usr/src/linux
cd /usr/src/linux
make menuconfig
