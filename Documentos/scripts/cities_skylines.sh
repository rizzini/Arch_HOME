#!/bin/bash
sysctl vm.swappiness=180;
sysctl vm.watermark_boost_factor=0;
sysctl vm.watermark_scale_factor=125;
sysctl vm.page-cluster=0;
sudo -u lucas /mnt/archlinux/Games/Cities.Skylines-jc141/files/groot/Cities.x64 &> /dev/null;
sysctl vm.swappiness=60;
sysctl vm.watermark_boost_factor=0;
sysctl vm.watermark_scale_factor=10;
sysctl vm.page-cluster=0;
