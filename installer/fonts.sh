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
)

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

fonts_installer
