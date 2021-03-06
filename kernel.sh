#!/bin/bash

# Command Line
CONFIG=$1

# How can this be automatic?
BASE_VARIANT="3.xx"

# Naming
VARIANT="${BASE_VARIANT}${CONFIG}"


# Set some variables
HOSTNAME=`hostname`

if [[ $USER == 'root' && $HOSTNAME == 'navi2' ]]; then
	export CROSS_COMPILE=/opt/android/arm-eabi-4.8/bin/arm-eabi-
	USER=uudruid74
	HOSTNAME="eddon.systems"
	WORK=~/new
	DESTDIR=/var/www/${HOSTNAME}/htdocs/Download/
else
	export CROSS_COMPILE=/opt/android/arm-eabi-4.8/bin/arm-eabi-
	WORK=~/new
	DESTDIR=/www/devs/jgcaap/oneplus/kernel
	if [[ $USER == 'root' ]]; then
		USER='jgcaap'
	fi
fi

# Bash Color
if [[ -n $TERM ]]; then
# We know the terminal type, be portable!
	red=$( tput setaf 1 )
	green=$( tput setaf 2 )
	yellow=$( tput setaf 3 )
	blue=$( tput setaf 4 )
	restore=$( tput sgr0 )
	magenta=$( tput setaf 5 )
    # Xterms don't blink
	blink_red="$magenta"
else
# Don't know what kind of terminal it is
green=''
red=''
blink_red=''
restore=" "		# May or may not work
fi

clear

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="zImage"
DTBIMAGE="dtb"
DEFCONFIG="cyanogenmod_bacon${CONFIG}_defconfig"

# Kernel Details
BASE_AK_VER="0.1"
VER=".CM12.1"
AK_VER="$BASE_AK_VER$VER"

# Vars

export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER=$USER
export KBUILD_BUILD_HOST=`hostname`

# Paths
KERNEL_DIR=`pwd`
REPACK_DIR="${HOME}/new/anykernel"
PATCH_DIR="${HOME}/new/anykernel"
MODULES_DIR="${HOME}/new/modules"
ZIP_MOVE="${HOME}/new/out"
ZIMAGE_DIR="arch/arm/boot"

# Functions
function clean_all {
		rm -rf $MODULES_DIR/*
		cd $REPACK_DIR
		rm -rf $KERNEL
		rm -rf $DTBIMAGE
		cd $KERNEL_DIR
		echo
		make clean && make mrproper
}

function make_kernel {
		echo
		make $DEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $REPACK_DIR
}

function make_modules {
		rm `echo $MODULES_DIR"/*"`
		find $KERNEL_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
}

function make_dtb {
		dtbToolCM -2 -o ${WORK}/anykernel/dtb -s 2048 -p ${WORK}/kernel/scripts/dtc/ ${WORK}/kernel/arch/arm/boot/
}

function make_zip {
		cd $REPACK_DIR
		zip -r9 newKernel-CM12-"$VARIANT".zip *
		mv newKernel-CM12-"$VARIANT".zip $ZIP_MOVE
		cd $KERNEL_DIR
}


DATE_START=$(date +"%s")

echo -e "${green}"
echo "New Kernel Creation Script:"
echo -e "${restore}"

if [[ -z $CONFIG ]]; then
	CONFIG="def"
	echo "${magenta}Using default config.  Specify 'bfs' for BFS Scheduler${restore}"
else
	echo "${magenta}Using $CONFIG config!  ${red}Hope it works!${restore}"
fi

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_kernel
		make_dtb
		make_modules
		make_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo -e "${green}"
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

# Place files and generate md5
mv ${WORK}/out/newKernel-CM12-${VARIANT}.zip ${DESTDIR}/newKernel-CM13.0-${VARIANT}.zip
md5sum ${DESTDIR}/newKernel-CM13.0-${VARIANT}.zip >${DESTDIR}/newKernel-CM13.0-${VARIANT}.zip.md5


