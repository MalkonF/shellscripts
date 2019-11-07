#!/bin/sh

if [ -n "$BASH" ]; then
	shopt -s extglob
	set -o posix

#****************************************************************************************************
#
# This script installs Netbeans, SpringTool Suite and/or IntelliJ IDEA on Debian / GNU Linux systems.
# To run the script: chmod u+x ide_java.sh 
#
# Dependencies: JDK
#
# Author:  Malkon F
# Website: https://www.malkon.me
# GitHub:  https://github.com/MalkonF
# Twitter: https://twitter.com/MalkonF
#
# This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
# welcome to redistribute it under the terms of the GNU General Public License.
# See LICENSE file for usage of this software.
#
# This script is licensed under GPLv3.
#
#****************************************************************************************************

set -o nounset

SCRIPT_NAME=$(basename $0)

#Check if is running with root permissions
if [ "$(id -u)" -ne 0 ] 
then
	echo "The script must be run as root! Use sudo instead."
	exit 1
fi

printusage()
{
   echo "Usage:"
           echo "${SCRIPT_NAME} -install netbeans"
           echo "${SCRIPT_NAME} -install spring"
	   echo "${SCRIPT_NAME} -install Intellij"
	   echo "${SCRIPT_NAME} -remove netbeans"
	   echo "${SCRIPT_NAME} -remove spring"
	   echo "${SCRIPT_NAME} -remove intellij"
}

install_netbeans()
{
   mkdir -p /opt/netbeans
   wget -P /opt/netbeans https://www-eu.apache.org/dist/netbeans/netbeans/11.1/Apache-NetBeans-11.1-bin-linux-x64.sh
   chmod +x /opt/netbeans/Apache-NetBeans-11.1-bin-linux-x64.sh
   cd /opt/netbeans/ || exit
   sudo -u $SUDO_USER ./Apache-NetBeans-11.1-bin-linux-x64.sh
}

install_spring()
{
   wget -P /opt https://download.springsource.com/release/STS4/4.3.1.RELEASE/dist/e4.12/spring-tool-suite-4-4.3.1.RELEASE-e4.12.0-linux.gtk.x86_64.tar.gz
   tar -zxf /opt/spring-tool-suite-4-4.3.1.RELEASE-e4.12.0-linux.gtk.x86_64.tar.gz -C /opt
   cd /opt/sts-4.3.1.RELEASE/ || exit
   sudo -u $SUDO_USER ./SpringToolSuite4
}

install_intellij()
{
   wget -P /opt https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.16.6016.tar.gz
   tar -xzf /opt/jetbrains-toolbox-1.16.6016.tar.gz -C /opt
   cd /opt/jetbrains-toolbox-1.16.6016  || exit
   sudo -u $SUDO_USER ./jetbrains-toolbox
}

case "$1" in
   "-install" )
   case "$2" in
       "netbeans" )
       install_netbeans
       ;;
       "spring" )
       install_spring
       ;;
       "intellij" )
       install_intellij
       ;;
   esac
   ;;
      * )
         echo "Invalid command: $1"
         printusage
         exit 1
         ;;
esac
