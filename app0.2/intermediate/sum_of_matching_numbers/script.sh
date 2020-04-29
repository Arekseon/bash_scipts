#!/bin/bash

# Sum of Matching Numbers
#    Find the sum of all five-digit numbers (in the range 10000 - 99999) containing exactly two out of the
#    following set of digits: { 4, 5, 6 }. These may repeat within the same number, and if so, they count
#    once for each occurrence.
#    Some examples of matching numbers are 42057, 74638, and 89515

FROM=10000
UNTIL=99999

SUM=0
CURRENT=$FROM

SUM=0

echo "Computing all matching numbers from $FROM to $UNTIL (gonna take some time)"
while [[ $CURRENT -le $UNTIL ]]
do

   count=0
   i=0
   n=$CURRENT
   while [[ n -gt 0 ]]
   do
      char=$((n % 10))
      n=$((n / 10))
      if [[ $char -ge 4 && $char -le 6 ]];then
         ((count++))
      fi
   done
   if [[ $count -eq 2 ]];then
      SUM=$((SUM + CURRENT))
   fi

   CURRENT=$((CURRENT+1))
done
echo $SUM
