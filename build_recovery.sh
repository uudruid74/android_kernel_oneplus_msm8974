#!/bin/bash
export KERNELDIR=`readlink -f .`
export RAMFS_SOURCE=`readlink -f $KERNELDIR/recovery`
export USE_SEC_FIPS_MODE=true

echo "kerneldir = $KERNELDIR"
echo "ramfs_source = $RAMFS_SOURCE"

RAMFS_TMP="/tmp/arter97-ks01lte-recovery"

echo "ramfs_tmp = $RAMFS_TMP"
cd $KERNELDIR

if [ "${1}" = "skip" ] ; then
	echo "Skipping Compilation"
else
	echo "Compiling kernel"
	cp defconfig .config
scripts/configcleaner "
CONFIG_SEC_LOCALE_KOR
CONFIG_MACH_KS01EUR
CONFIG_EXTRA_FIRMWARE
CONFIG_EXTRA_FIRMWARE_DIR
CONFIG_TDMB
CONFIG_SEC_DEVIDE_RINGTONE_GAIN
CONFIG_WLAN_REGION_CODE
CONFIG_IIO
"
	echo '
# CONFIG_SEC_LOCALE_KOR is not set
CONFIG_MACH_KS01EUR=y
CONFIG_EXTRA_FIRMWARE="audience-es325-fw-KS01-eur.bin"
CONFIG_EXTRA_FIRMWARE_DIR="firmware"
# CONFIG_TDMB is not set
# CONFIG_SEC_DEVIDE_RINGTONE_GAIN is not set
CONFIG_WLAN_REGION_CODE=100
CONFIG_IIO=y
CONFIG_IIO_ST_HWMON=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_SW_RING is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16204 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADIS16220 is not set
# CONFIG_ADIS16240 is not set
# CONFIG_KXSD9 is not set
# CONFIG_LIS3L02DQ is not set
# CONFIG_SCA3000 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7606 is not set
# CONFIG_AD799X is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_ADT7310 is not set
# CONFIG_ADT7410 is not set
# CONFIG_AD7280 is not set
# CONFIG_MAX1363 is not set
# CONFIG_ADT7316 is not set
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
# CONFIG_AD7746 is not set
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD5686 is not set
# CONFIG_MAX517 is not set
# CONFIG_AD5930 is not set
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# CONFIG_AD9850 is not set
# CONFIG_AD9852 is not set
# CONFIG_AD9910 is not set
# CONFIG_AD9951 is not set
# CONFIG_ADIS16060 is not set
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_AD5933 is not set
# CONFIG_ADIS16400 is not set
# CONFIG_INV_MPU_IIO is not set
# CONFIG_SENSORS_GP2A_IIO is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_SENSORS_HMC5843 is not set
# CONFIG_ADE7753 is not set
# CONFIG_ADE7754 is not set
# CONFIG_ADE7758 is not set
# CONFIG_ADE7759 is not set
# CONFIG_ADE7854 is not set
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# CONFIG_AD2S1210 is not set
# CONFIG_IIO_PERIODIC_RTC_TRIGGER is not set
# CONFIG_IIO_GPIO_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# CONFIG_SENSORS_ASP01_IIO is not set
# CONFIG_IIO_SIMPLE_DUMMY is not set
' >> .config
	make oldconfig
	sed -i -e 's/config->fsg.luns\[0\].cdrom = 1;/config->fsg.luns\[0\].cdrom = 0;/g' drivers/usb/gadget/android.c
	make "$@" || exit 1
	git checkout drivers/usb/gadget/android.c
fi

echo "Building new ramdisk"
#remove previous ramfs files
rm -rf '$RAMFS_TMP'*
rm -rf $RAMFS_TMP
rm -rf $RAMFS_TMP.cpio
#copy ramfs files to tmp directory
cp -ax $RAMFS_SOURCE $RAMFS_TMP
cd $RAMFS_TMP

find . -name '*.sh' -exec chmod 755 {} \;

$KERNELDIR/ramdisk_fix_permissions.sh 2>/dev/null

#clear git repositories in ramfs
find . -name .git -exec rm -rf {} \;
find . -name EMPTY_DIRECTORY -exec rm -rf {} \;
cd $KERNELDIR
rm -rf $RAMFS_TMP/tmp/*

cd $RAMFS_TMP
find . | fakeroot cpio -H newc -o | lzop -9 > $RAMFS_TMP.cpio.lzo
ls -lh $RAMFS_TMP.cpio.lzo
cd $KERNELDIR

echo "Making new boot image"
gcc -w -s -pipe -O2 -o tools/dtbtool/dtbtool tools/dtbtool/dtbtool.c
tools/dtbtool/dtbtool -s 2048 -o arch/arm/boot/dt.img -p scripts/dtc/ arch/arm/boot/
gcc -w -s -pipe -O2 -Itools/libmincrypt -o tools/mkbootimg/mkbootimg tools/libmincrypt/*.c tools/mkbootimg/mkbootimg.c
tools/mkbootimg/mkbootimg --kernel $KERNELDIR/arch/arm/boot/zImage --dt $KERNELDIR/arch/arm/boot/dt.img --ramdisk $RAMFS_TMP.cpio.lzo --cmdline 'console=null androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 enforcing=0' --base 0x00000000 --pagesize 2048 --kernel_offset 0x00008000 --ramdisk_offset 0x02000000 --tags_offset 0x01e00000 --second_offset 0x00f00000 -o $KERNELDIR/recovery.img
echo -n "SEANDROIDENFORCE" >> recovery.img
if [ "${1}" = "CC=\$(CROSS_COMPILE)gcc" ] ; then
	dd if=/dev/zero bs=$((20971520-$(stat -c %s recovery.img))) count=1 >> recovery.img
fi

echo "done"
ls -al recovery.img
echo ""
