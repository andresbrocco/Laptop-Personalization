#!/bin/bash

# This bash script has several utilities to help set-up a new machine
# personalized for both Mozons. Carry this script within the OS pendrive, and
# run it after the OS installs

function add_user_to_sudoers {
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
			read restartNow
			if [[ "$restartNow" = "" || "$restartNow" = "Y" || "$restartNow" = "y" ]]
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

function install_better_touchpad_config {
	sudo apt install xserver-xorg-input-synaptics
	sudo apt install xserver-xorg-input-libinput
	sudo apt install xserver-xorg-input-evdev
	sudo apt install xserver-xorg-input-mouse
}

function setup_latex {
	sudo apt install texlive
	sudo apt install texlive-latex-extra
	sudo apt install texlive-lang-english
	sudo apt install texlive-lang-portuguese
	sudo apt install texlive-lang-french
	sudo apt install texlive-fonts-extra
	sudo apt install latexmk
}

function download_laptop_personalization_repository {
	mkdir -p ~/Documents/REPOS/OUTILS
	cd ~/Documents/REPOS/OUTILS
	git clone $laptop_personalization_repository_url
	backdown
	echo "Open another terminal and set the terminal font to DejaVu Sans Mono Nerd
	Font (if you haven't already)"
	echo "Press [Enter] to continue"
	read garbage
}

function setup_vim {
	cd ~/Downloads
	git clone https://github.com/vim/vim.git
	cd vim/src
	make
	sudo make install
}

function setup_move_to_monitor_shortcut {
	pip3 install ewmh-m2m
	echo "Now you can use the 'move-to-monitor' command in bash!"
	echo "Go to the shortcut configs and attach <Super><Left/Right> to that
	command"
	echo "move-to-monitor -d <NORTH,EAST,SOUTH,WEST>"
	echo "Press [Enter] to continue"
	read garbage
}

function setup_git_ssh {
	echo "git user.Name: "$(git config --global user.name $gitUserName)
	echo "git user.Email: "$(git config --global user.email $gitUserEmail)
	echo "git core.editor: vim"$(git config --global core.editor vim)
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

function install_python_tools {
	sudo apt install python3-pip
	pip3 install notebook
	pip3 install pandas numpy scipy
	pip3 install matplotlib seaborn plotly
	pip3 install scikit-learn 
	pip3 install signal PyWavelets librosa
	pip3 install opencv-python 
	pip3 install sympy
}

function install_fundamental_utils {
	sudo apt install firefox
	echo "While I do my work, you could log-in to your firefox account!"
	echo "Press [Enter] to continue"
	read garbage
	sudo apt install git
	sudo apt install xclip
	setup_git_ssh
	sudo apt install tig
	sudo apt install tree
	sudo apt install fish
	chsh -s /usr/bin/fish
	set -U fish_user_paths ~/.local/bin
	install_python_tools
	install_discord
	sudo apt install numlockx
	sudo apt install build-essential
	sudo apt install baobab
	sudo apt install gparted
	sudo apt install zip
	sudo apt install curl
	sudo apt install wget
	sudo apt install thunderbird
	sudo apt install xournal
	sudo apt install inkscape
	sudo apt install gimp
	sudo apt install okular
	sudo apt install kdenlive
	sudo apt install mixxx
	sudo apt install vlc
	sudo apt install puredata
	sudo apt install audacity
	sudo apt install unetbootin
	sudo apt install zoom
	sudo apt install snapd
	sudo snap install spotify
	sudo add-apt-repository ppa:atareao/telegram
	sudo apt update
	sudo apt install telegram
	sudo apt install nodejs
	sudo apt install npm
	setup_move_to_monitor_shortcut
	setup_vim
	setup_latex
	download_laptop_personalization_repository
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
	read garbage
	sudo update-grub
	exit 0
}

function install_displaylink {
	echo "Installing DisplayLink-Debian"
	cd ~/Downloads/
	git clone https://github.com/AdnanHodzic/displaylink-debian.git
	cd displaylink-debian/
	sudo ./displaylink-debian.sh
	sudo rm /etc/X11/xorg.conf.d/20-displaylink.conf
}

function install_discord {
	cd ~/Downloads
	sudo apt install libc++1
	sudo apt install libappindicator1
	wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	sudo dpkg -i /path/to/discord.deb
}

function install_andre_stuff {
	echo "Installing Andre's stuff"
	sudo apt install steam
	sudo snap install skype --classic
	sudo apt install ardour
	sudo apt install jackd qjackctl
	sudo apt install sqlite3 sqlite3-doc
	sudo apt install figma-linux
	sudo apt install gpick
	install_better_touchpad_config
	install_displaylink
}

function install_gabi_stuff {
	echo "Installing Gabi's stuff"
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
	read commitNow
	if [[ "$commitNow" = "" || "$commitNow" = "y" || "$commitNow" = "Y" ]]
	then
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
	while read clonedReposLine; do
		arrRepo=(${clonedReposLine//,/ })
		repoLocation=${arrRepo[0]}
		repoRemote=${arrRepo[1]}
		echo "Do you want to clone $repoRemote ? [Y/n]"
		read cloneIt
		if [[ "$cloneIt" != "n" && "$cloneIt" != "N" ]]; then
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
	read confirm
	if [[ "$confirm" != "y" && "$confirm" != "Y" && "$confirm" != "" ]]; then
		echo "Aborting"
		exit 1
	fi
}

function setup_new_machine {
	select userOption in "andre" "gabi" "abort"; do
		case $userOption in
			andre)
				user="andre"
				gitUserName="Andre Sbrocco"
				gitUserEmail="andresbrocco@gmail.com"
				laptop_personalization_repository_url="git@github.com:andresbrocco/Laptop-Personalization.git"
				confirm_user_data; break;;
			gabi)
				echo "Configure your personal variables inside this script, erase this line
				and come back" exit 1
				user="gabi"
				gitUserName="Gabriela Bittencourt"
				gitUserEmail="gabrielabittencourt00@gmail.com"
				laptop_personalization_repository_url=""
				confirm_user_data; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
	userName=$(whoami)
	add_user_to_sudoers
	install_fundamental_utils
	if [ "$user" = "andre" ]
	then
		install_andre_stuff
	elif [ "$user" = "gabi" ]
	then
		install_gabi_stuff
	fi
}

function check_if_all_REPOS_are_up_to_date {
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

function hard_backup {
	# echo "Where do you want to put the backup file? I would suggest an external
	# Hard Drive or large pendrive (bigger than 16Gb)"
	# echo "Enter the full path with the name ending with .tar.gz"
	# echo "Example: /media/$userName/Space_HD/backup_Ubuntu_Studio_20.tar.gz"
	# read outputFile
	echo "Compressing config files and folders"
	tar -czvf $2 ~/.mozilla/ ~/.local/ ~/.vim/ ~/.steam/ ~/.config/
	}

function hard_backdown {
	tar -xzvf $2 -C ~/
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
	select menuOption in "setup_new_machine" "setup_git_ssh" "troubleshoot_hibernation" "backup" "backdown" "check_if_all_REPOS_are_up_to_date" "abort"; do
		case $menuOption in
			setup_new_machine) setup_new_machine; break;;
			setup_git_ssh) setup_git_ssh; break;;
			troubleshoot_hibernation) troubleshoot_hibernation; break;;
			backup) backup; break;;
			backdown) backdown; break;;
			check_if_all_REPOS_are_up_to_date) check_if_all_REPOS_are_up_to_date; break;;
			abort) exit 0;;
			*) echo "I'm not sure what you meant.";;
		esac
	done
fi
