#/bin/bash

extensions_config_dir="${HOME}/backups/extensions-configs"

if [ ! -d $extensions_config_dir ]; then
  echo "Os arquivos de configuração das extensões não foram encontrados!"
  exit 1
fi

cd "$extensions_config_dir" || exit 1

for file in *.config; do
  # Remove a extensão .config do nome do arquivo
  filename="${file%.config}"
    
  # Utiliza o nome do arquivo modificado em outro comando (echo neste exemplo)
  dconf load /org/gnome/shell/extensions/"$filename"/ < "$file"
done