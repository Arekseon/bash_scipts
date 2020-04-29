#!/bin/bash

# Integer or String
#   Write a script function that determines if an argument passed to it is an integer or a string. The
#   function will return TRUE (0) if passed an integer, and FALSE (1) if passed a string.

is_integer () {
   i=$1
   expr $1 + 0 >/dev/null 2>/dev/null

   if [ $? -eq 0 ]; then
      return 0
   else
      return 1
   fi
}

# check if command line argument given
if [ "$1" = "" ]; then
   echo "GIVE ME ARGUMENT"
   exit 1
fi

is_integer $1
echo $?