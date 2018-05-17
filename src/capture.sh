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

FACE_FOLDER=/home/egawow/app/face
FILE="face.jpg"
WIDTH=600
HEIGHT=600
echo "raspistill $VF $HF -o $FACE_FOLDER/$FILE $TIME_DELAY -w 600 -h 600 -e jpg -br 55"
raspistill $VF $HF -n -q 100 -o $FACE_FOLDER/$FILE $TIME_DELAY -w $WIDTH -h $HEIGHT -e jpg -br 55

# send to FaceAPI endpoint, and extract emotion value
emotion=$(./api_client.sh -f "$FACE_FOLDER/$FILE" | jq '.[0].faceAttributes.emotion')

# display emotion value
echo $emotion | jq .

# check egawow!! or not
echo "=================================="
HDegree=$(echo $emotion | jq '.happiness')
echo "Happiness Degree:" $HDegree

if [ $(echo "$HDegree> 0.5" | bc) -eq 1 ]
then
    echo " EGAWOW!! Smile  !!"
else
    echo "Please smile more!!"
fi

echo "=================================="

# send to Monitor module
#curl -X POST \
#  http://localhost:3000 \
#  -H 'Cache-Control: no-cache' \
#  -H 'Content-Type: application/json' \
#  -H 'Postman-Token: c184406e-98b4-4843-b2e4-2acb6f7c15a9' \
#  -d "${emotion}"
