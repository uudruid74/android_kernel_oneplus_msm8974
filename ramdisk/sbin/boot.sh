#!/res/busybox sh

export PATH=/res/asset:$PATH

echo "0" > /sys/module/intelli_plug/parameters/intelli_plug_active
echo "1" > /sys/module/msm_thermal/core_control/enabled
echo "1" > /sys/devices/system/cpu/cpu1/online
echo "1" > /sys/devices/system/cpu/cpu2/online
echo "1" > /sys/devices/system/cpu/cpu3/online

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

chmod 666 /sys/module/lpm_resources/enable_low_power/l2
chmod 666 /sys/module/lpm_resources/enable_low_power/pxo
chmod 666 /sys/module/lpm_resources/enable_low_power/vdd_dig
chmod 666 /sys/module/lpm_resources/enable_low_power/vdd_mem
chmod 666 /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
chmod 666 /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
chmod 666 /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
chmod 666 /proc/sys/kernel/sched_wake_to_idle
chmod 666 /sys/module/cpubw_krait/parameters/enable
echo "2" > /sys/module/lpm_resources/enable_low_power/l2
echo "1" > /sys/module/lpm_resources/enable_low_power/pxo
echo "1" > /sys/module/lpm_resources/enable_low_power/vdd_dig
echo "1" > /sys/module/lpm_resources/enable_low_power/vdd_mem
echo "1" > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
echo "1" > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
echo "1" > /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
echo "1" > /proc/sys/kernel/sched_wake_to_idle
echo "0" > /sys/module/cpubw_krait/parameters/enable
chmod 444 /sys/module/lpm_resources/enable_low_power/l2
chmod 444 /sys/module/lpm_resources/enable_low_power/pxo
chmod 444 /sys/module/lpm_resources/enable_low_power/vdd_dig
chmod 444 /sys/module/lpm_resources/enable_low_power/vdd_mem
chmod 444 /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
chmod 444 /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
chmod 444 /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
chmod 444 /proc/sys/kernel/sched_wake_to_idle
chmod 444 /sys/module/cpubw_krait/parameters/enable

echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_active

if [[ ! $(cat /sys/devices/i2c.75/i2c-13/13-0066/max77803-charger/power_supply/sec-charger/status) == "Charging" ]] && [[ ! $(cat /sys/devices/i2c.75/i2c-13/13-0066/max77803-charger/power_supply/sec-charger/status) == "Full" ]]; then
	source /sbin/arteractive.sh
else
	echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_nr_run_profile_sel
fi
