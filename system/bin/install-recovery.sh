#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:13584384:b35722d62239c20650da1807dbff8533235f2828; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:13053952:e29c7cf8ca1df60717307b2db4c825533ed6f835 EMMC:/dev/block/bootdevice/by-name/recovery b35722d62239c20650da1807dbff8533235f2828 13584384 e29c7cf8ca1df60717307b2db4c825533ed6f835:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
