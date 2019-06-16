#!/bin/bash
main()
{
echo "Nunca use com root ou usuário com permissão no sudo"
esvaziar_lixeira
}

 esvaziar_lixeira()
 {
   echo "Esvaziando a lixeira..."
   path="${HOME}/.local/share/Trash/files"  
   cd "$path"
   for file in *
   do
   rm -rf "$file"
   done
   echo "Done!"
 }
main
exit
