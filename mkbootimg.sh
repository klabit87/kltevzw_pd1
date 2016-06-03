#variables
FILE=*.zip
function pause(){
   read -p "$*"
}

# check for completed build
if ls arch/arm/boot/zImage && ls arch/arm/boot/zImage-dtb > /dev/null 2>&1;
then
	echo -e "\033[32m Kernel compilation successful."
	pause 'Press [Enter] key to continue...'
	echo "Continuing..."
# make dt.img
scripts/dtbTool -s 2048 -o arch/arm/boot/dt.img -p scripts/dtc/ arch/arm/boot/

# remove old
rm output/mkbootimg_tools/pd1/dt.img
rm output/mkbootimg_tools/pd1/kernel

# copy new
cp arch/arm/boot/dt.img output/mkbootimg_tools/pd1/dt.img
cp arch/arm/boot/zImage output/mkbootimg_tools/pd1/zImage
mv output/mkbootimg_tools/pd1/zImage output/mkbootimg_tools/pd1/kernel
cd output/mkbootimg_tools

# make boot.img
./mkboot pd1 pd1.img
cp pd1.img ..
rm pd1.img
cd ..

# compress to flashable zip
if [ -f $FILE ];
then
    echo "File $FILE exists."
    mv pd1.img boot.img
    echo "Backup to previousbuilds/"
	cp *.zip previousbuilds/
	mv *.zip test.zip
	echo "Adding files to new zip..."
	zip -g test.zip boot.img

	#Name new kernel.zip
	echo "Enter name of new zip: "
	read input_variable
	mv test.zip $input_variable.zip
	echo "$input_variable.zip is ready"
else
    echo "File $FILE does not exist."
    echo "Copying base.zip from base folder."
    cp base/base.zip test.zip
    mv pd1.img boot.img
	cp *.zip previousbuilds/
	mv *.zip test.zip
	echo "Adding files to new zip."
	zip -g test.zip boot.img

	#Name new kernel.zip
	echo "Enter name of new zip: "
	read input_variable
	mv test.zip $input_variable.zip
	echo "$input_variable.zip is ready"
fi

else 
	echo -e "\033[31m Incomplete kernel compilation."
	echo "Your build may have had errors."
	echo "Please try again after you build your kernel again."
	echo " "
	echo " "
	pause 'Press [Enter] key to exit.'

fi