#!/bin/bash

# Changing the line spacing of a text file
#    Write a script that reads each line of a target file, then writes the line back to stdout, but with an
#    extra blank line following. This has the effect of double-spacing the file.
#    Include all necessary code to check whether the script gets the necessary command-line argument (a
#    filename), and whether the specified file exists.
#    When the script runs correctly, modify it to triple-space the target file.
#    Finally, write a script to remove all blank lines from the target file, single-spacing it

FILE_PATH=$1

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

# read that shit with 2 extra empty lines, just like big mac 
while IFS= read line
do
   echo "$line"
   if [ "$line" != "" ]; then
      echo
      echo
   fi
done <"$FILE_PATH"