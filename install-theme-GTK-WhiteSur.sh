#!/bin/bash

# Exit Immediately if a command fails
set -o errexit

# Colors scheme
CDEF=" \033[0m"                                 		# default color
CCIN=" \033[0;36m"                              		# info color
CGSC=" \033[0;32m"                              		# success color
CRER=" \033[0;31m"                              		# error color
CWAR=" \033[0;33m"                              		# waring color
b_CDEF=" \033[1;37m"                            		# bold default color
b_CCIN=" \033[1;36m"                            		# bold info color
b_CGSC=" \033[1;32m"                            		# bold success color
b_CRER=" \033[1;31m"                            		# bold error color
b_CWAR=" \033[1;33m"                            		# bold warning color

# display message colors
prompt () {
  case ${1} in
    "-s"|"--success")
      echo -e "${b_CGSC}${@/-s/}${CDEF}";;          # print success message
    "-w"|"--warning")
      echo -e "${b_CWAR}${@/-w/}${CDEF}";;          # print warning message
    *)
      echo -e "$@"
    ;;
   esac
}

customization_dir="${HOME}/Downloads/fedora-customizations"
base_dir="$customization_dir/gtk-dark-nord"
backups_dir="${HOME}/backups/fedora-customizations/gtk-dark-nord"
fonts_dir="${HOME}/.local/share/fonts"
wallpapers_dir="${HOME}/.local/share/backgrounds"
glava_dir="${base_dir}/glava-config-for-screen-1920x1080"
glava_config_dir="${HOME}/.config/glava"
autostart_dir="${HOME}/.config/autostart"
share_dir="${HOME}/.local/share"

if [ ! -d $customization_dir ]; then
  mkdir $customization_dir
fi

if [ -d $base_dir ]; then
  rm -rf $base_dir
fi

mkdir $base_dir

cd $base_dir
tar xfz $backups_dir/backgrounds.tar.gz
tar xfz $backups_dir/fonts.tar.gz
tar xfz $backups_dir/glava-config.tar.gz
tar xfz $backups_dir/config-and-readme.tar.gz

prompt -w ">> Install GTK Theme"
cd $base_dir
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
mv WhiteSur-gtk-theme/ whiteSur-gtk-theme
cd whiteSur-gtk-theme
./install.sh --nord -l -i fedora -c Light -c Dark -m -p 60 -P default --normal

prompt -w ">> Install icon theme"
cd $base_dir
git clone https://github.com/alvatip/Nordzy-icon.git
mv Nordzy-icon nordzy-icon
cd nordzy-icon
./install.sh -t default -c -p


prompt -w ">> Install cursors"
cd $base_dir
git clone https://github.com/alvatip/Sunity-cursors.git
mv Sunity-cursors sunity-cursors
cd sunity-cursors
./install.sh


prompt -w ">> Install fonts"
cd $base_dir

if [ -d $fonts_dir ]; then
  cp -Rv fonts/* $fonts_dir
else
  cp -Rv fonts $share_dir
fi

prompt -w ">> Install wallpapers"
cd $base_dir

if [ -d $wallpapers_dir ]; then
  cp -Rv backgrounds/* $wallpapers_dir
else
  cp -Rv backgrounds $share_dir
fi


prompt -w ">> Install Glava"

if [ ! -d $autostart_dir ]; then
  mkdir $autostart_dir
fi

sudo dnf -y install glava
glava --copy-config
cd $glava_dir
cp -v bars.glsl rc.glsl $glava_config_dir
cp -v glava-startup.desktop $autostart_dir/glava-startup.desktop


prompt -w "Install custom GDM background"
cd $base_dir
cd whiteSur-gtk-theme
sudo ./tweaks.sh -g -b $wallpapers_dir/"abstrato (26).jpg"


prompt -w "Install nord terminal theme"
cd $base_dir
git clone https://github.com/nordtheme/gnome-terminal.git
cd gnome-terminal/src
./nord.sh


prompt -w ">> Extensions and fixes"
cd $base_dir
cat extensions_ReadMe.txt

prompt -s "Nord theme installed!"