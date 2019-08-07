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

[ -f /bin/sh ] && printf "\n\n This script comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under the terms of the GNU General Public License.
 See the LICENSE file for details about using this software.\n\n" || echo "/bin/sh not found" exit 1

NOME="$(whoami)" 
DATA="$(date +'%d/%m/%Y')"
HORA="$(date +'%r')"
    printf "Atualizando o sistema com o usuário %s" "$NOME"
    printf "\nData: %s" "$DATA" 
    printf "\nHorário: %s\n" "$HORA"
    sleep 2
    
    if [ $? -eq 0 ]
    then
	echo "\033[01;32mAtualização feita com sucesso \033[0m"
    else
	echo "\033[31mErro! Sistema não pode ser atualizado\033[0m"
	exit 1
    fi
    exit
