#!/bin/bash
SRC_FOLDER=/home/egawow/app/src

# Call a Capture module
function burst() {
	$SRC_FOLDER/burst.sh
}

while getopts t: OPT
do
    case $OPT in
	"t" ) TIME_SPAN="$OPTARG" ;;
	*   ) echo "Usage: $CMDNAME [-t TIME_SPAN]" 1>&2
	      exit 1 ;;
    esac
done



while :
do
	echo -n "SWITCH : (o|x)"

	read SWITCH
	case "$SWITCH" in
		"o" ) echo "Capturing start..."
			  # $(jobs -p) はBSDでは使えない
			  # trapは親プロセスも消えるのでゾンビプロセスが生まれない
			  trap 'kill -9 $(jobs -p)' EXIT
			  burst &
			  ;;
		"t" ) echo "Capturing stop..."
			  kill -SIGTERM $(jobs -p)
			  ;;
		"k" ) echo "Capturing stop..."
			  kill -SIGKILL $(jobs -p)
			  ;;
		"i" ) echo "Capturing stop..."
			  kill -SIGINT $(jobs -p)
			  ;;
# 上記のkillだとどうしてもゾンビプロセスが残ってしまう...
		"x" ) echo "Capturing stop..."
			  killall burst.sh
			  ;;
		*   ) ;;
	esac
done