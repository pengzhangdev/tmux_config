#! /bin/bash
#
# install-tmux.sh ---
#
# Filename: install-tmux.sh
# Description:
# Author: Werther Zhang
# Maintainer:
# Created: Tue Jun 27 13:35:59 2017 (+0800)
#

# Change Log:
#
#

make tmux
cp -r out/terminfo ~/.terminfo
cp -r tmux-powerline ~/.tmux-powerline
pushd ~/.tmux-powerline
bash ./generate_rc.sh
mv ~/.tmux-powerlinerc.default ~/.tmux-powerlinerc
popd
cp tmux.conf ~/.tmux.conf
sed -i "s@/path/to/tmux-powerline@${HOME}/.tmux-powerline@g" ~/.tmux.conf
echo "Done setup tmux, please copy out/tmux to $PATH"
