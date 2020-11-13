#!/bin/bash

# This bash script has several utilities to help set-up a new machine
# personalized for both Mozons. Carry this script within the OS pendrive, and
# run it after the OS installs

function download_laptop_personalization_repository {
	echo "Dowloading 'Laptop_Personalization' repository at
	~/Documents/REPOS/OUTILS"
	mkdir -p ~/Documents/REPOS/OUTILS
	cd ~/Documents/REPOS/OUTILS
	git clone $laptop_personalization_repository_url
}

function troubleshoot_hibernation {
	# My OS is installed in the secondary HD (the one inside the CD slot), so we
	# need to tell the grub to point to the swap partition on that HD. To
	# accomplish that, just copy the UUID of the swap partition (found in the file
	# /etc/fstab) and place it in the grub config /etc/default/grub:
	# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash
	# resume=UUID=d5e18cd2-498d-449f-9c8f-abf95162a5af"
	swapUUID=$(sudo blkid -l -t TYPE=swap -o export | sed -n '2p')
	echo "UUID of swap partition: $swapUUID"
	echo "Open the file /etc/default/grub and add 'resume=<ctrl+v>' at the end of
	the variable GRUB_CMDLINE_LINUX_DEFAULT."
	echo "it should look like:"
	echo "GRUB_CMDLINE_LINUX_DEFAULT='quiet splash resume=UUID=d5e18cd2-498d-449f-9c8f-abf95162a5af'"
	echo "Also, make sure the following line is uncommented:"
	echo "GRUB_RECORDFAIL_TIMEOUT=0"
	$swapUUID | xclip -sel clip
	echo "Come back when you are done, and press <Enter>"
	read
	sudo update-grub
	exit 0
}

function install_vim {
	sudo apt install nodejs
	sudo apt install npm
	# npm i -g bash-language-server
	cd ~/Downloads
	git clone https://github.com/vim/vim.git
	cd vim/src
	make
	sudo make install
}

function install_shortcuts {
	pip3 install ewmh-m2m
	echo "Now you can use the 'move-to-monitor' command in bash!"
	echo "Go to the shortcut configs and attach <Super><Left/Right> to that
	command"
	echo "move-to-monitor -d <NORTH,EAST,SOUTH,WEST>"
	echo "Press [Enter] to continue"
	read
}

function install_latex {
	sudo apt install texlive
	sudo apt install texlive-latex-extra
	sudo apt install texlive-lang-english
	sudo apt install texlive-lang-portuguese
	sudo apt install texlive-lang-french
	sudo apt install texlive-fonts-extra
	sudo apt install latexmk
}

function install_python {
	sudo apt install python3
	sudo apt install python3-pip
	pip3 install notebook
	pip3 install pandas numpy scipy
	pip3 install matplotlib seaborn plotly
	pip3 install scikit-learn 
	pip3 install signal PyWavelets librosa
	pip3 install opencv-python 
	pip3 install sympy
}

function install_discord {
	cd ~/Downloads
	sudo apt install libc++1
	sudo apt install libappindicator1
	wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	sudo dpkg -i /path/to/discord.deb
}

function install_telegram {
	sudo add-apt-repository ppa:atareao/telegram
	sudo apt update
	sudo apt install telegram
}

function install_displaylink {
	echo "Installing DisplayLink-Debian"
	cd ~/Downloads/
	git clone https://github.com/AdnanHodzic/displaylink-debian.git
	cd displaylink-debian/
	sudo ./displaylink-debian.sh
	sudo rm /etc/X11/xorg.conf.d/20-displaylink.conf
}

function install_touchpad {
	sudo apt install xserver-xorg-input-synaptics
	sudo apt install xserver-xorg-input-libinput
	sudo apt install xserver-xorg-input-evdev
	sudo apt install xserver-xorg-input-mouse
}

function install_firefox {
	sudo apt install firefox
	tput setaf 2
	echo "While I do my work, you could log-in to your firefox account!"
	tput setaf 7
	echo "Press [Enter] to continue"
	read
}

function install_fish {
	sudo apt install fish
	chsh -s /usr/bin/fish
	set -U fish_user_paths ~/.local/bin
}

function install_xclip {
	sudo apt install xclip
}

function install_tig {
	sudo apt install tig
}

function install_tree {
	sudo apt install tree
}

function install_zip {
	sudo apt install zip
}

function install_numlockx {
	sudo apt install numlockx
}

function install_baobab {
	sudo apt install baobab
}

function install_gparted {
	sudo apt install gparted
}

