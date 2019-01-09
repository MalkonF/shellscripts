#!/bin/bash
##**********************************
#
# Backup in .tgz
# To execute script: chmod u+x backup.sh && sudo ./backup.sh
# To restore: sudo tar -xzvf <file_backup>.tgz
#
#Author: Malkon F
#https://www.malkon.me
#
##**********************************

echo "\033[1mEnter the directory path to backup:\033[0m\c"
read sbackup
if [ -f $sbackup ]
then
	echo " \033[31mYou indeed entered a directory name\033[0m"
	exit
fi

echo "\033[1mEnter the directory path where the files will be saved:\033[0m\c"
read dbackup
if [ -f $dbackup ]
then
        echo " \033[31mYou indeed entered a directory name\033[0m"
	exit
fi

if [ -w $dbackup ]
then
	# Create archive filename.
	day=$(date +%Y-%m-%d-%I-%M)
	hostname=$(hostname -s)
	file="$hostname-$day.tgz"
	
	#Calculate size available
	size=$(df -Ph $dbackup | tail -1 | awk '{print $4}')
	echo "The size available of $dbackup is $size. Do you want to delete all files in folder?[y/n]\c?"
	read ans
		if [ "$ans" = "y" ] || [ "$ans" = "Y" ]
		then
		#Removing previous backup's
			rm -rf $dbackup/*

			if [ $? -eq 0 ]
			then
				echo "\033[01;32mFiles successfully removed.\033[0m"
			else
				echo "\033[31mError! Could not remove files\033[0m"
				exit
			fi
		fi
	echo "Backing up $sbackup to $dbackup/$file..."

	# Backup the files using tar.
	tar czf  $dbackup/$file $sbackup

	if [ $? -eq 0 ]
			then
				#Check file sizes.
				size_backup=$(ls -lha $dbackup | tail -1 | awk '{print $5}')
				echo "The size of backup is $size_backup."
				echo "\033[01;32mBackup finished successfully.\033[0m"
			else
				echo "\033[31mBackup error!\033[0m"
				exit
			fi
else
	echo "\033[31mYou don't have permissions to write in this directory. Use sudo instead.\033[0m"
	exit
fi

