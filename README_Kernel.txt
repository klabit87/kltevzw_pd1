################################################################################
HOW TO BUILD KERNEL FOR SM-G900V_NA_MM_VZW

1. How to Build
	- get Toolchain
	download and install arm-eabi-4.9 toolchain for ARM EABI.
	Extract kernel source and move into the top directory.

	$ ./build_kernel.sh 
	$ make -j64
	
	
2. Output files
	- Kernel : Kernel/arch/arm/boot/zImage
	- module : Kernel/drivers/*/*.ko
	
3. How to Clean	
    $ make clean
	
4. How to make .tar binary for downloading into target.
	- change current directory to Kernel/arch/arm/boot
	- type following command
	$ tar cvf SM-G900V_NA_MM_VZW.tar zImage
#################################################################################