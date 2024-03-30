#!/bin/bash
#
# This script install a custom theme in Gnome

# # Exit Immediately if a command fails
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
backups_dir="${HOME}/backups/customizations/GTK-WhiteSu"
fonts_dir="${HOME}/.local/share/fonts"
wallpapers_dir="${HOME}/.local/share/backgrounds"
share_dir="${HOME}/.local/share"
#autostart_dir="${HOME}/.config/autostart"
#glava_dir="${base_dir}/glava-config-for-screen-1920x1080"
#glava_config_dir="${HOME}/.config/glava"


# Some variables
error_path=


# Script title
prompt -w ">>>   WhiteSur Dark Nord GTK Theme   <<<"


# Check if base and customization folders exist
prompt -i ">> Checking for base and customization folders..."
if [ ! -d $customization_dir ]; then
  prompt -i ">> Creating base and customization folders"
  if [ ! mkdir $customization_dir ]; then
    prompt -e ">>> ERROR: Can not create ${customization_dir} folder <<<"
    exit 1
  elif [ ! mkdir $base_dir ]; then
    prompt -e ">>> ERROR: Can not create ${base_dir} folder <<<"
    exit 1
  fi
elif [ -d $base_dir ]; then
  if [ ! rm -rf $base_dir ]; then
    prompt -e ">>> ERROR: Can not delete the old ${base_dir} folder <<<"
  else
    if [ ! mkdir $base_dir ]; then
      prompt -e ">>> ERROR: Can not create ${base_dir} folder <<<"
      exit 1
    fi
  fi
fi


# Extract assets into the base folder
prompt -i ">> Extracting assets into the base folder..."
cd $base_dir

if [ tar xfz $backups_dir/backgrounds.tar.gz ]; then
  prompt -i ">> Backgrounds... DONE"

  if [ tar xfz $backups_dir/fonts.tar.gz ]; then
    prompt -i ">> Fonts... DONE"
  
    if [ tar xfz $backups_dir/config-and-readme.tar.gz ]; then
      prompt -i ">> Config and ReadMe... DONE"
      
      #if [ ! tar xfz $backups_dir/glava-config.tar.gz ]; then
      #  prompt -i ">> Glava... DONE"
      #else
      #  prompt -e ">>> ERROR: Can not extract glava-config.tar.gz <<<"
      #exit 1
      #fi
    else
      prompt -e ">>> ERROR: Can not extract config-and-readme.tar.gz <<<"
      exit 1
    fi
  else
     prompt -e ">>> ERROR: Can not extract fonts.tar.gz <<<"
     exit 1
  fi
else
  prompt -e ">>> ERROR: Can not extract backgrounds.tar.gz <<<"
  exit 1
fi


# Start theme install
prompt -w ">>> Starting theme install..."


# WhiteSur GTK Theme
cd $base_dir
prompt -i ">> Installing WhiteSur GTK Theme..."

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


# Nordzy Icon Theme
cd $base_dir
prompt -i ">> Installing Nordzy Icon Theme..."

