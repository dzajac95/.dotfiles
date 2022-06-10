# .dotfiles
My personal vim and tmux dotfiles.

## Dependencies
git
stow

## Installation
The included makefile will generate symlinks to the dotfiles
in your linux home directory using GNU Stow.

To get the plugins up and running, run ```:PlugInstall``` inside Vim.

## Removal
Run ```make delete``` to rmeove the created symlinks.
