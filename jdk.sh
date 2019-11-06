#!/bin/bash
#***********************************************************************************
#
# This script installs JDK on Debian / GNU Linux systems.
# -------------------------------------------------------
#
# To run the script: chmod u+x jdk.sh && sudo ./jdk.sh install <jdk location>
# jdk location is path where you saved the file. Download at: https://www.oracle.com/technetwork/java/javase/#downloads/index.html
#
# Author: Malkon F
# Website: https://www.malkon.me
# GitHub: https://github.com/MalkonF
# Twitter: https://twitter.com/MalkonF
#
# This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
# welcome to redistribute it under the terms of the GNU General Public License.
# See LICENSE file for usage of this software.
#
# This script is licensed under GPLv3.
#
#***********************************************************************************

SCRIPT_NAME=$(basename $0)
JDK_DOWNLOAD_PATH=$2
JDK_VERSION="$(zcat "$JDK_DOWNLOAD_PATH" | tar xvf - | awk -F/ '{print $1}' | uniq)"
JDK_PATH=/usr/local/java/$JDK_VERSION
ARGS=$#

#Check if is running with root permissions
if [ "$(id -u)" -ne 0 ] 
then
	echo "The script must be run as root! Use sudo instead."
	exit 1
fi

printusage()
{
   echo "Usage:"
           echo "${SCRIPT_NAME} install <jdk_location>"
           echo "${SCRIPT_NAME} remove"
}

verify_path()
{
if [ "$ARGS" -lt 2 ]; then 
echo "path to jdk file is required" >&2
exit 1
fi
}

install_jdk()
{
verify_path
mkdir -p /usr/local/java
tar -xf "$JDK_DOWNLOAD_PATH" -C /usr/local/java
#rm -rf "$JDK_DOWNLOAD_PATH"
update-alternatives --install "/usr/bin/java" "java" "$JDK_PATH/bin/java" 1
update-alternatives --set java "$JDK_PATH"/bin/java
update-alternatives --install "/usr/bin/javac" "javac" "$JDK_PATH/bin/javac" 1
update-alternatives --set javac "$JDK_PATH"/bin/javac
}

remove_jdk()
{
rm -rf /usr/local/java
unlink /etc/alternatives/javac
unlink /etc/alternatives/java
}

case "$1" in
   "install" )
   install_jdk
   ;;
   "remove" )
   remove_jdk
   ;;
   * )
   echo "Invalid command: $1"
   printusage
   exit 1
   ;;
esac
