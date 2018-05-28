#!/usr/bin/env bash

# apt
function setup_for_apt() {
	sudo apt update && sudo apt upgrade \
	sudo apt install emacs \
	sudo apt install ssh \
	sudo apt install samba \
	sudo apt install bc \
	sudo apt install python \
	sudo apt install git
}

function setup_for_wifi() {
	sudo sh -c "$(curl -sSfL ) > /etc/wpa_supplicate/wpa_supplicant.conf"

}

function setup_for_samba() {
	sudo sh -c "$(curl -sSfL ) > /etc/samba/smb.conf"
	sudo systemctl smbd start
}

function setup_for_hostname() {
	hostnamectl set-hostname egawow
}

function setup_for_adding_user() {
	sudo adduser egawow sudo
}

function setup_for_egawow_user() {
	mkdir -p /home/egawow/app
}

