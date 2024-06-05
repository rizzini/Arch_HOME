#!/bin/bash
gvt_g () {
    modprobe -a kvmgt vfio-iommu-type1 mdev kvmfr;
    if mdevctl list; then
        echo 1 | tee /sys/class/mdev_bus/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/devices/$(mdevctl list | awk '{print $1}')/remove;
    fi
    touch /dev/shm/looking-glass;
    chown lucas:kvm /dev/shm/looking-glass;
    chmod 0660 /dev/shm/looking-glass;
    UUID="$(uuidgen)";
    echo "${UUID}" | tee "/sys/class/mdev_bus/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create";
}


export PIPEWIRE_RUNTIME_DIR="/run/user/1000";
if [ "$1" == '-debug' ]; then
    gvt_g
    qemu-system-x86_64 \
                        -enable-kvm \
                        -boot menu=on \
                        -machine q35,vmport=off \
                        -cpu host -smp 4,sockets=1,cores=4,threads=1  -m 4G \
                        -vga none \
                        -device ich9-intel-hda -device hda-micro,audiodev=hda -audiodev pipewire,id=hda,out.name=alsa_output.pci-0000_00_1f.3.analog-stereo \
                       -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/"${UUID}",display=on,x-igd-opregion=on,ramfb=on,driver=vfio-pci-nohotplug  \
                        -display gtk,gl=es \
                        -device ivshmem-plain,memdev=ivshmem,bus=pcie.0 \
                        -object memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=32M \
                        -device virtio-serial-pci \
                        -chardev spicevmc,id=vdagent,name=vdagent \
                        -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
                        -object iothread,id=io1 \
                        -device virtio-blk-pci,drive=disk0,iothread=io1 \
                        -drive if=none,id=disk0,cache=none,format=qcow2,aio=native,file=/mnt/archlinux/@qemu_disks/w10.qcow2 -drive file=/mnt/archlinux/temp_stuff/kubuntu-23.10-desktop-amd64.iso,format=raw,media=cdrom
elif [ "$1" == '-android' ]; then
    qemu-system-x86_64 \
            -name Android \
            -enable-kvm \
            -machine q35 \
            -m 2048 \
            -device usb-host,vendorid=1908,productid=2310 \
            -smp 4 \
            -cpu host \
            -usbdevice tablet \
            -device virtio-vga-gl \
            -display gtk,gl=on,show-cursor=on,show-menubar=off,zoom-to-fit=off \
            -device ich9-intel-hda -device hda-micro,audiodev=hda -audiodev pipewire,id=hda,out.name=alsa_output.pci-0000_00_1f.3.analog-stereo \
            -object iothread,id=io1 \
            -device virtio-blk-pci,drive=disk0,iothread=io1 \
            -drive if=none,id=disk0,cache=none,format=qcow2,aio=native,file=/mnt/archlinux/@qemu_disks/android.qcow2 ;
            #-device qemu-xhci,id=xhci -device usb-host,hostdevice=/dev/bus/usb/'"${webcam[0]}"'/'"${webcam[1]}"'  -netdev bridge,id=hn0,br=android_bridge0 -device virtio-net-pci,netdev=hn0,id=nic1  -audiodev pa,id=pa -audio pa,model=es1370 -nodefaults
else
    gvt_g
    qemu-system-x86_64 \
                        -enable-kvm \
                        -machine q35,vmport=off  \
                        -cpu host -smp 4,sockets=1,cores=4,threads=1  -m 4G \
                        -vga none \
                        -device ich9-intel-hda -device hda-micro,audiodev=hda -audiodev pipewire,id=hda,out.name=alsa_output.pci-0000_00_1f.3.analog-stereo \
                        -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/"${UUID}",display=off,x-igd-opregion=on \
                        -device ivshmem-plain,memdev=ivshmem,bus=pcie.0 \
                        -object memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=32M \
                        -device virtio-serial-pci \
                        -chardev spicevmc,id=vdagent,name=vdagent \
                        -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
                        -spice port=5900,addr=127.0.0.1,disable-ticketing=on \
                        -monitor unix:/run/qemu-monitor,server,nowait \
                        -object iothread,id=io1 \
                        -device virtio-blk-pci,drive=disk0,iothread=io1 \
                        -drive if=none,id=disk0,cache=none,format=qcow2,aio=native,file=/mnt/archlinux/@qemu_disks/w10.qcow2 &
                        sleep 5
                        sudo -u lucas looking-glass-client egl:doubleBuffer spice:audio=no &
                        sleep 5
                        while pgrep -f 'looking-glass-client'; do
                            sleep 1;
                        done
                        echo "system_powerdown" | socat - unix-connect:/run/qemu-monitor
                        while pgrep -f 'qemu-system-x86_64'; do
                            sleep 1;
                        done
fi
echo 1 | tee "${MDEV_DEVICE}/devices/${UUID}/remove"
rm -f /dev/shm/looking-glass
rm -f /run/qemu-monitor

