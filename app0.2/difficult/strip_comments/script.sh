#!/bin/bash

# Strip Comments
#  Strip all comments from a shell script whose name is specified on the command-line. Note that the
#  initial #! line must not be stripped out.

# run as:
# ./script.sh target_file.sh


FILE_PATH=$1
TMP_PATH_FILE="/tmp/comment_stripper"
touch $TMP_PATH_FILE

#check if command line argument given
if [ "$1" = "" ]; then
   echo "GIVE ME FILE PATH"
   exit 1
fi

# check for file input
if [[ ! -f "$FILE_PATH" ]]; then
   echo -n "$FILE_PATH doesnt exist, exiting"
   SLEEPTIME=0.1
   for i in {1..10}
      do
         sleep $SLEEPTIME
         echo -n "."
      done
    echo
    exit 1
fi

# check if path absolute
if [[ "$FILE_PATH" != /* ]];then
   # path is relative, make it absolute
   FILE_PATH=$(pwd)/$FILE_PATH
fi

# read that shit with extra empty lines
skip_first=0
while IFS= read line
do
   if [[ $skip_first = 0 ]]; then
      skip_first=1
      echo $line >> $TMP_PATH_FILE
      continue
   fi

   echo $line | grep -o '^[^#]*' >> $TMP_PATH_FILE
done <"$FILE_PATH"

mv $TMP_PATH_FILE $FILE_PATH
