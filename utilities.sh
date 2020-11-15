#!/bin/bash

# This bash script has several utilities to help set-up a new machine
# personalized for both Mozons. Carry this script within the OS pendrive, and
# run it after the OS installs

function download_laptop_personalization_repository {
	echo "Dowloading 'Laptop_Personalization' repository at
	$reposDir/OUTILS"
	mkdir -p $reposDir/OUTILS
	cd $reposDir/OUTILS
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
	sudo apt install nodejs -y
	sudo apt install npm -y
	sudo npm i -g bash-language-server
	sudo apt install libncurses-dev -y
	cd $userHome/Downloads
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
	sudo apt install texlive -y
	sudo apt install texlive-latex-extra -y
	sudo apt install texlive-lang-english -y
	sudo apt install texlive-lang-portuguese -y
	sudo apt install texlive-lang-french -y
	sudo apt install texlive-fonts-extra -y
	sudo apt install latexmk -y
}

function install_python {
	sudo apt install python3 -y
	sudo apt install python3-pip -y
	pip3 install notebook
	pip3 install pandas numpy scipy
	pip3 install matplotlib seaborn plotly
	pip3 install scikit-learn 
	pip3 install PyWavelets librosa
	pip3 install sympy
}

function install_opencv {
	tput setaf 1
	echo "This package takes time (20~30min)"
	tput setaf 7
	pip3 install opencv-python 
}

function install_discord {
	cd $userHome/Downloads
	sudo apt install libc++1 -y
	sudo apt install libappindicator1 -y
	wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	sudo dpkg -i /path/to/discord.deb
}

function install_telegram {
	sudo apt install telegram-desktop -y
}

function install_displaylink {
	echo "Installing DisplayLink-Debian"
	cd $userHome/Downloads/
	git clone https://github.com/AdnanHodzic/displaylink-debian.git
	cd displaylink-debian/
	sudo ./displaylink-debian.sh
	sudo rm /etc/X11/xorg.conf.d/20-displaylink.conf
}

function install_touchpad {
	sudo apt install xserver-xorg-input-synaptics -y
	sudo apt install xserver-xorg-input-libinput -y
	sudo apt install xserver-xorg-input-evdev -y
	sudo apt install xserver-xorg-input-mouse -y
}

function install_firefox {
	sudo apt install firefox -y
	tput setaf 2
	echo "While I do my work, you could log-in to your firefox account!"
	tput setaf 7
	echo "Press [Enter] to continue"
	read
}

function install_fish {
	sudo apt install fish -y
	sudo chsh -s /usr/bin/fish
	fish -c "set -U fish_user_paths $userHome/.local/bin"
}

function install_xclip {
	sudo apt install xclip -y
}

function install_tig {
	sudo apt install tig -y
}

function install_tree {
	sudo apt install tree -y
}

function install_zip {
	sudo apt install zip -y
}

function install_numlockx {
	sudo apt install numlockx -y
}

function install_baobab {
	sudo apt install baobab -y
}

function install_gparted {
	sudo apt install gparted -y
}

function install_snapd {
	sudo apt install snapd -y
}

function install_curl {
	sudo apt install curl -y
}

function install_wget {
	sudo apt install wget -y
}

function install_openssh {
	sudo apt install openssh-server -y
}

function install_make {
	sudo apt install build-essential -y
}

function install_virtualbox {
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
	echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
	sudo apt update -y
	sudo apt install virtualbox-6.1 -y
}

function install_sonicVisualiser {
	sudo apt install sonic-visualiser -y
}

function install_blender {
	sudo apt install blender
}

function install_wacom {
	sudo apt install xserver-xorg-input-wacom -y
	sudo apt install libwacom2 -y
	sudo apt install libwacom-common -y
	sudo apt install libwacom-bin -y
}

function install_pdfTools {
	sudo apt install pdfarranger -y
	sudo apt install pdfshuffler -y
}

function install_git {
	sudo apt install git -y
	echo "Git global config:"
	echo "git user.Name: "$(git config --global user.name $gitUserName)
	echo "git user.Email: "$(git config --global user.email $gitUserEmail)
	echo "git core.editor: vim"$(git config --global core.editor vim)
}

