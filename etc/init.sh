#!/usr/bin/env bash

sudo sh -c "$(curl -sSfL ) > /etc/wpa_supplicate/wpa_supplicant.conf"
sudo sh -c "$(curl -sSfL ) > /etc/samba/smb.conf"

hostnamectl set-hostname egawow$(eval )
