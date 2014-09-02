#!/res/busybox sh

export PATH=/res/asset:$PATH

echo "arteractive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "arteractive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "arteractive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "arteractive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

echo "20000" > /sys/devices/system/cpu/cpufreq/arteractive/timer_rate
echo "20000" > /sys/devices/system/cpu/cpufreq/arteractive/timer_slack
echo "40000" > /sys/devices/system/cpu/cpufreq/arteractive/min_sample_time
echo "1190400" > /sys/devices/system/cpu/cpufreq/arteractive/hispeed_freq
echo "99" > /sys/devices/system/cpu/cpufreq/arteractive/go_hispeed_load
echo "20000 1400000:80000 1500000:40000 1700000:20000" > /sys/devices/system/cpu/cpufreq/arteractive/above_hispeed_delay
echo "85 1400000:90 1700000:95" > /sys/devices/system/cpu/cpufreq/arteractive/target_loads
echo "100000" > /sys/devices/system/cpu/cpufreq/arteractive/sampling_down_factor
