#!/bin/bash

main() { 
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


main 
exit 0
