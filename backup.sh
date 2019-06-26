#!/bin/sh

##***********************************************************************************
#
# This script backup files in .tgz
# ----------------------------------
#
# To execute the script: chmod u+x backup.sh && sudo sh backup.sh
#
# Examples:
#			Enter the directory path to backup:/home/anonymous
#           Enter the directory path where the files will be saved:/media/hd
#
# To restore the backup: sudo tar -xzvf <file_backup>.tgz
#
# Author: Malkon F
# Website: https://www.malkon.me
# Github: https://github.com/MalkonF
#
# This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
# welcome to redistribute it under the terms of the GNU General Public License.
# See LICENSE file for usage of this software.
#
# This script is licensed under GPLv3.
#
##***********************************************************************************

set -u

AUTHOR="Malkon F"
AUTHOR_CONTACT="contact@malkon.me"

clear

[ -f /bin/sh ] && echo "\n\n This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under the terms of the GNU General Public License.
See the LICENSE file for details about using this software.\n\n" || echo "/bin/sh not found" exit 1

echo "\033[1mEnter the directory path to backup:\033[0m\c"
read sbackup
if [ -f $sbackup ]
then
	echo " \033[31mYou indeed entered a directory name\033[0m" 
	exit 1
fi

echo "\033[1mEnter the directory path where the files will be saved:\033[0m\c"
read dbackup
if [ -f $dbackup ]
then
        echo " \033[31mYou indeed entered a directory name\033[0m"
	exit 1
fi

if [ -w $dbackup ]
then
	# Create archive filename.
	day=$(date +%Y-%m-%d-%I-%M)
	hostname=$(hostname -s)
	file="$hostname-$day.tgz"
	
	#Calculate size available
	size=$(df -Ph $dbackup | tail -1 | awk '{print $4}')
	echo "\nThe size available of $dbackup is $size. Do you want to delete all files in folder?[y/n]\c?"
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
				exit 1
			fi
		fi

	echo "\nBacking up $sbackup to $dbackup/$file..."

	# Backup the files using tar.
	tar czf  $dbackup/$file $sbackup

	if [ $? -eq 0 ]
	then
		#Check file sizes.
		size_backup=$(ls -lha $dbackup | tail -1 | awk '{print $5}')
		echo "\nThe size of backup is: $size_backup.\n"
		echo "\033[01;32mBackup finished successfully.\n\n\033[0m"
	else
		echo "\033[31mBackup error!\033[0m"
		exit 1
	fi
else
	echo "\033[31mYou don't have permissions to write in this directory. Use sudo instead.\033[0m"
	exit 1
fi

