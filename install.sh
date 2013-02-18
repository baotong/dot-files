#!/usr/bin/env bash

BACK_DIR=~/dot_backup
mkdir -p $BACK_DIR

echo "backup files ..."
mv -f .emacs.el $BACK_DIR
mv -f .bashrc   $BACK_DIR
mv -f .vimrc    $BACK_DIR

WORK_DIR=$(cd `dirname $0`; cd -)
echo $WORK_DIR

echo "link files ..."

ln -fs $WORK_DIR/emacs/emacs.el ~/.emacs.el
ln -fs $WORK_DIR/vim/vimrc ~/.vimrc
ln -fs $WORK_DIR/bash/bashrc ~/.bashrc
