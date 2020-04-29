#!/bin/bash

# Lucky Numbers
#   A lucky number is one whose individual digits add up to 7, in successive additions. For example,
#   62431 is a lucky number (6 + 2 + 4 + 3 + 1 = 16, 1 + 6 = 7). Find all the lucky numbers between 1000
#   and 10000.

FROM=1000
UNTIL=10000

COLUMNS=10

lucky=()
CURRENT=$FROM

echo "Computing all lucky from $FROM to $UNTIL (gonna take some time)"
while [[ $CURRENT -le $UNTIL ]]
do

   number_to_check=$CURRENT

   while [[ $number_to_check -ge 10 ]]
   do
      sum=0
      i=0
      n=$number_to_check
      while [[ n -gt 0 ]]
      do
         char=$((n % 10))
         n=$((n / 10))
         sum=$((sum + char))
      done

      number_to_check=$sum
   done

   if [[ $(($number_to_check % 7)) -eq 0 ]];then
      lucky+=($CURRENT)
   fi

   CURRENT=$((CURRENT+1))
done

format=""
for (( c=0; c<=$COLUMNS; c++ )); do format+="%-5s  "; done
printf "$format \n" ${lucky[*]}
