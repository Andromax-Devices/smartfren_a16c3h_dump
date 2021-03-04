#!/bin/bash

# final version verified bt cta test, DUT mode success.
LOG_TAG="qcom-bt-cta"
LOG_NAME="${0}:"

logi ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}
logi "8x10 BT CTA test exit......"
echo "8x10 BT CTA test exit......"
#btconfig /dev/smd3 reset
echo "8x10 BT exit DUT mode"
logi "8x10 BT exit DUT mode"
