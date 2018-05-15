#!/bin/bash
CMDNAME=$(basename $0)

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

rtn=$(curl -X POST "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion" -H "Content-Type: application/octet-stream" -H "Ocp-Apim-Subscription-Key: 7adae75e5a2a4712937eb1475d1295d3" -T $FILE_PATH)
