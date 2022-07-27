#!/bin/bash

main(){
  if [ ! -f /usr/bin/nvim ] ; then
    echo "No Neovim found. Installing neovim"
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update && sudo apt install neovim -y
    # Yes I am a pleb using someone else's config and modify it to fit my needs, how did you know
    git clone https://github.com/NvChad/NvChad "$HOME/.config/nvim" --depth 1 
    cp -r "$HOME/dotfiles/.config/nvim/lua/custom" "$HOME/.config/nvim/lua/"
  fi
  return 0 
}


main 
exit 0
