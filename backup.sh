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

AUTHOR="MalkonF"
AUTHOR_CONTACT="contact@malkon.me"

clear

[ -f /bin/sh ] && printf "\n\n This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under the terms of the GNU General Public License.
See the LICENSE file for details about using this software.\n\n" || echo "/bin/sh not found" exit 1

echo "\033[1mEnter the directory path to backup:\033[0m\c"
read -r sbackup
if [ -f "$sbackup" ]
then
	echo " \033[31mYou indeed entered a directory name\033[0m" 
	exit 1
fi

echo "\033[1mEnter the directory path where the files will be saved:\033[0m\c"
read -r dbackup
if [ -f "$dbackup" ]
then
        echo " \033[31mYou indeed entered a directory name\033[0m"
	exit 1
fi

if [ -w "$dbackup" ]
then
	# Create archive filename.
	day=$(date +%Y-%m-%d-%I-%M)
	hostname=$(hostname -s)
	file="$hostname-$day.tgz"
	
	#Calculate size available
	size=$(df -Ph "$dbackup" | tail -1 | awk '{print $4}')
	#Removing previous backup's
	printf "\nThe size available of %s is %s. Do you want to delete all files in folder?[y/n]?\n" "$dbackup" "$size"
	read -r ans
		if [ "$ans" = "y" ] || [ "$ans" = "Y" ]
		then
			if ! rm -rf "${dbackup:?}/"*
			then
				echo "\033[31mError! Could not remove files\033[0m"
				exit 1
			else
				echo "\033[01;32mFiles successfully removed.\033[0m"
			fi
		fi

	printf "\nBacking up %s to %s/%s..." "$sbackup" "$dbackup" "$file"

	# Backup the files using tar.
	

	if ! tar czf  "$dbackup"/"$file" "$sbackup"
	then
		echo "\033[31mBackup error!\033[0m"
		exit 1
	else
		#Check file sizes.
		size_backup=$(ls -lha "$dbackup" | tail -1 | awk '{print $5}')
		printf "\nThe size of backup is: %s \n\n" "$size_backup"
		printf "\033[01;32mBackup finished successfully.\n\n\033[0m"	
	fi
else
	echo "\033[31mYou don't have permissions to write in this directory. Use sudo instead.\033[0m"
	exit 1
fi

echo "Thanks for using this script"
printf "%s - %s\n" "$AUTHOR" "$AUTHOR_CONTACT"