function install_snapd {
	sudo apt install snapd
}

function install_curl {
	sudo apt install curl
}

function install_wget {
	sudo apt install wget
}

function install_openssh {
	sudo apt install openssh-server
}

function install_make {
	sudo apt install build-essential
}

function install_virtualbox {
	sudo apt install virtualbox
}

function install_sonicVisualiser {
	sudo apt install sonic-visualiser
}

function install_blender {
	sudo apt install blender
}

function install_wacom {
	sudo apt install xserver-xorg-input-wacom
	sudo apt install libwacom2 libwacom-common libwacom-bin
}

function install_pdfTools {
	sudo apt install pdfarranger
	sudo apt install pdfshuffler
}

function install_git {
	sudo apt install git
	echo "Git global config:"
	echo "git user.Name: "$(git config --global user.name $gitUserName)
	echo "git user.Email: "$(git config --global user.email $gitUserEmail)
	echo "git core.editor: vim"$(git config --global core.editor vim)
}

function install_audioTools {
	sudo apt install alsa-tools-gui
	sudo apt install jackd
	sudo apt install qjackctl
	sudo apt install puredata
	sudo apt install audacity
	sudo apt install kid3 kid3-qt
}

function install_kxstudio {
	sudo apt install apt-transport-https gpgv
	sudo dpkg --purge kxstudio-repos-gcc5
	cd ~/Downloads
	wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
	sudo dpkg -i kxstudio-repos_10.0.3_all.deb
	sudo apt update
	sudo apt install kxstudio-default-settings
	sudo apt install kxstudio-meta-all
	sudo apt install kstudio-meta-audio-plugins
	sudo apt install kstudio-meta-audio-plugins-lv2
	sudo apt install raysession
}

function install_digitalInstruments {
	sudo apt install aeolus
	sudo apt install foo-yc20 foo-yc20-vst
	sudo apt install hexter
	sudo apt install phasex
	sudo apt install qsynth
	sudo apt install yoshimi yoshimi-data yoshimi-doc
	sudo apt install fluidsynth fluidsynth-dssi libfluidsynth2 fluid-soundfont-gm
	sudo apt install petri-foo
}

function install_midiTools {
	sudo apt install jack-keyboard
	sudo apt install mcpdisp mcp-plugins
	sudo apt install qmidiarp qmidinet qmidiroute
	sudo apt install vkeybd
	sudo apt install musescore3
	sudo apt install impro-visor
}

function install_digitalAudioWorkstations {
	sudo apt install ardour
	sudo apt install lmms
	sudo apt install qtractor
}

function install_mixers {
	sudo apt install jack-mixer
	sudo apt install meterbridge
	sudo apt install qasmixer qasconfig qashctl qastools-common
	sudo apt install mixxx
}

function install_audioEffects {
	sudo apt install guitarix
	sudo apt install rakarrack
	sudo apt install jamin
	sudo apt install zita-ajbridge zita-at1 zita-mu1 zita-resampler zita-rev1
	sudo apt install sooperlooper
}

function install_videoTools {
	sudo apt install kdenlive
	sudo apt install synfigstudio
	sudo apt install slowmovideo
	sudo apt install subtitleeditor
	sudo apt install obs-studio
	sudo apt install xjadeo
}

function install_imageTools {
	sudo apt install gimp
	sudo apt install imagemagick
	sudo apt install darktable
	sudo apt install digikam
	sudo apt install rapid-photo-downloader
	sudo apt install hugin
	sudo apt install siril
}

function install_graphicalTools {
	sudo apt install inkscape
	sudo apt install krita
	sudo apt install mypaint
	sudo apt install gpick
	sudo apt install fontforge
}

function install_zoom {
	sudo apt install zoom
}

function install_xournal {
	sudo apt install xournal
}

function install_okular {
	sudo apt install okular
}

function install_thunderbird {
	sudo apt install thunderbird
}

function install_vlc {
	sudo apt install vlc
}

function install_unetbootin {
	sudo apt install unetbootin
}

function install_spotify {
	sudo snap install spotify
}

function install_steam {
	sudo apt install steam
}

function install_sqlite {
	sudo apt install sqlite3 sqlite3-doc
}

function install_figma {
	sudo apt install figma-linux
}

function install_skype {
	sudo snap install skype --classic
}

function install_i3 {
	sudo apt install i3
	sudo apt install feh
	sudo apt install arandr
	sudo apt install lxappearance
	sudo apt install dolphin
	echo "don't forget to install moka icons: https://snwh.org/moka/download"
	sudo apt install rofi
	sudo apt install compton
	sudo apt install i3blocks
	sudo apt install pavucontrol
}

