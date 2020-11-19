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
	# To enable hibernation, just copy the UUID of the swap partition (found in
	# the file /etc/fstab) and place it in the grub config /etc/default/grub:
	# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash
	# resume=UUID=d5e18cd2-498d-449f-9c8f-abf95162a5af"
	install_hibernation
	if [ "$(cat /sys/power/state)" = "freeze mem disk" ]; then
		echo "Your system supports hibernation"
		swapUUID=$(echo $sudoPW | sudo -S blkid -l -t TYPE=swap -o export | sed -n '2p')
		echo "UUID of swap partition: $swapUUID"
		echo $swapUUID | xclip -sel clip
		echo "add resume=<ctrl+shift+v> at the end of the variable GRUB_CMDLINE_LINUX_DEFAULT"
		echo "it should look like:"
		echo GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash resume=UUID=d5e18cd2-498d-449f-9c8f-abf95162a5af\"
		gnome-terminal -- bash -c "sudo vim /etc/default/grub;"
		# echo "Also, make sure the following line is uncommented:"
		# echo "GRUB_RECORDFAIL_TIMEOUT=0"
		echo "Come back when you are done, and press <Enter>"
		read
		echo $sudoPW | sudo -S update-grub
		echo "If everything went well, you can hibernate by calling 'sudo systemctl
		hibernate'"
		exit 0
	else
		echo "Your system does not support hibernation... =["
	fi
}

function install_vim {
	echo $sudoPW | sudo -S apt install nodejs -y
	# echo $sudoPW | sudo -S apt install npm -y
	curl -sL install-node.now.sh/lts | echo $sudoPW | sudo -S bash
	echo $sudoPW | sudo -S npm i -g bash-language-server
	echo $sudoPW | sudo -S apt install libncurses-dev -y
	cd $userHome/Downloads
	git clone https://github.com/vim/vim.git
	cd vim/src
	make
	echo $sudoPW | sudo -S make install
}

function install_hibernation {
	echo $sudoPW | sudo -S apt install pm-utils hibernate
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
	echo $sudoPW | sudo -S apt install texlive -y
	echo $sudoPW | sudo -S apt install texlive-latex-extra -y
	echo $sudoPW | sudo -S apt install texlive-lang-english -y
	echo $sudoPW | sudo -S apt install texlive-lang-portuguese -y
	echo $sudoPW | sudo -S apt install texlive-lang-french -y
	echo $sudoPW | sudo -S apt install texlive-fonts-extra -y
	echo $sudoPW | sudo -S apt install latexmk -y
}

function install_python {
	echo $sudoPW | sudo -S apt install python3 -y
	echo $sudoPW | sudo -S apt install python3-pip -y
	pip3 install notebook
	pip3 install pandas numpy scipy
	pip3 install matplotlib seaborn plotly
	pip3 install scikit-learn 
	pip3 install PyWavelets 
	#pip3 install librosa
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
	echo $sudoPW | sudo -S apt install libc++1 -y
	echo $sudoPW | sudo -S apt install libappindicator1 -y
	wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	echo $sudoPW | sudo -S dpkg -i discord.deb
}

function install_telegram {
	echo $sudoPW | sudo -S apt install telegram-desktop -y
}

function install_displaylink {
	if [ "$distroName" != "Debian" ]; then
		echo "Installing DisplayLink-Debian"
		cd $userHome/Downloads/
		git clone https://github.com/AdnanHodzic/displaylink-debian.git
		cd displaylink-debian/
		echo $sudoPW | sudo -S ./displaylink-debian.sh --install
		echo $sudoPW | sudo -S rm /etc/X11/xorg.conf.d/20-displaylink.conf
	else
		echo "Download displaylink from the official repo instead!"
	fi
}

function install_touchpad {
	echo $sudoPW | sudo -S apt install xserver-xorg-input-synaptics -y
	echo $sudoPW | sudo -S apt install xserver-xorg-input-libinput -y
	echo $sudoPW | sudo -S apt install xserver-xorg-input-evdev -y
	echo $sudoPW | sudo -S apt install xserver-xorg-input-mouse -y
}

function install_firefox {
	echo $sudoPW | sudo -S apt install firefox -y
	tput setaf 2
	echo "While I do my work, you could log-in to your firefox account!"
	tput setaf 7
	echo "Press [Enter] to continue"
	read
}

