#!/bin/bash
if [ "${1}" = "skip" ] ; then
	rm arter97-kernel-n9005-"$(cat version)".zip 2>/dev/null
	cp boot.img kernelzip/boot.img
	cd kernelzip/
	7z a -mx9 arter97-kernel-n9005-"$(cat ../version)"-tmp.zip *
	zipalign -v 4 arter97-kernel-n9005-"$(cat ../version)"-tmp.zip ../arter97-kernel-n9005-"$(cat ../version)".zip
	rm arter97-kernel-n9005-"$(cat ../version)"-tmp.zip
	cd ..
	ls -al arter97-kernel-n9005-"$(cat version)".zip
	exit 0
fi

./build_clean.sh
./build_kernel_n9005.sh CC='$(CROSS_COMPILE)gcc' "$@" || exit 1

rm arter97-kernel-n9005-"$(cat version)".zip 2>/dev/null
cp boot.img kernelzip/boot.img
cd kernelzip/
7z a -mx9 arter97-kernel-n9005-"$(cat ../version)"-tmp.zip *
zipalign -v 4 arter97-kernel-n9005-"$(cat ../version)"-tmp.zip ../arter97-kernel-n9005-"$(cat ../version)".zip
rm arter97-kernel-n9005-"$(cat ../version)"-tmp.zip
cd ..
ls -al arter97-kernel-n9005-"$(cat version)".zip

./build_clean.sh nozip
./build_kernel_n900t.sh CC='$(CROSS_COMPILE)gcc' "$@" || exit 1

rm arter97-kernel-n900t-"$(cat version)".zip 2>/dev/null
cp boot.img kernelzip/boot.img
cd kernelzip/
7z a -mx9 arter97-kernel-n900t-"$(cat ../version)"-tmp.zip *
zipalign -v 4 arter97-kernel-n900t-"$(cat ../version)"-tmp.zip ../arter97-kernel-n900t-"$(cat ../version)".zip
rm arter97-kernel-n900t-"$(cat ../version)"-tmp.zip
cd ..
ls -al arter97-kernel-n900t-"$(cat version)".zip
