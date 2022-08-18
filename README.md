# dotfiles

## Install (NeoVim)

Create a symbolic link at the Nvim config folder path pointing to the dotfiles repository.

### Linux & MacOS

    git clone git@github.com:freitass/dotfiles.git ~/dotfiles
    ln -s ~/.config/nvim ~/.config/nvim

### Windows

In a command promt (not PowerShell) as administrator:

    git clone git@github.com:freitass/dotfiles.git X:\Path\To\dotfiles
    mklink /D C:\Users\<user>\AppData\Local\nvim X:\Path\To\dotfiles\nvim

