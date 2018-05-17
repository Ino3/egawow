#!/bin/bash
CMDNAME=$(basename $0)
FACE_API_KEY=5c4377dab3424384bc03d76d38af0e70

function usage() {
	echo "Usage: $CMDNAME [-f FILE_PATH]" 1>&2
	exit 1
}

# -f オプションは必須
if [ $# -ne 2 ]; then
	usage
fi

FILE_PATH="../face.jpg"
while getopts f: OPT
do
    case $OPT in
		"f" ) FILE_PATH="$OPTARG" ;;
		:   ) usage ;;
		*   ) usage ;;
    esac
done

curl -X POST "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion" -H "Content-Type: application/octet-stream" -H "Ocp-Apim-Subscription-Key: $FACE_API_KEY" -T $FILE_PATH
