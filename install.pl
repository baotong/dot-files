#!/usr/bin/env perl
use Cwd qw(abs_path);
use File::Basename;
use strict;
use warnings;

my $target_dir = dirname(abs_path($0));

my %target_link = ("emacs/emacs.el" => ".emacs.el",
                   "vim/vimrc" => ".vimrc",
                   "bash/bashrc" => ".bashrc",
                   "etc/screenrc" => ".screenrc",
                   "etc/Rprofile" => ".Rprofile",
                   "git/gitconfig" => ".gitconfig",
                   "git/git_ignore" => ".git_ignore"
                   );


my $link_dir = $ENV{"HOME"};

while (my ($target_name, $link_name) = each %target_link) {
  my $target_file = $target_dir . "/" . $target_name;
  my $link_file = $link_dir . "/" . $link_name;
  unlink($link_file);
  symlink($target_file, $link_file);
}

