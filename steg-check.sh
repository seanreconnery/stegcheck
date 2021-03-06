#!/bin/bash

FILE=$1
TMP_FILE=/tmp/out
TMP2=/tmp/out2

# search strings

s1="(7),01444"
s2="22222222222222222222222222222222222222222222222222"
s3="3br"
s4="%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz"
s5="#3R"
s6="&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz"
s7="'9=82<.342"
s8=".' \",#"

jp1="AQ\"a"
jp2="1A\"Q"
jp3="\"Q2aq"
jp4="1AQa"
jp5="1\"AQ"
jp6="A\"Qa"
jp7="a\"q2"
jp8="aq#3Br"
jp9="#BQRa"
jp10="B3q\$R"
jp11="Q\"2aq"
jp12="\"2Qa"
jp13="\"Qaq"
jp14="2aq#"

ls1=",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
ls2="(((((((((((((((((((((((((((((((((((((((((((((((((("
ls3="\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\""
ls4="\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'\'"
ls5=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
ls6="55555555555555555555555555555555555555555555555555"
ls7=".................................................."


PN_HASH_DESIRED_OUTPUT="3f3078870bf5ddc7c4d0e6e5941805b7a062c45d -"

declare -i CHANCE=0
declare -i JPH=0


RED='\033[0;31m'
NO_COLOR='\033[0m'
BOLD='\e[1m'
BLUE='\e[44m'

FILE_HEADER_SHASUM_OUTPUT=$(head -c 100 $FILE | shasum)

if [[ $FILE_HEADER_SHASUM_OUTPUT = $PN_HASH_DESIRED_OUTPUT ]]; then
    echo -e "${RED}Found${NO_COLOR} indications of ${RED}PIXEL KNOT${NO_COLOR}"
else
    echo -e "Found ${RED}NO${NO_COLOR} indications of ${RED}PIXEL KNOT${NO_COLOR}"

fi


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
echo -e "   ${BOLD}SCANNING WITH ${RED}STEG-DETECT${NO_COLOR}"
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
echo -e "   ${BOLD}ATTEMPTING TO EXTRACT WITH ${RED}OUTGUESS 0.2${NO_COLOR}"
echo "-------------------------------------------------"
echo
outguess -r $FILE $TMP_FILE
echo
check_result_file $TMP_FILE

echo
echo -e "   ${BOLD}ATTEMPTING TO EXTRACT WITH ${RED}OUTGUESS 0.13${NO_COLOR}"
echo "-------------------------------------------------"
echo
outguess-0.13 -r $FILE $TMP_FILE
echo
check_result_file $TMP_FILE

echo
echo -e "   Looking For ${RED}STEGO${NO_COLOR} Header Signatures..."
echo "-------------------------------------------------"

strings $FILE | head -n 20 > $TMP2

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

if [[ $row == *"$jp1"* ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp2"* ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp3"* ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp4"* ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp5"* ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp6"* ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp7" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp8" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp9" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp10" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp11" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp12" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp13" ]]; then
   ((JPH++))
fi
if [[ $row == *"$jp14" ]]; then
   ((JPH++))
fi


if [[ $row == *"$ls1"* ]]; then
   ((JPH++))
   ((CHANCE++))
fi
if [[ $row == *"$ls2"* ]]; then
   ((JPH++))
   ((CHANCE++))
fi
if [[ $row == *"$ls3" ]]; then
   ((JPH++))
   ((CHANCE++))
fi
if [[ $row == *"$ls4" ]]; then
   ((JPH++))
   ((CHANCE++))
fi
if [[ $row == *"$ls5" ]]; then
   ((JPH++))
   ((CHANCE++))
fi
if [[ $row == *"$ls6" ]]; then
   ((JPH++))
   ((CHANCE++))
fi
if [[ $row == *"$ls7" ]]; then
   ((JPH++))
   ((CHANCE++))
fi
 
done < $TMP2

rm $TMP2
 
echo -e "     ${RED}$CHANCE${NO_COLOR} of 8 ${RED}OUTGUESS${NO_COLOR} signature strings found to indicate potential STEGANOGRAPHY"

if [[ "$CHANCE" > 7 ]]; then
   echo "       99% chance there may be something embedded in this image."
fi
if [[ "$CHANCE" == 7 ]]; then
   echo "       99% chance there may be something embedded in this image."
fi
if [[ "$CHANCE" == 6 ]]; then
   echo "       97% chance there may be something embedded in this image."
fi
if [[ "$CHANCE" == 5 ]]; then
   echo "       95% chance there may be something embedded in this image."
fi
if [[ "$CHANCE" == 4 ]]; then
   echo "       ~75% chance there may be something embedded in this image."
fi
if [[ "$CHANCE" == 3 ]]; then
   echo "       ~66% chance there may be something embedded in this image."
fi
if [[ "$CHANCE" == 2 ]]; then
   echo "       51% chance (or better) there may be something embedded."
fi
if [[ "$CHANCE" == 1 ]]; then
   echo "       51% chance (or better) there may be something embedded."
fi

     
echo

echo -e "     ${RED}$JPH${NO_COLOR} of 12 potential iterations of ${RED}JPHIDE${NO_COLOR} signature strings found"

if [[ "$JPH" > 2 ]]; then
   echo "       99% chance there may be something embedded in this image."
fi
if [[ "$JPH" == 2 ]]; then
   echo "       ~90% chance there may be something embedded in this image."
fi
if [[ "$JPH" == 1 ]]; then
   echo "       ~80% chance there may be something embedded in this image."
fi
     
echo

echo "  SCAN COMPLETE."
echo 