function install_hugo {
	echo $sudoPW | sudo -S apt install hugo
}

function install_fish {
	echo $sudoPW | sudo -S apt install fish -y
	echo "Setting fish as default terminal:"
	chsh -s `which fish`
	fish -c "set -U fish_user_paths $userHome/.local/bin"
	echo "It will only take effect after logout."
}

function install_xclip {
	echo $sudoPW | sudo -S apt install xclip -y
}

function install_tig {
	echo $sudoPW | sudo -S apt install tig -y
}

function install_pciutils {
    echo $sudoPW | sudo -S apt install pciutils -y
}
function install_tree {
	echo $sudoPW | sudo -S apt install tree -y
}

function install_zip {
	echo $sudoPW | sudo -S apt install zip -y
}

function install_numlockx {
	echo $sudoPW | sudo -S apt install numlockx -y
}

function install_baobab {
	echo $sudoPW | sudo -S apt install baobab -y
}

function install_gparted {
	echo $sudoPW | sudo -S apt install gparted -y
}

function install_snapd {
	echo $sudoPW | sudo -S apt install snapd -y
}

function install_curl {
	echo $sudoPW | sudo -S apt install curl -y
}

function install_wget {
	echo $sudoPW | sudo -S apt install wget -y
}

function install_openssh {
	echo $sudoPW | sudo -S apt install openssh-server -y
}

function install_make {
	echo $sudoPW | sudo -S apt install build-essential -y
}

function install_virtualbox {
	if [ "$distroName" != "Debian" ]; then
		echo "It's not Debian... Will not install virtualbox..."
	else
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
		echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
		echo $sudoPW | sudo -S apt update -y
		echo $sudoPW | sudo -S apt install virtualbox-6.1 -y
	fi
}

function install_sonicVisualiser {
	echo $sudoPW | sudo -S apt install sonic-visualiser -y
}

function install_blender {
	echo $sudoPW | sudo -S apt install blender
}

function install_wacom {
	echo $sudoPW | sudo -S apt install xserver-xorg-input-wacom -y
	echo $sudoPW | sudo -S apt install libwacom2 -y
	echo $sudoPW | sudo -S apt install libwacom-common -y
	echo $sudoPW | sudo -S apt install libwacom-bin -y
}

function install_pdfTools {
	echo $sudoPW | sudo -S apt install pdfarranger -y
	echo $sudoPW | sudo -S apt install pdfshuffler -y
	echo $sudoPW | sudo -S apt install okular -y
	echo $sudoPW | sudo -S apt install evince -y
	echo $sudoPW | sudo -S apt install xournal -y
}

function install_git {
	echo $sudoPW | sudo -S apt install git -y
	echo "Git global config:"
	echo "git user.Name: "$(git config --global user.name $gitUserName)
	echo "git user.Email: "$(git config --global user.email $gitUserEmail)
	echo "git core.editor: vim"$(git config --global core.editor vim)
}

function install_audioTools {
	echo $sudoPW | sudo -S apt install alsa-tools-gui -y
	echo $sudoPW | sudo -S apt install jackd -y
	echo $sudoPW | sudo -S apt install qjackctl -y
	echo $sudoPW | sudo -S apt install puredata -y
	echo $sudoPW | sudo -S apt install audacity -y
	echo $sudoPW | sudo -S apt install kid3 -y
	echo $sudoPW | sudo -S apt install kid3-qt -y
}

function install_kxstudio {
	echo $sudoPW | sudo -S apt install apt-transport-https -y
	echo $sudoPW | sudo -S apt install gpgv -y
	echo $sudoPW | sudo -S dpkg --purge kxstudio-repos-gcc5
	cd $userHome/Downloads
	wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
	echo $sudoPW | sudo -S dpkg -i kxstudio-repos_10.0.3_all.deb
	echo $sudoPW | sudo -S apt update -y
	echo $sudoPW | sudo -S apt install kxstudio-default-settings -y
	echo $sudoPW | sudo -S apt install kxstudio-meta-all -y
	echo $sudoPW | sudo -S apt install kxstudio-meta-audio-plugins -y
	echo $sudoPW | sudo -S apt install kxstudio-meta-audio-plugins-lv2 -y
	install_raysession
}

