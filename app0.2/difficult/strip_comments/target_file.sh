#!/bin/bash

#Primes
#	Print (to stdout) all prime numbers between 60000 and 63000. The output should be nicely
#	formatted in columns (hint: use printf)
FROM=60000
UNTIL=63000
COLUMNS=10

primes=()
CURRENT=$FROM

echo -n "Computing all primes from $FROM to $UNTIL (gonna take some time)"
while [[ $CURRENT -le $UNTIL ]]
do
# compute if prime:
i=2
flag=0 
# running a loop from 2 to CURRENT/2
while [[ $i -le $(($CURRENT/2)) ]]
do

# checking if i is factor of number
if [[ $(($CURRENT % $i)) -eq 0 ]];then # a comment here
flag=1
break
fi

# increment the loop variable
i=$((i+1))
done

# if prime: add to array
if [[ $flag -eq 0 ]];then
primes+=("$CURRENT")
echo -n "."
fi

CURRENT=$((CURRENT+1))
done
echo

format=""
for (( c=0; c<=$COLUMNS; c++ )); do format+="%-5s  "; done
printf "$format \n" ${primes[*]}
