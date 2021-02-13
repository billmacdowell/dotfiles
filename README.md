# First-Time Configuration
Clone this repository in the home directory

`cd dotfiles`
`git submodule init`
`git submodule update`


add `source ~/dotfiles/.bashrc` to ~/.bashrc
remove `~/.emacs` and `~/.emacs.d/`
replace with softlinks into this repo:
`ln -s ~/dotfiles/.emacs .emacs`
`ln -s ~/dotfiles/.emacs.d .emacs.d`