function install_raysession {
    echo $sudoPW | sudo -S apt-get install python3-pyqt5 pyqt5-dev-tools qtchooser qt5-default qttools5-dev-tools
    cd $userHome/Downloads/
    git clone https://github.com/Houston4444/RaySession.git
    cd RaySession/
    make
    echo $sudoPW | sudo -S make install
}

function install_digitalInstruments {
	echo $sudoPW | sudo -S apt install aeolus -y
	echo $sudoPW | sudo -S apt install foo-yc20 -y
	echo $sudoPW | sudo -S apt install foo-yc20-vst -y
	echo $sudoPW | sudo -S apt install hexter -y
	echo $sudoPW | sudo -S apt install phasex -y
	echo $sudoPW | sudo -S apt install qsynth -y
	echo $sudoPW | sudo -S apt install yoshimi -y
	echo $sudoPW | sudo -S apt install yoshimi-data -y
	echo $sudoPW | sudo -S apt install yoshimi-doc -y
	echo $sudoPW | sudo -S apt install fluidsynth -y
	echo $sudoPW | sudo -S apt install fluidsynth-dssi -y
	echo $sudoPW | sudo -S apt install libfluidsynth2 -y
	echo $sudoPW | sudo -S apt install fluid-soundfont-gm -y
	echo $sudoPW | sudo -S apt install petri-foo -y
}

function install_midiTools {
	echo $sudoPW | sudo -S apt install jack-keyboard -y
	echo $sudoPW | sudo -S apt install mcpdisp -y
	echo $sudoPW | sudo -S apt install mcp-plugins -y
	echo $sudoPW | sudo -S apt install qmidiarp -y
	echo $sudoPW | sudo -S apt install qmidinet -y
	echo $sudoPW | sudo -S apt install qmidiroute -y
	echo $sudoPW | sudo -S apt install vkeybd -y
	echo $sudoPW | sudo -S apt install musescore3 -y
	echo $sudoPW | sudo -S apt install impro-visor -y
}

function install_digitalAudioWorkstations {
	echo $sudoPW | sudo -S apt install ardour -y
	echo $sudoPW | sudo -S apt install lmms -y
	echo $sudoPW | sudo -S apt install qtractor -y
}

function install_mixers {
	echo $sudoPW | sudo -S apt install jack-mixer -y
	echo $sudoPW | sudo -S apt install meterbridge -y
	echo $sudoPW | sudo -S apt install qasmixer -y
	echo $sudoPW | sudo -S apt install qasconfig -y
	echo $sudoPW | sudo -S apt install qashctl -y
	echo $sudoPW | sudo -S apt install qastools-common -y
	echo $sudoPW | sudo -S apt install mixxx -y
}

function install_audioEffects {
	echo $sudoPW | sudo -S apt install guitarix -y
	echo $sudoPW | sudo -S apt install rakarrack -y
	echo $sudoPW | sudo -S apt install jamin -y
	echo $sudoPW | sudo -S apt install zita-ajbridge -y
	echo $sudoPW | sudo -S apt install zita-at1 -y
	echo $sudoPW | sudo -S apt install zita-mu1 -y
	echo $sudoPW | sudo -S apt install zita-resampler -y
	echo $sudoPW | sudo -S apt install zita-rev1 -y
	echo $sudoPW | sudo -S apt install sooperlooper -y
}

function install_videoTools {
	echo $sudoPW | sudo -S apt install kdenlive -y
	echo $sudoPW | sudo -S apt install synfigstudio -y
	echo $sudoPW | sudo -S apt install slowmovideo -y
	echo $sudoPW | sudo -S apt install subtitleeditor -y
	echo $sudoPW | sudo -S apt install obs-studio -y
	echo $sudoPW | sudo -S apt install xjadeo -y
	echo $sudoPW | sudo -S apt install vlc -y
}

function install_imageTools {
	echo $sudoPW | sudo -S apt install gimp -y
	echo $sudoPW | sudo -S apt install imagemagick -y
	echo $sudoPW | sudo -S apt install darktable -y
	echo $sudoPW | sudo -S apt install digikam -y
	echo $sudoPW | sudo -S apt install rapid-photo-downloader -y
	echo $sudoPW | sudo -S apt install hugin -y
	echo $sudoPW | sudo -S apt install siril -y
}

