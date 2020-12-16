# Description

This is a script that is used to generate the gentoo with 
a command line for my liking. There are several methods of 
building the kernel. Using menuconfig is difficult and can 
render some functions of the computer inoperable. It takes a while 
to build one, so the first time to get a great result is 
by using genkernel. 

Using genkernel provides a means at which a solid and expanding 
kernel can be had, in case you update the hardware, The package includes kernel settings and 
several options for building gentoo and afterwards installation.

The gentoo linux is the system that is used on chrome books and is customizeable. The process
includes building the entire operating system from source code. Lengthy process, using gcc.
The purpose is to increase performance using several methods of system specialization.

Here the kernel is build with options that provide framebuff access. 


# Usage

WARNING: This script results in erasing the computer entire hard disk. All data lost.


## step 1. base command console system with networking.
The usage after burning the usb stick of the gentoo boot minimal cd is as follows. Boot from the usb :<br>

net-setup<br>
wget --no-cache https://raw.githubusercontent.com/amatarazzo777/gentoo-scripts/main/gentoo-1.sh<br>
sh gentoo-1.sh<br>
reboot<br>

Remove the stick when rebooting. The linux terminal shall arise, login with the root password 
add your user account using the <br>


'useradd -m -G users,wheel,audio -s /bin/bash larry' command.<br>


## step 2. gnome desktop environment

The following packages are installed after the base os.


gnome desktop environmnt
  gnome applications
  pulseaudio
  bluez
  
  extensions
    Add on desktop
    animation tweaks
    cpufreq
    desktop editor
    desktop icons
    floating dock
    gnomestatspro
    hide top bar
    sound input and device chooser
    tweaks in the system menu
    
   configure extensions
    Places Status indicator
    removable drive menu

## step 3. c++ development environment setup

development setup
  eclipse, 
    color themes, 
    meson build plugin, 
    git, 
    options for setup, 
    
compile base

build-essential
gldrivers
glfw
xorg-xcb
clang
meson

As well, the following components are built
after setup 

Skia
depot tools

connecting git commandline to github

## step 4. software packages
software -- install
-------------------
inkscape
audacity
gimp
blender
vim
geany
chrome
archive manager
unzip
7zip





See also:
https://menuconfig.org/

