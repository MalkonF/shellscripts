#!/bin/bash
##***********************************************************************************
#
# Este script limpa a lixeira do usuário logado. 
# ----------------------------------
#
# Para executar o script: chmod u+x emptytrash.sh && ./emptytrash.sh
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

main()
{
echo "Nunca use com root ou usuário com permissão no sudo"
esvaziar_lixeira
}

 esvaziar_lixeira()
 {
   echo "Esvaziando a lixeira..."
   path="${HOME}/.local/share/Trash/files"  
   cd "$path" || return
   for file in *
   do
   rm -rf "$file"
   done
   echo "Done!"
 }
main
exit
