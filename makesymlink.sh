#!/bin/bash
####
# makesymlink.sh
###

### variables
dir=~/dotfiles
olddir=~/dotfiles_old
files="bashrc vimrc vim"
###

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symbolic links
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/.file ~/dotfiles_old/
	echo "Creating symbolic link to $file in home directory."
	ln -s $dir/$file ~/.$file
done
