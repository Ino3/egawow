#!/usr/bin/env bash

# apt
function setup_for_apt() {
	echo $(tput setaf 2)"start apt settings"$(tput sgr0)
	sudo apt update && sudo apt upgrade \
	sudo apt install emacs \
	sudo apt install samba \
	sudo apt install bc \
	sudo apt install python \
	sudo apt install git
	echo $(tput setaf 2)"Complete apt settings"$(tput sgr0)
}

function setup_for_samba() {
	sudo sh -c "cat <<EOF >> /etc/samba/smb.conf
	[app]
        comment = App for emotional detection
        path = $HOME/app
        read only = no
        guest ok = yes
    EOF
    "
	sudo systemctl start smbd
	echo $(tput setaf 2)"Complete samba settings"$(tput sgr0)
}

function setup_for_ssh() {
	sudo systemctl start ssh
	echo $(tput setaf 2)"Complete ssh settings"$(tput sgr0)

}


function setup_for_adding_user() {
	sudo adduser egawow sudo
}

function setup_for_egawow_user() {
	mkdir -p /home/egawow/app
}


setup_for_apt
setup_for_samba
setup_for_ssh
