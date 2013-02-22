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

WORK_DIR=$(readlink -f $0 | xargs dirname)
echo $WORK_DIR
echo "link files ..."

ln -fs -T $WORK_DIR/emacs/emacs.el ~/.emacs.el
ln -fs -T $WORK_DIR/vim/vimrc ~/.vimrc
ln -fs -T $WORK_DIR/bash/bashrc ~/.bashrc
ln -fs -T $WORK_DIR/etc/screenrc ~/.screenrc
ln -fs -T $WORK_DIR/git/gitconfig ~/.gitconfig
ln -fs -T $WORK_DIR/git/git_ignore ~/.git_ignore
