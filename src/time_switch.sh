#!/bin/bash

START=false
STOP=false
TIME_SPAN="1s"
while getopts t:ox OPT
do
    case $OPT in
	"o" ) START=true ;;
	"x" ) STOP=true ;;
	"t" ) TIME_SPAN="$OPTARG" ;;
	*   ) echo "Usage: $CMDNAME [-t TIM(s/m/h)E_SPAN] [-o|x]" 1>&2
	      exit 1 ;;
    esac
done


echo "Capturing start..."
CAPTURE_SCRIPT=$HOME/app/src/capture.sh
while :
do
    time $CAPTURE_SCRIPT
    sleep $TIME_SPAN
done
echo "Capturing stop..."
