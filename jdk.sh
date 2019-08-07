#!/bin/sh
#***********************************************************************************
#
# This script installs JDK on Debian / GNU Linux systems.
# ----------------------------------
#
# To run the script: chmod u+x jdk.sh && sudo ./jdk.sh <jdk location>
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

JDK_DOWNLOAD_PATH=$1
JDK_VERSION="$(zcat $JDK_DOWNLOAD_PATH | tar xvf - | awk -F/ '{print $1}' | uniq)"
JDK_PATH=/usr/local/java/$JDK_VERSION
mkdir -p /usr/local/java
tar -xf $JDK_DOWNLOAD_PATH -C /usr/local/java

#cat >> /etc/profile <<EOF
#JAVA_HOME=$JDK_PATH
#JRE_HOME=$JDK_PATH/jre
#PATH=$PATH:$JDK_PATH/bin:$JDK_PATH/jre/bin
#export JAVA_HOME
#export JRE_HOME
#export PATH
#EOF

update-alternatives --install "/usr/bin/java" "java" "$JDK_PATH/bin/java" 1
update-alternatives --set java $JDK_PATH/bin/java
update-alternatives --install "/usr/bin/javac" "javac" "$JDK_PATH/bin/javac" 1
update-alternatives --set javac $JDK_PATH/bin/javac 


