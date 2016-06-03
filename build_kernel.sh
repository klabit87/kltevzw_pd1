#!/bin/bash

export ARCH=arm
export CROSS_COMPILE=$(pwd)/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-


mkdir output

make msm8974_sec_defconfig VARIANT_DEFCONFIG=msm8974pro_sec_klte_vzw_defconfig SELINUX_DEFCONFIG=selinux_defconfig
make -j4

