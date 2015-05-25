#!/res/busybox sh

export PATH=/res/asset:$PATH

echo "1" > /sys/module/intelli_plug/parameters/intelli_plug_active
echo "1" > /sys/module/msm_thermal/parameters/enabled
echo "0" > /sys/module/msm_thermal/core_control/enabled
echo "1" > /sys/devices/system/cpu/cpu1/online
echo "1" > /sys/devices/system/cpu/cpu2/online
echo "1" > /sys/devices/system/cpu/cpu3/online

source /sbin/cpu.sh
source /sbin/arteractive.sh

DEFAULTPOLLMS=$(cat /sys/module/msm_thermal/parameters/poll_ms)
echo "50" > /sys/module/msm_thermal/parameters/poll_ms

while ! pgrep com.android ; do
	sleep 1
done

sleep 1

while pgrep bootanimation ; do
	sleep 1
done

sleep 1

while pgrep dexopt ; do
	sleep 1
done

echo "1" > /sys/module/msm_thermal/core_control/enabled
echo "$DEFAULTPOLLMS" > /sys/module/msm_thermal/parameters/poll_ms
source /sbin/arteractive.sh

if [ -e /arter97 ] ; then
	fstrim -v /arter97/data
else
	fstrim -v /system
	fstrim -v /cache
	fstrim -v /data
fi

sync

while ! pgrep com.android.systemui ; do
	sleep 1
done

# Special handlings for ViPER4Android
if \ls -d /data/data/*viper4android* 1>/dev/null 2>/dev/null; then
	viperspawntimecount=0
	sleep 5
	# Wait up to 60 seconds to detect ViPER4Android process
	while [[ $viperspawntimecount -le 60 ]]; do
		am startservice com.vipercn.viper4android_v2/.service.ViPER4AndroidService
		if pgrep viper4android; then
			# Treat ViPER4Android process' OOM priority the same as SystemUI
			chown root:root /proc/$(pgrep viper4android)/oom*
			echo $(cat /proc/$(pgrep com.android.systemui)/oom_score_adj) > /proc/$(pgrep viper4android)/oom_score_adj
			break
		fi
		sleep 1
		viperspawntimecount=$(($viperspawntimecount + 1))
	done
fi
