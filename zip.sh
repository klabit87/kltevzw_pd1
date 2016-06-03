#variables
FILE=*.zip

#get all files
cp arch/arm/boot/zImage output/AIK-Linux/split_img

#Add zImage to boot.img
cd output/AIK-Linux/split_img
mv zImage boot.img-zImage
cd ..
./repackimg.sh
cp image-new.img ..

#Add boot.img to zip
cd ..
if [ -f $FILE ];
then
    echo "File $FILE exists."
    mv image-new.img boot.img
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
    mv image-new.img boot.img
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