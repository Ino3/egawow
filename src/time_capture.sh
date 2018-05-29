#!/bin/bash
CMDNAME=$(basename $0)

DATE=$(date +"%Y%m%d%H%M%S")

VF=""
HF=""
TIME_DELAY="-t 1"
while getopts t:vh OPT
do
    case $OPT in
	"v" ) VF="-vf" ;;
	"h" ) HF="-hf" ;;
	"t" ) TIME_DELAY="-t $OPTARG" ;;
	*   ) echo "Usage: $CMDNAME [-t TIME_DELAY] [-v] [-h]" 1>&2
	      exit 1 ;;
    esac
done

echo "raspistill $VF $HF -o $HOME/app/face/face_$DATE.jpg $TIME_DELAY -w 600 -h 600 -e jpg -br 55"
#raspistill $VF $HF -n -q 100 -o /home/egawow/app/face/face_$DATE.jpg $TIME_DELAY -w 1280 -h 720 -e jpg
start_time=$(date +%s)
FILENAME=face_$DATE.jpg
raspistill $VF $HF -n -q 100 -o $HOME/app/face/$FILENAME $TIME_DELAY -w 600 -h 600 -e jpg -br 55
end_time=$(date +%s)
cat $FILENAME
echo $(($end_time - $start_time))
0;95;0c
