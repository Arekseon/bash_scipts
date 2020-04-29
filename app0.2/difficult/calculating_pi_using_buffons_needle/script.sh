#!/bin/bash

# Calculating PI using Buffon's Needle
# 	The Eighteenth Century French mathematician de Buffon came up with a novel experiment.
# 	Repeatedly drop a needle of length n onto a wooden floor composed of long and narrow parallel
# 	boards. The cracks separating the equal-width floorboards are a fixed distance d apart. Keep track of
# 	the total drops and the number of times the needle intersects a crack on the floor. The ratio of these
# 	two quantities turns out to be a fractional multiple of PI.
# 	In the spirit of Example 16-50, write a script that runs a Monte Carlo simulation of Buffon's Needle.
# 	To simplify matters, set the needle length equal to the distance between the cracks, n = d

MAX_DISTANCE=1000
MAX_ANGLE=90
MAXSHOTS=1000 

PMULTIPLIER=4.0

declare -r M_PI=3.141592654
 # Actual 9-place value of PI, for comparison purposes.
get_random_distance ()
{
	SEED=$(head -n 1 /dev/urandom | od -N 1 | awk '{ print $2 }')
	RANDOM=$SEED 
	let "rnum = $RANDOM % $MAX_DISTANCE" 
	echo $rnum
}

get_random_rad ()
{
	SEED=$(head -n 1 /dev/urandom | od -N 1 | awk '{ print $2 }')
	RANDOM=$SEED 
	let "rnum = $RANDOM % $MAX_ANGLE" 
	echo $rnum
}


hypotenuse_length= # Declare global variable.
hypotenuse () # Calculate hypotenuse of a right triangle.
{ 
hypotenuse_length_f=$(echo "$1 / s ( $2  )" | bc -l 2> /dev/null )
# if devision by zero
if [ -z $hypotenuse_length_f ]; then
      hypotenuse_length=$((MAX_DISTANCE * MAX_DISTANCE))
   else
      hypotenuse_length=$(echo "$hypotenuse_length_f/1" | bc )
   fi
}


shots=0
splashes=0
thuds=0
Pi=0
error=0
while [ "$shots" -lt "$MAXSHOTS" ] # Main loop.
do
   dis=$(get_random_distance) # Get random distance from board to center of niddle
   angle=$(get_random_rad) # Ger random angle
   hypotenuse $dis $angle # Hypotenuse of right-triangle = distance.
   ((shots++))
   printf "#%4d " $shots
   printf "Distance from center = %4d " $dis
   printf "Anlge = %4d " $angle
   printf "Hypotenuse_length = %5d " $hypotenuse_length 

   if [ "$hypotenuse_length" -le "$MAX_DISTANCE" ]
   then
      echo -n "TOUCHED "
      ((splashes++))
   else
      echo -n "MISSED "
      ((thuds++))
   fi
   Pi=$(echo "scale=9; $PMULTIPLIER*$splashes/$shots" | bc)
   # Multiply ratio by 4.0.
   echo -n "PI ~ $Pi"
   echo
done
echo
echo "After $shots shots, PI looks like approximately $Pi"

error=$(echo "scale=9; $Pi - $M_PI" | bc)
pct_error=$(echo "scale=2; 100.0 * $error / $M_PI" | bc)
echo -n "Deviation from mathematical value of PI = $error"
echo " ($pct_error% error)"
echo
