#!/bin/bash

output_directory=/syslevel-squashfs
output_filename=sda.squashfs

echo "/mnt/
/proc/
${outout_directory}
/var/cache
/home/anthony/Downloads
/lost+found
/tmp" >> excludelist

mkdir ${output_directory}
parted /dev/sda unit s print > ${output_directory}/README
echo  >> ${output_directory}/README
lsblk -io name,type,size,fstype,label,uuid /dev/sda >> ${output_directory}/README

mksquashfs / /${output_directory}/sda.squashfs -ef excludelist -no-progress -comp lzo -p 'sda.img f 444 root root sudo dd if=/dev/sda conv=sync,noerror bs=16k status=progress'

echo "Put in destination USB stick for boot recovery and restore"
