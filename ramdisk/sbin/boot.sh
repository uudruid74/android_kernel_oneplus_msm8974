#!/res/busybox sh

export PATH=/res/asset:$PATH

echo "0" > /sys/module/intelli_plug/parameters/intelli_plug_active
echo "0" > /sys/module/msm_thermal/core_control/enabled

echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

while ! pgrep com.android ; do
	sleep 1
done

sleep 1

while pgrep bootanimation ; do
	sleep 1
done

value=$(cat /sys/devices/virtual/lcd/panel/panel/auto_brightness)
echo "$value" > /sys/devices/virtual/lcd/panel/panel/auto_brightness

echo "intelliactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "intelliactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "intelliactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "intelliactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_active
echo "1" > /sys/module/msm_thermal/core_control/enabled