function install_firmwareAtheros {
	sudo apt install firmware-atheros
}

function choose_packages_to_install {
	mandatoryPackages=("firefox" "fish" "vim" "xclip" "tig" "tree" "zip"
		"numlockx" "baobab" "gparted" "snapd" "curl" "wget" "openssh" "make" "git"
		"shortcuts" "pdfTools")
	optionalPackages=("firmwareAtheros" "i3" "virtualbox" "telegram" "discord" "python" "sqlite" "latex"
		"skype" "steam" "spotify" "unetbootin" "vlc" "thunderbird" "okular"
		"xournal" "zoom" "touchpad" "displaylink" "figma" "blender" "graphicalTools"
		"imageTools" "videoTools" "audioTools" "wacom" "virtualbox" "kxstudio"
		"digitalAudioWorkstations" "digitalInstruments" "audioEffects" "mixers"
		"midiTools" "sonicVisualiser")
	confirmSelection="n"
	while [[ "$confirmSelection" != "y" && "$confirmSelection" != "" ]]; do
		packagesToBeInstalled=${mandatoryPackages[@]}
		for i in ${optionalPackages[@]}; do
			echo "Do you want to install $i ? [Y/n]"
			read
			if [[ "$REPLY" != "n" && "$REPLY" != "N" ]]; then
				packagesToBeInstalled+=($i)
			fi
		done
		echo "I will install:"
		echo "${packagesToBeInstalled[@]}"
		echo "Do you confirm your choices? [y/n]"
		read confirmSelection
		if [[ "$confirmSelection" != "y" && "$confirmSelection" != "" ]]; then
			echo "Let's try again..."
		fi
	done
}

