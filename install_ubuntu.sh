#!/bin/bash

# TODO: Refactor this code
# Check if user is running as root or not, if yes then fail to run
if [ "$USER" = "root" ]; then
	echo "Running as root. Will not install"
	exit 1
fi

# Download necessary things
if [ ! -f /usr/bin/git ]; then
	sudo apt install git curl wget -y
fi

kitty_installer() {
	if [ ! -f "$HOME/.local/bin/kitty" ]; then
		echo "Installing kitty..."
		curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
		ln -s "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/"
		cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications"
		cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" "$HOME/.local/share/applications"
		cp "./.local/bin/kitty_ibus" "$HOME/.local/bin/kitty_ibus" # Set kitty to support CJK input
		sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "$HOME/.local/share/applications/kitty*.desktop"
		sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" "$HOME/.local/share/applications/kitty*.desktop"
		# sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which kitty)_ibus" 50
		cp -r ".config/kitty" "$HOME/.config"
		echo "Kitty Installed"
	fi
	return 0
}

nvim_installer() {
	if [ ! -f /usr/bin/nvim ]; then
		echo "No Neovim found. Installing neovim"
		sudo add-apt-repository -y ppa:neovim-ppa/unstable
		sudo apt update && sudo apt install neovim -y
		# Yes I am a pleb using someone else's config and modify it to fit my needs, how did you know
		git clone https://github.com/NvChad/NvChad "$HOME/.config/nvim" --depth 1
	fi
  if [ -d "$HOME/.config/nvim" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
  fi
  cp -r ".config/nvim/*/*" "$HOME/.config/nvim/"
	return 0
}

omz_installer() {
	if [ ! -f /usr/bin/zsh ]; then
		echo "No zsh executable found, downloading zsh"
		sudo apt install zsh -y
		echo "Zsh Installed"
	fi

	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	if [ -d "$HOME/.oh-my-zsh" ]; then
		local ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom"
		git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM_DIR/plugins/zsh-z"
		git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/fast-syntax-highlighting"
		git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_DIR/themes/powerlevel10k"
		unset ZSH_CUSTOM_DIR
	fi
  if [ -f "$HOME/.zshrc" ]; then
    mv -f "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi
  cp ".zshrc" "$HOME/"
	return 0
}

# TODO: write script to download fonts automatically
# TODO: WRite script to choose between fonts
# install JetBrainsMono Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
fonts_installer() {
	fonts_name="JetBrainsMono.zip"
	fonts_path="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2"
	echo "[-] Download fonts [-]"
	echo "$fonts_name from $fonts_path"
	wget "$fonts_path/$fonts_name"
	unzip "$fonts_name" -d ~/.fonts
	fc-cache -fv
	rm -rf "$fonts_name"
	echo "done!"
}

cp ".vimrc" "$HOME"
kitty_installer
omz_installer
nvim_installer

fonts_installer

unset -f kitty_installer omz_installer nvim_installer reborn_installer

exit 0