function install_audioTools {
	sudo apt install alsa-tools-gui -y
	sudo apt install jackd -y
	sudo apt install qjackctl -y
	sudo apt install puredata -y
	sudo apt install audacity -y
	sudo apt install kid3 -y
	sudo apt install kid3-qt -y
}

function install_kxstudio {
	sudo apt install apt-transport-https -y
	sudo apt install gpgv -y
	sudo dpkg --purge kxstudio-repos-gcc5
	cd $userHome/Downloads
	wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
	sudo dpkg -i kxstudio-repos_10.0.3_all.deb
	sudo apt update -y
	sudo apt install kxstudio-default-settings -y
	sudo apt install kxstudio-meta-all -y
	sudo apt install kstudio-meta-audio-plugins -y
	sudo apt install kstudio-meta-audio-plugins-lv2 -y
	sudo apt install raysession -y
}

function install_digitalInstruments {
	sudo apt install aeolus -y
	sudo apt install foo-yc20 -y
	sudo apt install foo-yc20-vst -y
	sudo apt install hexter -y
	sudo apt install phasex -y
	sudo apt install qsynth -y
	sudo apt install yoshimi -y
	sudo apt install yoshimi-data -y
	sudo apt install yoshimi-doc -y
	sudo apt install fluidsynth -y
	sudo apt install fluidsynth-dssi -y
	sudo apt install libfluidsynth2 -y
	sudo apt install fluid-soundfont-gm -y
	sudo apt install petri-foo -y
}

function install_midiTools {
	sudo apt install jack-keyboard -y
	sudo apt install mcpdisp -y
	sudo apt install mcp-plugins -y
	sudo apt install qmidiarp -y
	sudo apt install qmidinet -y
	sudo apt install qmidiroute -y
	sudo apt install vkeybd -y
	sudo apt install musescore3 -y
	sudo apt install impro-visor -y
}

function install_digitalAudioWorkstations {
	sudo apt install ardour -y
	sudo apt install lmms -y
	sudo apt install qtractor -y
}

function install_mixers {
	sudo apt install jack-mixer -y
	sudo apt install meterbridge -y
	sudo apt install qasmixer -y
	sudo apt install qasconfig -y
	sudo apt install qashctl -y
	sudo apt install qastools-common -y
	sudo apt install mixxx -y
}

function install_audioEffects {
	sudo apt install guitarix -y
	sudo apt install rakarrack -y
	sudo apt install jamin -y
	sudo apt install zita-ajbridge -y
	sudo apt install zita-at1 -y
	sudo apt install zita-mu1 -y
	sudo apt install zita-resampler -y
	sudo apt install zita-rev1 -y
	sudo apt install sooperlooper -y
}

function install_videoTools {
	sudo apt install kdenlive -y
	sudo apt install synfigstudio -y
	sudo apt install slowmovideo -y
	sudo apt install subtitleeditor -y
	sudo apt install obs-studio -y
	sudo apt install xjadeo -y
}

function install_imageTools {
	sudo apt install gimp -y
	sudo apt install imagemagick -y
	sudo apt install darktable -y
	sudo apt install digikam -y
	sudo apt install rapid-photo-downloader -y
	sudo apt install hugin -y
	sudo apt install siril -y
}

function install_graphicalTools {
	sudo apt install inkscape -y
	sudo apt install krita -y
	sudo apt install mypaint -y
	sudo apt install gpick -y
	sudo apt install fontforge -y
}

function install_zoom {
	sudo apt install zoom -y
}

function install_xournal {
	sudo apt install xournal -y
}

function install_okular {
	sudo apt install okular -y
}

function install_thunderbird {
	sudo apt install thunderbird -y
}

function install_vlc {
	sudo apt install vlc -y
}

function install_unetbootin {
	sudo apt install unetbootin -y
}

function install_spotify {
	sudo snap install spotify
}

function install_steam {
	sudo apt install steam -y
}

function install_sqlite {
	sudo apt install sqlite3 -y
	sudo apt install sqlite3-doc -y
}

function install_figma {
	sudo apt install figma-linux -y
}

function install_htop {
	sudo apt install htop
}

function install_skype {
	sudo snap install skype --classic
}

