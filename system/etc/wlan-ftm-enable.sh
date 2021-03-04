#!/bin/bash
LOG_TAG="wifi"
LOG_NAME="${0}:"

logi ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

PID=$(ps |grep ptt_socket_app |dd bs=1 skip=10 count=5)
#logi "ptt_socket_app id:$PID"
logi "v1.1"

#setprop ctl.stop ptt_socket_app
#setprop ctl.stop ptt_ffbm
#kill $PID
#RET=$?
#logi "kill return $RET"


#ptt_socket_app -v -d -f
#logi "setprop ctl.start ptt_ffbm"
#setprop ctl.start ptt_ffbm2
rmmod wlan.ko
logi "wifi driver loading"
insmod /system/lib/modules/pronto/pronto_wlan.ko con_mode=5
#iwpriv wlan0 ftm 1
#logi "iwpriv wlan0 ftm 1"
