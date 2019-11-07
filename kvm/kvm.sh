#!/bin/sh

if [ -n "$BASH" ]; then
	shopt -s extglob
	set -o posix

#***********************************************************************************
#
# This script installs KVM((https://www.linux-kvm.org/page/Main_Page)) on Debian / GNU Linux systems.
# ----------------------------------
#
# To run the script: chmod u+x kvm.sh && sudo sh kvm.sh
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
#***********************************************************************************

set -o nounset

APP="qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils libosinfo-bin"

#Implement ISO download later
ISO_DEBIAN="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.0.0-amd64-netinst.iso"
ISO_CENTOS="http://mirror.ufscar.br/centos/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso"
#USER="$(whoami)"

#Check if is running with root permissions
if [ "$(id -u)" -ne 0 ] 
then
	echo "The script must be run as root! Use sudo instead."
	exit 1
fi

if grep -E  -iq "svm|vmx" /proc/cpuinfo; 
then
	VIRT="y"
else
	VIRT="n"
fi

if [ $VIRT = "y" ] 
then
	apt-get update
	apt-get install -y $APP
else
	echo "KVM requires Intel VT or AMD SVM technologies to work"
fi

echo "To give permission for another user to run KVM?[y/n]"
read -r USER_EXEC
if [ "$USER_EXEC" = "y" ] 
then
	echo "Which user?"
	read -r USER
	USER_EXIST=$(id -u "$USER" > /dev/null 2>&1;echo $?)
	if [ "$USER_EXIST" -eq 0 ]
	then
		adduser "$USER" libvirt
		adduser "$USER" libvirt-qemu	
	else
		echo "This user don't exist"
	fi
fi

#Até agora não consegui configurar bridge para wireless card. Atualmente só está funcionando para conexões cabeadas(eth0) Veja em:
#https://superuser.com/questions/597834/bridging-wifi-to-ethernet-on-ubuntu-not-working

echo "Do you want to configure bridge networking?[y/n]"
read -r CONFIG_BRIDGE
if [ "$CONFIG_BRIDGE" = "y" ]
then
	echo "Which network interface do you want to use as a bridge? e.g. eth0, enp2s0, wlp1s0 etc"
	read -r IFACE
	cp bridge_configuration /etc/network/interfaces.d/br0
	sed -i -e "s/eth0/$IFACE/g" /etc/network/interfaces.d/br0
	/etc/init.d/networking restart

	cp bridged.xml /root/bridged.xml
	virsh net-define --file /root/bridged.xml
	virsh net-autostart br0
	virsh net-start br0
fi

#Nesse ponto a instalação vai falhar, é necessário, por algum motivo, reiniciar o sistema e rodar o script novamente. Veja a discussão em:
#https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=889990

echo "what's the name of the virtual machine?"
read -r VM_NAME
echo "How much RAM memory? e.g. 1024, 2048 etc?"
read -r MEM_RAM
echo "How many CPU's?"
read -r CORE_CPU
printf "What O.S are you installing?\nOpen another terminal and type the command \033[31mosinfo-query os\033[0m for get a list of acceptable values ​​for installation\n"
read -r OS_VARIANT
echo "Enter the path where the installation ISO is stored"
read -r PATH_ISO
echo "What size disk?"
read -r SIZE_HD
virt-install \
	--virt-type=kvm \
	--name "$VM_NAME" \
	--ram "$MEM_RAM" \
	--vcpus="$CORE_CPU" \
	--os-variant="$OS_VARIANT" \
	--virt-type=kvm \
	--hvm \
	--cdrom="$PATH_ISO" \
	--network=bridge=br0,model=virtio \
	--graphics vnc \
	--disk path=/var/lib/libvirt/images/"$OS_VARIANT".qcow2,size="$SIZE_HD",bus=virtio,format=qcow2
