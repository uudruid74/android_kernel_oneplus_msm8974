#!/bin/bash
if [ "${1}" = "skip" ] ; then
	rm arter97-kernel-hltekor-"$(cat version)".zip 2>/dev/null
	cp boot.img kernelzip/boot.img
	cd kernelzip/
	7z a -mx9 arter97-kernel-hltekor-"$(cat ../version)"-tmp.zip *
	zipalign -v 4 arter97-kernel-hltekor-"$(cat ../version)"-tmp.zip ../arter97-kernel-hltekor-"$(cat ../version)".zip
	rm arter97-kernel-hltekor-"$(cat ../version)"-tmp.zip
	cd ..
	ls -al arter97-kernel-hltekor-"$(cat version)".zip
	exit 0
fi

./build_clean.sh
./build_kernel_hltekor.sh CC='$(CROSS_COMPILE)gcc' "$@" || exit 1

rm arter97-kernel-hltekor-"$(cat version)".zip 2>/dev/null
cp boot.img kernelzip/boot.img
cd kernelzip/
7z a -mx9 arter97-kernel-hltekor-"$(cat ../version)"-tmp.zip *
zipalign -v 4 arter97-kernel-hltekor-"$(cat ../version)"-tmp.zip ../arter97-kernel-hltekor-"$(cat ../version)".zip
rm arter97-kernel-hltekor-"$(cat ../version)"-tmp.zip
cd ..
ls -al arter97-kernel-hltekor-"$(cat version)".zip
