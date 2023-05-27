#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Root needed";
    exit
fi
path='/home/lucas/Documentos'
fdisk -l | tee ''${path}'/hardware_specs/fdisk -l'
glxinfo -B | tee ''${path}'/hardware_specs/glxinfo -B'
hwinfo | tee ''${path}'/hardware_specs/hwinfo'
inxi -F | tee ''${path}'/hardware_specs/inxi -F'
lsblk | tee ''${path}'/hardware_specs/lsblk'
lscpu | tee ''${path}'/hardware_specs/lscpu'
lshw | tee ''${path}'/hardware_specs/lshw'
lspci -v | tee ''${path}'/hardware_specs/lspci -v'
lsusb -v | tee ''${path}'/hardware_specs/lsusb -v'
vainfo | tee ''${path}'/hardware_specs/vainfo'
vulkaninfo | tee ''${path}'/hardware_specs/vulkaninfo'
btrfs device usage / | tee ''${path}'/hardware_specs/btrfs device usage'
btrfs filesystem df / | tee ''${path}'/hardware_specs/btrfs filesystem df'
btrfs filesystem show | tee ''${path}'/hardware_specs/btrfs filesystem show'
btrfs filesystem usage / | tee ''${path}'/hardware_specs/btrfs filesystem usage'
mount | tee ''${path}'/hardware_specs/mount'
eix-installed-after -dve0 | tee ''${path}'/hardware_specs/installed_package_list_by_date'


