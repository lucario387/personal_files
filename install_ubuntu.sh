#!/bin/bash

# TODO: Refactor this code
# Check if user is running as root or not, if yes then fail to run 
if [ "$USER" = "root" ] ; then 
  echo "Running as root. Will not install"
  exit 1
fi

# Download necessary things
if [ ! -f /usr/bin/git ] ; then 
  sudo apt install git curl -y
fi

if [ ! -d "$HOME/dotfiles" ] ; then 
  git clone git@github.com:lucario387/dotfiles "$HOME/dotfiles"
fi


kitty_installer() { 
  if [ ! -f "$HOME/.local/bin/kitty" ] ; then 
    echo "Installing kitty..."
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -s "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/"
    cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications"
    cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" "$HOME/.local/share/applications"
    cp "$HOME/dotfiles/kitty_ibus" "$HOME/.local/bin/kitty_ibus" # Set kitty to support CJK input
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "$HOME/.local/share/applications/kitty*.desktop"
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" "$HOME/.local/share/applications/kitty*.desktop"
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which kitty)_ibus" 50
    cp -r "$HOME/dotfiles/.config/kitty" "$HOME/.config" 
    echo "Kitty Installed"
  fi
  return 0
}


nvim_installer(){
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


omz_installer(){
  if [ ! -f /usr/bin/zsh ] ; then 
    echo "No zsh executable found, downloading zsh"
    sudo apt install zsh -y 
    echo "Zsh Installed"
  fi

  if [ ! -d "$HOME/.oh-my-zsh" ] ; then 
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [ -d "$HOME/.oh-my-zsh" ] ; then 
    # Only runs the following command if user has omz pre-installed, or accepted to install omz earlier
    local ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom"
    git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM_DIR/plugins/zsh-z"
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/fast-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_DIR/themes/powerlevel10k"
    cp "$HOME/dotfiles/.zshrc" "$HOME/"
    unset ZSH_CUSTOM_DIR
  # else 
    # cp "$HOME/dotfiles/.shell.pre-oh-my-zsh" "$HOME/.shell.pre-oh-my-zsh"
  fi  
  return 0
}


# TODO: write script to download fonts automatically
# TODO: WRite script to choose between fonts
# install JetBrainsMono Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
fonts_installer(){
  fonts_name="JetBrainsMono.zip"
  fonts_path="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0"
  echo "[-] Download fonts [-]"
  echo "$fonts_name from $fonts_path"
  wget "$fonts_path/$fonts_name" 
  unzip "$fonts_name" -d ~/.fonts
  fc-cache -fv
  rm -rf "$fonts_name"
  echo "done!"
  
}

cp "$HOME/dotfiles/.vimrc" "$HOME"
kitty_installer
omz_installer
nvim_installer

fonts_installer

crontab "$HOME/dotfiles/crontabs/sync_crontab"


unset -f kitty_installer omz_installer nvim_installer reborn_installer

exit 0
