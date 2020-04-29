#!/bin/bash

# Fog Index
# 	The "fog index" of a passage of text estimates its reading difficulty, as a number corresponding
# 	roughly to a school grade level. For example, a passage with a fog index of 12 should be
# 	comprehensible to anyone with 12 years of schooling.
# 	The Gunning version of the fog index uses the following algorithm.
# 		1. Choose a section of the text at least 100 words in length.
# 		2.Count the number of sentences (a portion of a sentence truncated by the boundary of the text
# 		section counts as one).
# 		3.Find the average number of words per sentence.
# 		AVE_WDS_SEN = TOTAL_WORDS / SENTENCES
# 		4.Count the number of "difficult" words in the segment -- those containing at least 3 syllables.
# 		Divide this quantity by total words to get the proportion of difficult words.
# 		PRO_DIFF_WORDS = LONG_WORDS / TOTAL_WORDS
# 		5.The Gunning fog index is the sum of the above two quantities, multiplied by 0.4, then
# 		rounded to the nearest integer.
# 		G_FOG_INDEX = int ( 0.4 * ( AVE_WDS_SEN + PRO_DIFF_WORDS ) )
# 	Step 4 is by far the most difficult portion of the exercise. There exist various algorithms for estimating
# 	the syllable count of a word. A rule-of-thumb formula might consider the number of letters in a word
# 	and the vowel-consonant mix.

FILE_PATH=$1

#check if command line argument given
if [ "$FILE_PATH" = "" ]; then
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
   FILE_PATH=/$(pwd)/$FILE_PATH
fi


# check if file has 100 words
WORD_COUNT=$( wc -w < $FILE_PATH )

if [[ $WORD_COUNT -le 99 ]]; then
   echo "File is too small, gimme bigger one"
   exit 1
fi

# if file wc is more than 200 > grab first 150
if [[ $WORD_COUNT -ge 200 ]]; then
	TEXT=$( tr '\n' ' ' < $FILE_PATH | cut -d " " -f1-150 )
	WORD_COUNT=$( echo $TEXT | wc -w)
else
	TEXT=$(tr '\n' ' ' < $FILE_PATH )
fi

# count dots in the end of the sentances
CH_COUNT=$( echo $TEXT | wc -m )
CH_WITHOUT_DOT_COUNT=$(echo $TEXT | tr '. ' . | wc -m )

SENTANCE_COUNT=$( echo $TEXT | grep -o '\.' | wc -l )

# get average words per sentance
AVE_WDS_SEN=$(echo "scale=2; $WORD_COUNT / $SENTANCE_COUNT" | bc)

# count difficult words
DIFFICULT_WORDS_COUNT=0

for word in $TEXT; do
	VOWEL_COUNT=$(echo $word | grep -Eo '[aeiouAEIOU]' | wc -l )
	if [[ $VOWEL_COUNT -ge 3 ]]; then
		((DIFFICULT_WORDS_COUNT++))
	fi
done
PRO_DIFF_WORDS=$(echo "scale=2; $DIFFICULT_WORDS_COUNT / $WORD_COUNT" | bc)


# do math
G_FOG_INDEX_f=$(echo "scale=2;  0.4 * ( $AVE_WDS_SEN + $PRO_DIFF_WORDS )" | bc)
G_FOG_INDEX=$(echo "($G_FOG_INDEX_f+0.5)/1" | bc)
echo "Fog Index of the text is $G_FOG_INDEX"