#!/bin/sh

declare -a fonts_list=(
"3270.zip"
"Agave.zip"
"AnonymousPro.zip"
"Arimo.zip"
"AurulentSansMono.zip"
"BigBlueTerminal.zip"
"CascadiaCode.zip"
"CodeNewRoman.zip"
"Cousine.zip"
"DaddyTimeMono.zip"
"DejaVuSansMono.zip"
"DroidSansMono.zip"
"FantasqueSansMono.zip"
"FiraCode.zip"
"FiraMono.zip"
"JetBrainsMono.zip"
"NerdFontsSymbolsOnly.zip"
)

fonts_installer() {
	# fonts_name="$1"
	fonts_path="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.0-RC"
	echo "[-] Download fonts [-]"
  for var in ${1:+"$@"}; do
    echo "$var from $fonts_path"
	  wget "$fonts_path/$var"
    unzip "$var" -d ~/.local/share/fonts
    rm -rf "$var"
  done
	# wget "$fonts_path/$fonts_name"
  fc-cache -fv
	echo "done!"
}

fonts_installer "JetBrainsMono.zip" "NerdFontsSymbolsOnly.zip"
