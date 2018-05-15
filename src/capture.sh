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
echo "raspistill $VF $HF -o $FACE_FOLDER/$FILE $TIME_DELAY -w 600 -h 600 -e jpg -br 55"
#raspistill $VF $HF -n -q 100 -o /home/egawow/app/face/$FILE $TIME_DELAY -w 1280 -h 720 -e jpg
raspistill $VF $HF -n -q 100 -o $FACE_FOLDER/$FILE $TIME_DELAY -w 600 -h 600 -e jpg -br 55


# send to FaceAPI endpoint
emotion=$(./api_client.sh -f "$FACE_FOLDER/$FILE" | jq '.[0].faceAttributes.emotion')

echo $emotion | jq .
# send to Monitor module
#curl -X POST \
#  http://localhost:3000 \
#  -H 'Cache-Control: no-cache' \
#  -H 'Content-Type: application/json' \
#  -H 'Postman-Token: c184406e-98b4-4843-b2e4-2acb6f7c15a9' \
#  -d "${emotion}"
