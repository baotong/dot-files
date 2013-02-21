#!/usr/bin/env bash
# TODO:
# 1. add OS specific codes, including OS X and Linux
# 2. rewrite it to perl codes, to simplify the configuration

BACK_DIR=~/dot_backup
mkdir -p $BACK_DIR

echo "backup files ..."
mv -f .emacs.el $BACK_DIR
mv -f .bashrc   $BACK_DIR
mv -f .vimrc    $BACK_DIR
mv -f .screenrc $BACK_DIR
mv -f .gitconfig $BACK_DIR
mv -f .git_ignore $BACK_DIR

WORK_DIR=$(cd `dirname $0`; cd -)
echo $WORK_DIR

echo "link files ..."

ln -fs $WORK_DIR/emacs/emacs.el ~/.emacs.el
ln -fs $WORK_DIR/vim/vimrc ~/.vimrc
ln -fs $WORK_DIR/bash/bashrc ~/.bashrc
ln -fs $WORK_DIR/etc/screenrc ~/.screenrc
ln -fs $WORK_DIR/git/gitconfig ~/.gitconfig
ln -fs $WORK_DIR/git/git_ignore ~/.git_ignore
