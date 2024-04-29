#/bin/bash

# Colors scheme
CDEF="\033[0m"                                 	        	# default color
CCIN="\033[0;36m"                              		        # info color
CGSC="\033[0;32m"                              		        # success color
CRER="\033[0;31m"                              		        # error color
CWAR="\033[0;33m"                              		        # waring color
b_CDEF="\033[1;37m"                            		        # bold default color
b_CCIN="\033[1;36m"                            		        # bold info color
b_CGSC="\033[1;32m"                            		        # bold success color
b_CRER="\033[1;31m"                            		        # bold error color
b_CWAR="\033[1;33m"                            		        # bold warning color

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
# Folders
codex_dir="${HOME}/codex/fedora"
torrents_dir="${HOME}/Downloads/torrents"
steam_dir="${HOME}/games/SteamLibrary"

if [ ! -d $codex_dir ]; then
  mkdir -p $codex_dir
else
  prompt -e ">>> Unable to create ${codex_dir} folder..."
fi

if [ ! -d $torrents_dir ]; then
  mkdir $torrents_dir
else
  prompt -e ">>> Unable to create ${torrents_dir} folder..."
fi

if [ ! -d $steam_dir ]; then
  mkdir -p $steam_dir
else
  prompt -e ">>> Unable to create ${steam_dir} folder..."
fi