function install_i3 {
	sudo apt install i3 -y
	sudo apt install feh -y
	sudo apt install arandr -y
	sudo apt install lxappearance -y
	sudo apt install dolphin -y
	echo "don't forget to install moka icons: https://snwh.org/moka/download"
	sudo apt install rofi -y
	sudo apt install compton -y
	sudo apt install i3blocks -y
	sudo apt install pavucontrol -y
}

function install_firmwareAtheros {
	sudo apt install firmware-atheros -y
}

function choose_packages_to_install {
	confirmSelection="n"
	while [[ "$confirmSelection" != "y" && "$confirmSelection" != "" ]]; do
		packagesToBeInstalled=()
		for i in $availablePackages[@]; do
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
	select gitSetupOption in "Remove_old_keys" "Create_new_key" "Copy_key" "Open_Github" "Open_Gitlab" "Test_authentication" "Continue"; do
		case $gitSetupOption in
			Remove_old_keys) rm $userHome/.ssh/*;;
			Create_new_key)
				ssh-keygen -t rsa -b 4096 -f $userHome/.ssh/id_rsa -C "$gitUserEmail"
				ssh-agent -s
				ssh-add $userHome/.ssh/id_rsa;;
			Copy_key)
				cat $userHome/.ssh/id_rsa.pub | xclip -sel clip
				echo "Go to your Github and Gitlab settings and paste the ssh key!";;
			Open_Github) firefox https://github.com/settings/keys &;;
			Open_Gitlab) firefox https://gitlab.com/-/profile/keys &;;
			Test_authentication) ssh -T git@github.com;;
			Continue) break;;
		esac
	done
}

function install_one_package {
	tput setaf 2
	echo "Which package do you want to install?"
	tput setaf 7
	select package in ${availablePackages[@]} "exit"; do
		case $package in
			exit) sudo apt autoremove -y; exit 0;;
		esac
		tput setaf 2
		echo "Installing $package"
		tput setaf 7
		install_$package
	done
}

function install_packages {
	choose_packages_to_install
	echo "Please, enter the root password (not the user, THE ROOT)"
	su
	echo "Updating and Upgrading apt"
	sudo apt update -y
	sudo apt upgrade -y
	echo "Installing selected packages."
	for package in ${packagesToBeInstalled[@]}; do
		tput setaf 2
		echo "Installing $package"
		tput setaf 7
		install_$package
	done
	sudo apt autoremove -y
}

function find_best_distro_mirror {
	distroName=$(lsb_release -i -s)
	if [ "$distroName" = "Debian" ]; then
		sudo apt install netselect-apt -y
		cd $userHome/Downloads
		sudo netselect-apt -s -n
		sudo mv sources.list /etc/apt/sources.list
		sudo apt update -y
	fi
}

function change_su_password {
	sudo passwd
}

function add_user_to_sudoers {
	userName=$(whoami)
	echo "Checking if $userName is in the sudoers group."
	sudo -v
	if [ "$?" = "0" ]
	then 
		echo "$userName is already in the sudoers group"
	else 
		echo "$userName is not in the sudoers group. Let's put you:"
		su
		apt install sudo -y
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
	echo "Updating files in $reposDir/OUTILS/Laptop-Personalization/backupData"
	cd $reposDir/OUTILS/Laptop-Personalization/backupData
	find . -type f | while read fileName; do
		if [ "$fileName" != "./cloned-repos.txt" ]; then
			cp $userHome/"${fileName:2}" "$fileName"
		fi
	done
	clonedReposFile=$reposDir/OUTILS/Laptop-Personalization/backupData/cloned-repos.txt
	cd $reposDir/
	> $clonedReposFile
	find . -type d | while read dirName; do
		if [ -d "$dirName"/.git ]; then
			echo "$dirName,$(git -C $dirName config --get remote.origin.url)" >> $clonedReposFile
		fi
	done
	echo "Would you like to commit your backupData folder? [Y/n]"
	read
	if [[ "$REPLY" != "n" && "$REPLY" != "N" ]]
	then
		cd $reposDir/OUTILS/Laptop-Personalization/backupData
		git add .
		git commit -m "updated backupData"
		git push origin master
	fi
}

function backdown {
	cd $reposDir/OUTILS/Laptop-Personalization/backupData
	cp -r ./ $userHome/
	rm $userHome/cloned-repos.txt
	echo "Restored config files!"
	tput setaf 2
	echo "Open another terminal and set the terminal font to DejaVu Sans Mono Nerd
	Font (if you haven't already)"
	tput setaf 7
	echo "Press [Enter] to continue"
	read
	repoLocation=()
	repoRemote=()
	i=1
	while read clonedReposLine; do
		arrRepo=(${clonedReposLine//,/ })
		repoLocation[$i]=$reposDir/${arrRepo[0]:2}
		repoRemote[$i]=${arrRepo[1]}
		((i+=1))
	done < ./cloned-repos.txt
	while [ $i -gt 1 ]; do
		((i+=-1))
		if [ -d ${repoLocation[$i]}/.git ]; then
			echo "Repo ${repoRemote[$i]} is already cloned inside ${repoLocation[$i]}"
			continue
		fi
		echo "Do you want to clone ${repoRemote[$i]} " 
		echo "inside ${repoLocation[$i]} ? [Y/n]"
		read
		if [[ "$REPLY" != "n" && "$REPLY" != "N" ]]; then
			mkdir -p ${repoLocation[$i]}
			cd ${repoLocation[$i]}
			if [ ! "$(ls -A .)" ]; then
				git clone ${repoRemote[$i]} .
			fi
		fi
	done
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
	find_best_distro_mirror
	install_packages
	setup_git_ssh
	download_laptop_personalization_repository
	backdown
}

function check_if_all_REPOS_are_up_to_date {
	echo "Checking only repositories at $reposDir/"
	cd $reposDir/
	find . -type d | while read dirName; do
		if [ -d "$dirName"/.git ]; then
			git -C $dirName remote update > /dev/null
			repostatus=$(git -C $dirName status --short)
			if [ "$repostatus" != "" ]; then
				tput setaf 1
				echo "repository $reposDir/${dirName:2} is outdated"
				tput setaf 7
			else
				echo "repository $reposDir/${dirName:2} is up-to-date"
			fi
		fi
	done
}

function show_help {
	echo "This bash script has several utilities to help backup configuration
	data and set-up a new machine personalized for both Mozons. Carry this script
	within the OS pendrive, and run it after the OS installs"
}

availablePackages=("firefox" "git" "make" "curl" "wget" "snapd" "fish" "vim"
	"xclip" "tig" "tree" "zip" "numlockx" "baobab" "gparted" "openssh"
	"shortcuts" "pdfTools" "firmwareAtheros" "i3" "virtualbox" "telegram"
	"discord" "python" "opencv" "sqlite" "latex" "skype" "steam" "spotify"
	"unetbootin" "vlc" "thunderbird" "okular" "xournal" "zoom" "touchpad" "htop"
	"displaylink" "figma" "blender" "graphicalTools" "imageTools" "videoTools"
	"audioTools" "wacom" "kxstudio" "digitalAudioWorkstations"
	"digitalInstruments" "audioEffects" "mixers" "midiTools" "sonicVisualiser")

while getopts :ht flag; do
	case $flag in
		h) show_help;;
		?) echo "Unknown flag $OPTARG.";;
	esac
done
if [ "$#" = "0" ]
then
	if [ ${EUID} -eq 0 ]; then
		echo "Don't run me as root!"
		exit 1
	fi
	userHome=$(cd ~/ && pwd)
	reposDir=$userHome/Documents/REPOS
	echo $userHome
	select menuOption in "setup_new_machine" "install_packages" "install_one_package" "setup_git_ssh" "troubleshoot_hibernation" "backup" "backdown" "check_if_all_REPOS_are_up_to_date" "find_best_distro_mirror" "change_su_password" "abort"; do
		case $menuOption in
			setup_new_machine) setup_new_machine; break;;
			install_packages) install_packages; break;;
			install_one_package) install_one_package; break;;
			setup_git_ssh) setup_git_ssh; break;;
			troubleshoot_hibernation) troubleshoot_hibernation; break;;
			backup) backup; break;;
			backdown) backdown; break;;
			check_if_all_REPOS_are_up_to_date) check_if_all_REPOS_are_up_to_date; break;;
			find_best_distro_mirror) find_best_distro_mirror; break;;
			change_su_password) change_su_password; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
fi