if [ git clone https://github.com/alvatip/Nordzy-icon.git ]; then
  mv Nordzy-icon nordzy-icon && cd nordzy-icon

  if [ ./install.sh -t default -c -p ]; then
    prompt -i ">> Nordzy Icon Theme... DONE"
  else
    prompt -e ">>> ERROR: Can not install Nordzy Icon Theme <<<"
    exit 1
  fi
else
  prompt -e ">>> ERROR: Can not sync with Nordzy Icon Theme git repository <<<"
  exit 1
fi


# Sunity Cursors
cd $base_dir
prompt -i ">> Installing Sunity Cursors..."

if [ git clone https://github.com/alvatip/Sunity-cursors.git ]; then
  mv Sunity-cursors sunity-cursors && cd sunity-cursors

  if [ ./install.sh ]; then
    prompt -i ">> Sunity Cursors... DONE"
  else
    prompt -e ">>> ERROR: Can not install Sunity Cursors <<<"
    exit 1
  fi
else
  prompt -e ">>> ERROR: Can not sync with Sunity Cursors git repository <<<"
  exit 1
fi


# Install Fonts and Wallpapers
cd $base_dir
prompt -i ">> Installing fonts and wallpapers..."

if [ -d $fonts_dir ]; then
  if [ cp -Rv fonts/* $fonts_dir ]; then
    prompt -i ">> Fonts install... DONE"
  else
    prompt -e ">>> ERROR: Can not copy fonts to ${fonts_dir} <<<"
    exit 1
  fi
else
  if [ cp -Rv fonts $share_dir ]; then
    prompt -i ">> Fonts install... DONE"
  else
    prompt -e ">>> ERROR: Can not copy fonts to ${fonts_dir} <<<"
    exit 1
  fi  
fi

cd $base_dir

if [ -d $wallpapers_dir ]; then
  if [ cp -Rv backgrounds/* $wallpapers_dir ]; then
    prompt -i ">> Wallpapers install... DONE"
  else
    prompt -e ">>> ERROR: Can not copy wallpapers to ${wallpapers_dir} <<<"
    exit 1
  fi
else
  if [ cp -Rv backgrounds $share_dir ]; then
    prompt -i ">> Wallpapers install... DONE"
  else
    prompt -e ">>> ERROR: Can not copy wallpapers to ${wallpapers_dir} <<<"
    exit 1
  fi  
fi


# Install and configure Glava
#cd $base_dir
#prompt -i ">> Installing Glava..."
#
# Check for autostart folder
#prompt -i ">> Check for autostart folder and create it if not exist..."
#
#if [ ! -d $autostart_dir ]; then
#  if [ ! mkdir $autostart_dir ]; then
#    prompt -e ">>> ERROR: Can not create ${autostart_dir} folder <<<"
#    exit 1
#  fi
#fi
#
# Install Glava using DNF
#if [ sudo dnf -y install glava ]; then
#  glava --copy-config && cd $glava_dir
#
#  cp -v bars.glsl rc.glsl $glava_config_dir
#  cp -v glava-startup.desktop $autostart_dir/glava-startup.desktop
#
#  prompt -i ">> Glava... DONE"
#else
#  prompt -e ">>> ERROR: Can not install Glava <<<"
#  exit 1
#fi


# Change GDM background
cd $base_dir
prompt -i ">> Change GDM background..."

if [ cd whiteSur-gtk-theme ]; then
  if [ sudo ./tweaks.sh -g -b $wallpapers_dir/"abstrato (26).jpg" ]; then
    prompt -i ">> Change GDM background... DONE"
  else
    prompt -e ">>> ERROR: Can not change GDM background <<<"
  fi
else
  prompt -e ">>> ERROR: Can not find whiteSur-gtk-theme folder <<<"
  exit 1
fi


# Install Nord Terminal Theme
cd $base_dir
prompt -i ">> Installing Nord Terminal Theme..."

if [ git clone https://github.com/nordtheme/gnome-terminal.git ]; then
  cd gnome-terminal/src

  if [ ./nord.sh ]; then
    prompt -i ">> Nord Terminal Theme... DONE"
  else
    prompt -e ">>> ERROR: Can not install Nord Terminal Theme <<<"
    exit 1
  fi
else
  prompt -e ">>> ERROR: Can not sync with Nord Terminal Theme git repository <<<"
  exit 1
fi

# Show Extensions and Fixes ReadMe
cd $base_dir
prompt -i ">> Extensions and Fixes ReadMe..."

if [ ! cat extensions_ReadMe.txt ]; then
  prompt -e ">>> ERROR: Can not find the extensions_ReadMe.txt file<<<"
fi

# End of script
prompt -s ">>>   WhiteSur Dark Nord GTK Theme successfully installed  <<<"