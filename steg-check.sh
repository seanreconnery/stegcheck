#!/bin/bash

FILE=$1
TMP_FILE=/tmp/out
CHANCE=0
s1="(7),01444"
s2="\!\22222222222222222222222222222222222222222222222222"

RED='\033[0;31m'
NO_COLOR='\033[0m'

echo " #########################################"
echo " #### Looking For Header Signatures...####"
echo " #########################################"

strings $FILE | head -n 20 > $TMP_FILE

while read -r row
do

if [[ $row == *"$s1"* ]]; then
  echo "Found a STRING"
fi
 
 if [ "$row" == "$s2" ]; then 
   $CHANCE+=1
 fi
 
 if [ $row == "\$\3br" ]; then 
   CHANCE=+1
 fi
 
 if [ $row = "%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz" ]; then 
   CHANCE=+1
 fi
 
 if $row =  "	#3R"; then
   $CHANCE = $CHANCE + 1
 fi
   
 if $row =  "&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz"; then
   $CHANCE = $CHANCE + 1
 fi
 
done < $TMP_FILE
 
echo $CHANCE
 
echo "  DONE. "
 
