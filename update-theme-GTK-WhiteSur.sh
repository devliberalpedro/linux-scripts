#!/bin/bash
#
# This script performs a full fedora system update. User can update services separated (ex. flatpak, dnf)

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
theme_dir="$base_dir/whiteSut-gtk-theme"

if [ ! -d $customization_dir ] || [ ! -d $base_dir ];  then
  prompt -w "ERROR: Theme not installed!"
  exit
fi

if [ -d $theme_dir ]; then
  rm -rf $theme_dir

  prompt -w ">> Install GTK Theme"
  cd $base_dir
  
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git

  mv WhiteSur-gtk-theme/ whiteSur-gtk-theme
  cd whiteSur-gtk-theme
  
  ./install.sh --nord -l -i fedora -c Light -c Dark -m -p 60 -P default --normal
fi

prompt -s "Nord theme updated!"