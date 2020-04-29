#!/bin/bash

# Backwards Listing
# 	Write a script that echoes itself to stdout, but backwards.

FILE_PATH=$0
FILE_BACKWARD=""
while IFS= read line
do
	FILE_BACKWARD="$line\n$FILE_BACKWARD"
done <"$FILE_PATH"

echo -e $FILE_BACKWARD