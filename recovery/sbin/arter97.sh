#!/sbin/sh

export PATH=/sbin:$PATH

echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_active
echo "1" > /sys/module/msm_thermal/parameters/enabled
echo "1" > /sys/module/msm_thermal/core_control/enabled
echo "1" > /sys/devices/system/cpu/cpu1/online
echo "1" > /sys/devices/system/cpu/cpu2/online
echo "1" > /sys/devices/system/cpu/cpu3/online

source /sbin/cpu.sh
source /sbin/arteractive.sh