function setup_git_ssh {
	select gitSetupOption in "Remove_old_keys" "Create_new_key" "Copy_key" "Open_Github" "Open_Gitlab" "Continue"; do
		case $gitSetupOption in
			Remove_old_keys) rm ~/.ssh/*;;
			Create_new_key)
				ssh-keygen -t rsa -b 4096 -f ~/.ssh/git_rsa -C "$gitUserEmail"
				ssh-agent -s
				ssh-add ~/.ssh/git_rsa;;
			Copy_key)
				cat ~/.ssh/git_rsa.pub | xclip -sel clip
				echo "Go to your Github and Gitlab settings and paste the ssh key!";;
			Open_Github) firefox https://github.com/settings/keys &;;
			Open_Gitlab) firefox https://gitlab.com/-/profile/keys &;;
			Continue) break;;
		esac
	done
}

function install_packages {
	choose_packages_to_install
	echo "Installing selected packages."
	for package in ${packagesToBeInstalled[@]}; do
		install_$package
	done
}

function find_best_distro_mirror {
	distroName=$(lsb_release -i -s)
	if [ "$distroName" = "Debian" ]; then
		sudo apt install netselect-apt
		cd ~/Downloads
		netselect-apt -s -n
		sudo mv sources.list /etc/apt/sources.list
		sudo apt update
	fi
}

function add_user_to_sudoers {
	userName=$(whoami)
	echo "Checking if user is in the sudoers group."
	sudo -v
	if [ "$?" = "0" ]
	then 
		echo "$userName is already in the sudoers group"
	else 
		echo "$userName is not in the sudoers group. Let's put you:"
		su
		apt install sudo
		sudo usermod -a -G sudo $userName
		if [ "$?" = "0" ]
		then 
			echo "Success! The system needs to be restarted"
			echo "Restart now? [Y/n]"
			read
			if [[ "$REPLY" = "" || "$REPLY" = "Y" || "$REPLY" = "y" ]]
			then
				shutdown -r 0
			else
				exit 0
			fi
		else
			echo "Something went wrong =["
			exit 1
		fi
	fi
}

function backup {
	echo "Updating files in ~/Documents/REPOS/OUTILS/Laptop-Personalization/backupData"
	cd ~/Documents/REPOS/OUTILS/Laptop-Personalization/backupData
	find . -type f | while read fileName; do
		if [ "$fileName" != "./cloned-repos.txt" ]; then
			cp ~/"${fileName:2}" "$fileName"
		fi
	done
	clonedReposFile=~/Documents/REPOS/OUTILS/Laptop-Personalization/backupData/cloned-repos.txt
	cd ~/Documents/REPOS/
	echo "" > $clonedReposFile
	find . -type d | while read dirName; do
		if [ -d "$dirName"/.git ]; then
			echo "$dirName,$(git -C $dirName config --get remote.origin.url)" >> $clonedReposFile
		fi
	done
	echo "Would you like to commit your backupData folder? [Y/n]"
	read
	if [[ "$REPLY" != "n" && "$REPLY" != "N" ]]
	then
		cd ~/Documents/REPOS/OUTILS/Laptop-Personalization/backupData
		git add .
		git commit -m "updated backupData"
		git push origin master
	fi
}

function backdown {
	cd ~/Documents/REPOS/OUTILS/Laptop-Personalization/backupData
	cp -r ./* ~/
	rm ~/cloned-repos.txt
	echo "Restored config files!"
	tput setaf 2
	echo "Open another terminal and set the terminal font to DejaVu Sans Mono Nerd
	Font (if you haven't already)"
	tput setaf 7
	echo "Press [Enter] to continue"
	read
	while read clonedReposLine; do
		arrRepo=(${clonedReposLine//,/ })
		repoLocation=${arrRepo[0]}
		repoRemote=${arrRepo[1]}
		echo "Do you want to clone $repoRemote ? [Y/n]"
		read
		if [[ "$REPLY" != "n" && "$REPLY" != "N" ]]; then
			mkdir -p $repoLocation
			cd $repoLocation
			if [ ! "$(ls -A .)" ]; then
				git clone $repoRemote .
			fi
		fi
	done < ./cloned-repos.txt
}

function confirm_user_data {
	echo "git user.name: $gitUserName"
	echo "git user.email: $gitUserEmail"
	echo "laptop_personalization_repository_url: $laptop_personalization_repository_url"
	echo "Do you confirm your data above? [Y/n]"
	read
	if [[ "$REPLY" != "y" && "$REPLY" != "Y" && "$REPLY" != "" ]]; then
		echo "Aborting"
		exit 1
	fi
}

function setup_new_machine {
	echo "Which user?"
	select userOption in "andre" "gabi" "abort"; do
		case $userOption in
			andre)
				gitUserName="Andre Sbrocco"
				gitUserEmail="andresbrocco@gmail.com"
				laptop_personalization_repository_url="git@github.com:andresbrocco/Laptop-Personalization.git"
				confirm_user_data; break;;
			gabi)
				echo "Configure your personal variables inside this script, erase this line
				and come back" exit 1
				gitUserName="Gabriela Bittencourt"
				gitUserEmail="gabrielabittencourt00@gmail.com"
				laptop_personalization_repository_url=""
				confirm_user_data; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
	add_user_to_sudoers
	find_best_distro_mirror
	install_packages
	setup_git_ssh
	download_laptop_personalization_repository
	backdown
}

function check_if_all_REPOS_are_up_to_date {
	echo "Checking only repositories at ~/Documents/REPOS/"
	cd ~/Documents/REPOS/
	find . -type d | while read dirName; do
		if [ -d "$dirName"/.git ]; then
			git -C $dirName remote update > /dev/null
			repostatus=$(git -C $dirName status --short)
			if [ "$repostatus" != "" ]; then
				tput setaf 1
				echo "repository ~/Documents/REPOS/${dirName:2} is outdated"
				tput setaf 7
			else
				echo "repository ~/Documents/REPOS/${dirName:2} is up-to-date"
			fi
		fi
	done
}

function show_help {
	echo "This bash script has several utilities to help backup configuration
	data and set-up a new machine personalized for both Mozons. Carry this script
	within the OS pendrive, and run it after the OS installs"
}

while getopts :ht flag; do
	case $flag in
		h) show_help;;
		?) echo "Unknown flag $OPTARG.";;
	esac
done
if [ "$#" = "0" ]
then
	select menuOption in "setup_new_machine" "install_packages" "setup_git_ssh" "troubleshoot_hibernation" "backup" "backdown" "check_if_all_REPOS_are_up_to_date" "find_best_distro_mirror" "abort"; do
		case $menuOption in
			setup_new_machine) setup_new_machine; break;;
			install_packages) install_packages; break;;
			setup_git_ssh) setup_git_ssh; break;;
			troubleshoot_hibernation) troubleshoot_hibernation; break;;
			backup) backup; break;;
			backdown) backdown; break;;
			check_if_all_REPOS_are_up_to_date) check_if_all_REPOS_are_up_to_date; break;;
			find_best_distro_mirror) find_best_distro_mirror; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
fi
