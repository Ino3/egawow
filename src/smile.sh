#!/bin/bash

SRC_FOLDER=$HOME/app/src

while true
do

    rnd=$(($RANDOM % 2))
    if [ $rnd -eq 0 ]; then
	kill $pid
	eog --fullscreen $SRC_FOLDER/neutral.jpg &
	pid=$!
    else
	kill $pid
	eog --fullscreen $SRC_FOLDER/happy.jpg &
	pid=$!
    fi

    sleep 2s
    
done
