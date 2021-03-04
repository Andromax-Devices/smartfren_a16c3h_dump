#!/system/bin/sh
# Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
#
boot_cust_mode=`cat /sys/class/android_usb/android0/usb_mode`
case "$boot_cust_mode" in
    "0") # ynn modify for user mode
		echo "boot_cust_mode is 0 user mode!"
		setprop sys.usb.mtp               2492
		setprop sys.usb.mtp_adb           2491
		setprop sys.usb.ptp               2494
		setprop sys.usb.ptp_adb           2493
		setprop sys.usb.massstorage       2496
		setprop sys.usb.massstorage_adb   2495
		setprop sys.usb.rndis             2498
		setprop sys.usb.rndis_adb         2497
		setprop sys.usb.diag              2499
		setprop sys.usb.diag_adb          249A
		setprop sys.usb.single_adb        249B
		setprop sys.usb.smd               249C
		setprop sys.usb.smd_adb           249D
        ;;
    *)
		echo "boot_cust_mode is 1 test mode!"     
		setprop sys.usb.mtp               F003
		setprop sys.usb.mtp_adb           9039
		setprop sys.usb.ptp               904D
		setprop sys.usb.ptp_adb           904E
		setprop sys.usb.massstorage       F000
		setprop sys.usb.massstorage_adb   9015
		setprop sys.usb.rndis             F00E
		setprop sys.usb.rndis_adb         9024
		setprop sys.usb.diag              901C
		setprop sys.usb.diag_adb          901D
		setprop sys.usb.single_adb        D002
		setprop sys.usb.smd               228C
		setprop sys.usb.smd_adb           228D
        ;;
esac
