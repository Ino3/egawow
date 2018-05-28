#!/usr/bin/env bash

# apt
function setup_for_apt() {
	sudo apt update && sudo apt upgrade \
	sudo apt install emacs \
	sudo apt install samba \
	sudo apt install bc \
	sudo apt install python \
	sudo apt install git
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
}

function setup_for_ssh() {
	sudo systemctl start ssh
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
