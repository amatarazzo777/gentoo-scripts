
This is a scripts that is used to generate the gentoo with 
a command line for my liking. The package includes kernel settings and 
several options for building gentoo and afterwards installation.

WARNING: This script results in erasing the computer entire hard disk. All data lost.

The gentoo linux is the system that is used on chrome books and is customizeable. The process
includes building the entire operating system from source code. Lengthy process, using gcc.
The purpose is to increase performance using several methods of system specialization.

Here the kernel is build with options that provide framebuff access. 

The following packages are installed after the base os.

Install the gldrivers, glfw, xorg-xcb, clang, meson.
As well, the following components are built
after setup Skia. 
depot tools.

desktop environmnt, openbox with development setup
  eclipse, 
    color themes, 
    meson build plugin, 
    git, 
    options for setup, 

connecting git commandline to github

software -- install
-------------------
inkscape
audacity
gimp
blender



The usage after burning the usb stick of the gentoo boot minimal cd is as follows. Boot from the usb :<br>

net-setup<br>
wget --no-cache https://raw.githubusercontent.com/amatarazzo777/gentoo-scripts/main/gentoo-1.sh<br>
sh gentoo-1.sh<br>
reboot<br>

Remove the stick when rebooting. The linux terminal shall arise, login with the root password 
add your user account using the <br>


'useradd -m -G users,wheel,audio -s /bin/bash larry' command.<br>


See also:
https://menuconfig.org/

