# Description

This is a script that is used to generate the gentoo with 
a command line for my liking. There are several methods of 
building the kernel. Using menuconfig is difficult and can 
render some functions of the computer inoperable. It takes a while 
to build one, so the first time to get a great result is 
by using genkernel. 

Using genkernel provides a means at which a solid and expanding 
kernel can be had, in case you update the hardware, The package 
includes kernel settings and several options for building gentoo 
and afterwards installation. I had a much easier time getting
the proper settings with all of my devices by using menuconfig 
alone. Afterall, every driver is specific for your hardware.

After genkernel has been run once, after the system is running you can
retrieve the config file used during compilation. The file is inside
the /proc/.config.gz archive. Using this as a starting point as well
as listing what modules are loaded by your system is accomplished
easily. Essentially obe aspect of my research is to produce 
minimial booting graphic os with specific interfaces. A common
input format allows the program to be ran in multiple modes,
booting graphic, booting text ncurses, and inner desktop application
layers as distinct functional units. Refining the experience of booting
to a selectable partition graphic os - small loading targets for specific functionality
and settings. The menu functions as a gui with animation and sound perhaps as an additional
interest.

The gentoo linux is the system that is used on chrome books and is customizeable. The process
includes building the entire operating system from source code. Lengthy process, using gcc.
The purpose is to increase performance using several methods of system specialization.
I have noticed a signifigant improvment in stability, running applications are very fast.
The system stays responsive while many tasks are topping out the system, and can still launch
apps and integrated them into the process stack. So quick compared to ubuntu, and running 
the desktop environments on them. I used to be turned off by big desktops and stayed to the minimimums.
Now, with gentoo, it is no problem and even faster and better than before. Most people goto linux to have a faster 
and better development expereience from windows. However moving to gentoo from linux is even more satisfying with
gentoo. You can tell immediately that most of wait time after this is the disk drive.
You can even boot to terminal under fifty megs or less with network and links browser.
In the full blown gui gnome desktop environment, web gl games can be played as they are
much faster now. duo core i3 laptop, lol it is a new laptop now. What end users want and what comes
on their system can function much better than consumer distributions supply.

 DARPA also uses it for some drones, servers and image processing I 
believe from my guessings or maybe thats the L4 kernel. The scheduling
and multithreading is very noticible and distributed while allowing
effective control realtime. So, quick. Finally.
Here the kernel is build with options that provide framebuff 
access also which makes such menus and input systems without xserver.
For arcade boxes and embedded devices, I believe this is a great combination
from my understanding thus far. Amazing.

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

## step 5. boot fresh stick and system tools
The ingredients of the software build and other features may differ 
sightly as per your thinking cap
and your needs. However for my understanding, these are the best
for working with c++ projects from scratch. Yet there are endless
focuses within the disicpline such as database, communications, 
algorithm libraries, device interfaces, etc. So after you get the 
system up to a specification, compiled
for a specific hardware cpu as the last processes have done, you can make  a nifty
usb stick as to never undergo the task again and setup with the 
system base. Other parts of the mounted partitions are not included 
like user files and data by default.


The script builds an iso file that can be burned as a bootable
install of the system. Use dd to place it onto a USB stick.

See also:
https://menuconfig.org/


## step 6. offline documentation and web indexing
  Having a knowledge base that is local and searching in a
  index system such as sphinx is a good choice. A
  python based webserver is used for this. Search Page and
  index interface is generated. Thumbnails of documentation, pdf,
  wikibooks, and other downloaded epub content.

## step 6. clonezilla drive backup

clonezilla is a difficult program to describe but one aspect it 
provides is the ability to backup drives as an image for archival purposes.
However, it is an image requireing at most the size of the disk being scanned.
I plopped my 8gig stick in and expected that it would shovel everything onto it.
Ir can, but there are multiple and it requires a large capacity USB stick such as TB.
I am going to try the microsd 1tb for this.
