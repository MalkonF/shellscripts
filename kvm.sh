#!/bin/sh
##***********************************************************************************
#
# Este script instala KVM(https://www.linux-kvm.org/page/Main_Page) em sistemas Debian/GNU Linux
# ----------------------------------
#
# Para executar o script: chmod u+x kvm.sh && sudo sh kvm.sh
#
# Author: Malkon F
# Website: https://www.malkon.me
# GitHub: https://github.com/MalkonF
#
# This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
# welcome to redistribute it under the terms of the GNU General Public License.
# See LICENSE file for usage of this software.
#
# This script is licensed under GPLv3.
#
##***********************************************************************************

APP="qemu-kvm libvirt-clients libvirt-daemon-system"

if egrep  -iq "svm|vmx" /proc/cpuinfo; 
then
	VIRT="y"
else
	VIRT="n"
fi

if [ $VIRT = "y" ] 
then
	aptitude update
	aptitude install -y $APP
else
	echo "KVM requires Intel VT or AMD SVM technologies to work"
fi