function install_graphicalTools {
	echo $sudoPW | sudo -S apt install inkscape -y
	echo $sudoPW | sudo -S apt install krita -y
	echo $sudoPW | sudo -S apt install mypaint-data -y
	echo $sudoPW | sudo -S apt install mypaint -y
	echo $sudoPW | sudo -S apt install gpick -y
	echo $sudoPW | sudo -S apt install fontforge -y
}

function install_zoom {
	echo $sudoPW | sudo -S apt install zoom -y
}

function install_thunderbird {
	echo $sudoPW | sudo -S apt install thunderbird -y
}

function install_unetbootin {
	echo $sudoPW | sudo -S apt install unetbootin -y
}

function install_spotify {
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	echo $sudoPW | sudo -S apt-get update
	echo $sudoPW | sudo -S apt-get install spotify-client
}

function install_steam {
	echo $sudoPW | sudo -S dpkg --add-architecture i386
	echo $sudoPW | sudo -S apt update -y
	echo $sudoPW | sudo -S apt install steam -y
	echo $sudoPW | sudo -S apt install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
}

function install_sqlite {
	echo $sudoPW | sudo -S apt install sqlite3 -y
	echo $sudoPW | sudo -S apt install sqlite3-doc -y
}

#function install_figma {
#	echo $sudoPW | sudo -S apt install figma-linux -y
#}

function install_htop {
	echo $sudoPW | sudo -S apt install htop
}

function install_skype {
	echo $sudoPW | sudo -S snap install skype --classic
}

function install_light {
	cd ~/Downloads
	git clone git@github.com:haikarainen/light.git
	cd light
	./autogen.sh
	./configure && make
	echo $sudoPW | sudo -S make install
}

function install_i3 {
	install_light
	echo $sudoPW | sudo -S apt install alsa-utils -y
	echo $sudoPW | sudo -S apt install qasmixer -y
	# echo $sudoPW | sudo -S apt install xbacklight -y # does not work!
	# echo $sudoPW | sudo -S ln -s /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight  /sys/class/backlight
	echo $sudoPW | sudo -S apt install blueman -y
	echo $sudoPW | sudo -S apt install pulseaudio-module-bluetooth -y
	echo $sudoPW | sudo -S apt install i3 -y
	echo $sudoPW | sudo -S apt install feh -y
	echo $sudoPW | sudo -S apt install arandr -y
	echo $sudoPW | sudo -S apt install lxappearance -y
	echo "Open lxappearance to change the gtk theme to a dark one"
	echo $sudoPW | sudo -S apt install dolphin -y
	echo $sudoPW | sudo -S apt install rofi -y
	echo $sudoPW | sudo -S apt install compton -y
	echo $sudoPW | sudo -S apt install i3blocks -y
	echo $sudoPW | sudo -S apt install pavucontrol -y
}

function install_firmwareAtheros {
	echo $sudoPW | sudo -S apt install firmware-atheros -y
}

