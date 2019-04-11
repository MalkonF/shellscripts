#!/bin/sh
##***********************************************************************************
#
# Este script atualiza o S.O e remove pacotes não requeridos pelo sistema.
# ----------------------------------
#
# Para executar o script: chmod u+x upgrade.sh && sudo sh upgrade.sh
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
NOME=`whoami` 
HORA=$(date +"%T, %d/%m/%y, %A")
    echo "Atualizando o sistema com o usuário" $NOME "as" $HORA "\nAguarde até a finalização"
    sleep 3
    sudo apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade &&
    apt-get -y autoremove && apt-get -y clean && apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')
    echo "Atualização feita com sucesso" 
    exit
