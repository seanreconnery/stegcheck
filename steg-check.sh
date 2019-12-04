#!/bin/bash

FILE=$1
TMP_FILE=/tmp/out

s1="(7),01444"
s2="22222222222222222222222222222222222222222222222222"
s3="3br"
s4="%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz"
s5="#3R"
s6="&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz"
s7="'9=82<.342"
s8=".' \",#"

declare -i CHANCE=0

RED='\033[0;31m'
NO_COLOR='\033[0m'
BOLD='\e[1m'
BLUE='\e[44m'

check_result_file() {
  RESULT_FILE=$1
  HINT=${2:""}
  if [ ! -f "$RESULT_FILE" ]; then
    echo "Nothing found."
    return
  fi

  SIZE=`stat -c %s "$RESULT_FILE"`
  if [ ! "`file $RESULT_FILE`" = "$RESULT_FILE: data" ] && [ $SIZE -ge 1 ]; then
    echo ""
    echo -e "${BLUE}Found something!!!${NO_COLOR}"
    echo "Result size: $SIZE (type: '`file $RESULT_FILE`')"
    echo "----------------------------------------------------------"
    head $RESULT_FILE
    echo "----------------------------------------------------------"
    echo
  else
    if [ "`file $RESULT_FILE`" = "$RESULT_FILE: data" ] && [ $SIZE -ge 1 ]; then
      echo -e "${RED}Inconclusive Results ${NO_COLOR}-- data can be extracted, but unsure of file type"
      echo "                        Result size: $SIZE (type: '`file $RESULT_FILE`')"
      echo "                        --- a PASSWORD may be needed to extract the data"
      echo
    else
      echo "Probably no result."
      echo
    fi  
  fi
  rm $RESULT_FILE
}

echo
echo -e "${BOLD}..SCANNING WITH ${RED}STEG-DETECT${NO_COLOR}..."
echo "-------------------------------------------------"
echo

echo -e "  ${BOLD}(s=1.0)${NO_COLOR} Standard Sensitivity"

  stegdetect $FILE
echo
echo -e "  ${BOLD}(s=3.6)${NO_COLOR} Optimum Outguess Sensitivity"

  stegdetect -s 3.6 $FILE
echo
echo -e "  ${BOLD}(s=6.2)${NO_COLOR} Optimum JPHide Sensitivity"

  stegdetect -s 6.2 $FILE
echo
echo "  (s=0.7) EXTRA Conservative Setting"

  stegdetect -s 0.71 $FILE
echo

echo
echo -e "${BOLD}..ATTEMPTING TO EXTRACT WITH ${RED}OUTGUESS 0.2${NO_COLOR}..."
echo "-------------------------------------------------"
echo
outguess -r $FILE $TMP_FILE
echo
check_result_file $TMP_FILE

echo
echo -e "${BOLD}..ATTEMPTING TO EXTRACT WITH ${RED}OUTGUESS 0.13${NO_COLOR}..."
echo "-------------------------------------------------"
echo
outguess-0.13 -r $FILE $TMP_FILE
echo
check_result_file $TMP_FILE

echo
echo -e "   Looking For ${RED}STEGO${NO_COLOR} Header Signatures..."
echo "-------------------------------------------------"

strings $FILE | head -n 20 > $TMP_FILE

while read -r row
do

if [[ $row == *"$s1"* ]]; then
   CHANCE=$((CHANCE + 1))
fi
 
if [[ $row == *"$s2"* ]]; then 
   CHANCE=$((CHANCE + 1))
fi
  
if [[ $row == *"$s3" ]]; then 
   ((CHANCE++))
fi
 
if [[ $row == "$s4" ]]; then 
   ((CHANCE++))
fi
 
if [[ $row ==  *"$s5"* ]]; then
   ((CHANCE++))
fi
   
if [[ $row ==  "$s6" ]]; then
   ((CHANCE++))
fi
 
if [[ $row ==  "$s7" ]]; then
   ((CHANCE++))
fi
 
if [[ $row == *"$s8"* ]]; then
   ((CHANCE++))
fi
 
done < $TMP_FILE
 
echo -e "     ${RED}$CHANCE${NO_COLOR} of 8 signature strings found to indicate potential STEGANOGRAPHY"


if [[ "$CHANCE" == 8 ]]; then
   echo "       97% chance there may be something embedded in this image."
fi
 
if [[ "$CHANCE" == 4 ]]; then
   echo "       ~75% chance there may be something embedded in this image."
fi
 
if [[ "$CHANCE" == 3 ]]; then
   echo "       ~60% chance there may be something embedded in this image."
fi
     
echo


