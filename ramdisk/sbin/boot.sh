#!/system/bin/sh

while ! pgrep com.android ; do
	sleep 1
done

sleep 1

while pgrep bootanimation ; do
	sleep 1
done

value=$(cat /sys/devices/virtual/lcd/panel/panel/auto_brightness)
echo "$value" > /sys/devices/virtual/lcd/panel/panel/auto_brightness

echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_active

echo "intelliactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "intelliactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "intelliactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "intelliactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
