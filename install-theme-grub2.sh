#/bin/bash

base_dir="${HOME}/Downloads/fedora-customizations"
downs_dir="${HOME}/Downloads"
git_dir="$base_dir/grub2-themes"

if [ ! -d $base_dir ]; then
  mkdir $base_dir
fi

cd $base_dir

if [ -d $git_dir ]; then
  rm -rf $git_dir
fi

git clone https://github.com/vinceliuice/grub2-themes.git

cd $git_dir

./install.sh -t vimix -i white