function choose_packages_to_install {
	confirmSelection="n"
	while [[ "$confirmSelection" != "y" && "$confirmSelection" != "" ]]; do
		packagesToBeInstalled=()
		for i in ${availablePackages[@]}; do
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
			Remove_old_keys) rm $userHome/.ssh/*; echo "Removed!";;
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
			exit) echo $sudoPW | sudo -S apt autoremove -y; exit 0;;
		esac
		tput setaf 2
		echo "Installing $package"
		tput setaf 7
		install_$package
	done
}

function install_packages {
	choose_packages_to_install
	echo "Updating and Upgrading apt"
	echo $sudoPW | sudo -S apt update -y
	echo $sudoPW | sudo -S apt upgrade -y
	echo "Installing selected packages."
	for package in ${packagesToBeInstalled[@]}; do
		tput setaf 2
		echo "Installing $package"
		tput setaf 7
		install_$package
	done
	echo $sudoPW | sudo -S apt autoremove -y
}

function find_best_distro_mirror {
	if [ "$distroName" = "Debian" ]; then
		echo $sudoPW | sudo -S apt update -y
		echo $sudoPW | sudo -S apt upgrade -y
		echo $sudoPW | sudo -S apt install netselect-apt -y
		cd $userHome/Downloads
		echo $sudoPW | sudo -S netselect-apt -s -n
		echo $sudoPW | sudo -S mv sources.list /etc/apt/sources.list
		echo $sudoPW | sudo -S apt update -y
	fi
}

function change_su_password {
	echo $sudoPW | sudo -S passwd
}

function add_user_to_sudoers {
	userName=$(whoami)
	echo "Checking if $userName is in the sudoers group."
	echo $sudoPW | sudo -S -v
	if [ "$?" = "0" ]
	then 
		echo "$userName is already in the sudoers group"
	else 
		echo "$userName is not in the sudoers group. Let's put you:"
		su
		apt install sudo -y
		echo $sudoPW | sudo -S usermod -a -G sudo $userName
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
	echo "keyboardModel: $keyboardModel"
	echo "keyboardLayout: $keyboardLayout"
	echo "Do you confirm your data above? [Y/n]"
	read
	if [[ "$REPLY" != "y" && "$REPLY" != "Y" && "$REPLY" != "" ]]; then
		echo "Aborting"
		exit 1
	fi
}

function configure_keyboard_layout {
	echo $sudoPW | sudo -S setxkbmap -model $keyboardModel -layout $keyboardLayout
	echo $sudoPW | sudo -S localectl --no-convert set-x11-keymap $keyboardLayout $keyboardModel
}

function prompt_which_user {
    echo "Which user?"
	select userOption in "andre" "gabi" "abort"; do
		case $userOption in
			andre)
				gitUserName="Andre Sbrocco"
				gitUserEmail="andresbrocco@gmail.com"
				laptop_personalization_repository_url="git@github.com:andresbrocco/Laptop-Personalization.git"
				keyboardModel="pc101"
				keyboardLayout="eu"
				confirm_user_data; break;;
			gabi)
				echo "Configure your personal variables inside this script, erase this line
				and come back" exit 1
				gitUserName="Gabriela Bittencourt"
				gitUserEmail="gabrielabittencourt00@gmail.com"
				laptop_personalization_repository_url=""
				keyboardModel="pc105"
				keyboardLayout="br"
				confirm_user_data; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
}

function setup_new_machine {
	configure_keyboard_layout
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

availablePackages=("hibernation" "firefox" "git" "make" "curl" "wget" "snapd" "fish" "vim"
	"xclip" "tig" "tree" "zip" "hugo" "numlockx" "baobab" "gparted" "openssh"
	"shortcuts" "pdfTools" "firmwareAtheros" "i3" "virtualbox" "telegram"
	"discord" "python" "opencv" "sqlite" "latex" "skype" "steam" "spotify" "pciutils"
	"unetbootin" "thunderbird" "zoom" "touchpad" "htop"
	"displaylink" "blender" "graphicalTools" "imageTools" "videoTools"
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
	echo "Make sure you have internet connection!"
	prompt_which_user
	read -s -p "Enter Password for sudo: " sudoPW
	echo ""
	distroName=$(lsb_release -i -s)
	userHome=$(cd ~/ && pwd)
	reposDir=$userHome/Documents/REPOS
	select menuOption in "setup_new_machine" "install_packages" "install_one_package" "setup_git_ssh" "troubleshoot_hibernation" "download_laptop_personalization_repository" "backup" "backdown" "check_if_all_REPOS_are_up_to_date" "find_best_distro_mirror" "configure_keyboard_layout" "change_su_password" "abort"; do
		case $menuOption in
			setup_new_machine) setup_new_machine; break;;
			install_packages) install_packages; break;;
			install_one_package) install_one_package; break;;
			setup_git_ssh) setup_git_ssh; break;;
			troubleshoot_hibernation) troubleshoot_hibernation; break;;
			download_laptop_personalization_repository) download_laptop_personalization_repository; break;;
			backup) backup; break;;
			backdown) backdown; break;;
			check_if_all_REPOS_are_up_to_date) check_if_all_REPOS_are_up_to_date; break;;
			find_best_distro_mirror) find_best_distro_mirror; break;;
			configure_keyboard_layout) configure_keyboard_layout; break;;
			change_su_password) change_su_password; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
fi
