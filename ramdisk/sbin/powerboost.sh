#!/res/busybox sh

export PATH=/res/asset:$PATH

if [ -f /dev/bootdone ] ; then
	if [ "${1}" = "1" ] ; then
		echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
		echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
		echo "performance" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
		echo "performance" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
	fi
	if [ "${1}" = "0" ] ; then
		source /sbin/arteractive.sh
	fi
fi
