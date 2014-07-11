#!/bin/bash
git fetch new

rm -rf drivers/gpu/ion
git checkout new/master -- drivers/gpu/ion
rm -rf drivers/gpu/msm
git checkout new/master -- drivers/gpu/msm
rm -rf drivers/media/platform/msm
git checkout new/master -- drivers/media/platform/msm
rm -rf drivers/video/msm
git checkout new/master -- drivers/video/msm
rm -rf include/media/msm*
git checkout new/master -- include/media/msm*
rm -rf include/linux/msm*vid*
git checkout new/master -- include/linux/msm*vid*
rm -rf include/linux/msm*ion*
git checkout new/master -- include/linux/msm*ion*
rm -rf include/linux/vid*
git checkout new/master -- include/linux/vid*
rm -rf arch/arm/mach-msm/include/mach/ion.h
git checkout new/master -- arch/arm/mach-msm/include/mach/ion.h

git status
