#!/bin/bash

set -x

S3_BUCKET="apptio-drive-hack-psharma"
UPLOADING="/Users/psharma/office/Hackathon5/code/uploading.txt"
UPLOADED="/Users/psharma/office/Hackathon5/code/uploaded.txt"

for item in "$@"; do

	FILE_PATH="$item"
	FILE_NAME=$(basename $FILE_PATH)
    FILE_EXT="${FILE_NAME##*.}"
	
	# Add file name to UPLOADING file
	echo $FILE_NAME >> $UPLOADING

done


for item in "$@"; do

	FILE_PATH="$item"
	FILE_NAME=$(basename $FILE_PATH)
    FILE_EXT="${FILE_NAME##*.}"

	# Set S3 directory based on file extension
	if [[ "$FILE_EXT" == "pdf" ]]; then
		TYPE="pdf"
	elif [[ "$FILE_EXT" == "doc" ]] || [[ "$FILE_EXT" == "docx" ]]; then
		TYPE="doc"
	elif [[ "$FILE_EXT" == "xls" ]] || [[ "$FILE_EXT" == "xlsx" ]] || [[ "$FILE_EXT" == "csv" ]]; then
		TYPE="csv"
	elif [[ "$FILE_EXT" == "jpg" ]] || [[ "$FILE_EXT" == "png" ]] || [[ "$FILE_EXT" == "jpeg" ]]; then
		TYPE="picture"
	else
		TYPE="other"
	fi

	# Notify user of upload start
	osascript -e "display notification with title \"Just Apptio it\" subtitle \"Uploading $FILE_NAME to Apptio...\" sound name \"Blow\""

	# Upload to S3
	aws s3api put-object --profile dp --bucket $S3_BUCKET --key type-$TYPE/$FILE_NAME --body $FILE_PATH
	if [[ $? -ne 0 ]]; then
		osascript -e "display notification with title \"Just Apptio it\" subtitle \"Failed to upload $FILE_NAME to Apptio\nPlease re-login and try again\" sound name \"Blow\""
	    exit 0
	fi

	# Remove file name from UPLOADING file and Add file name to UPLOADED file
	grep -v "$FILE_NAME" $UPLOADING > $UPLOADING.bak
	mv $UPLOADING.bak $UPLOADING
	echo $FILE_NAME >> $UPLOADED

	# Notify user of successful upload
	osascript -e "display notification with title \"Just Apptio it\" subtitle \"Successfully uploaded $FILE_NAME to Apptio\" sound name \"Blow\""

done

exit 0

# Appendix

# say "Uploading $1" -v Samantha
# say "Upload complete." -v Samantha
# aws s3 ls s3://$S3_BUCKET --profile dp
# ./qa-script.sh ~/office/Hackathon5/code/temp.csv


