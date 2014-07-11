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
