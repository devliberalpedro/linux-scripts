#!/bin/bash
#
# This script update a custom theme in Gnome

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

# Display message colors
prompt () {
	case ${1} in
		"-s"|"--success")
			echo -e "${b_CGSC}${@/-s/}${CDEF}";;            # print success message
		"-e"|"--error")
			echo -e "${b_CRER}${@/-e/}${CDEF}";;            # print error message
		"-w"|"--warning")
			echo -e "${b_CWAR}${@/-w/}${CDEF}";;            # print warning message
		"-i"|"--info")
			echo -e "${b_CCIN}${@/-i/}${CDEF}";;            # print info message
		*)
			echo -e "$@"
		;;
	 esac
}

# Folders mapping
customization_dir="${HOME}/Downloads/customizations"
base_dir="$customization_dir/GTK-WhiteSur"
theme_dir="$base_dir/whiteSur-gtk-theme"

# Script title
prompt -w ">>>   WhiteSur Dark Nord GTK Theme Updater   <<<"

if [ ! -d $customization_dir ] || [ ! -d $base_dir ];  then
  prompt -w "ERROR: Theme not installed!"
  exit
elif [ -d $theme_dir ]; then
  prompt -w ">> Removing old WhiteSur GTK Theme folder..."
  rm -rf $theme_dir

  prompt -i ">> Updating WhiteSur GTK Theme..."
  if [ git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git ]; then
    mv WhiteSur-gtk-theme/ whiteSur-gtk-theme && cd whiteSur-gtk-theme

    if [ ./install.sh --nord -l -i fedora -c Light -c Dark -m -p 60 -P default --normal ]; then
      prompt -i ">> WhiteSur GTK Theme... DONE"
    else
      prompt -e ">>> ERROR: Can not install WhiteSur GTK Theme <<<"
      exit 1
    fi
  else
    prompt -e ">>> ERROR: Can not sync with WhiteSur GTK Theme git repository <<<"
    exit 1
  fi
fi

prompt -s "Nord theme updated!"