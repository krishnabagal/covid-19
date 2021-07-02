#!/bin/bash
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==#
# Script Name: getdata_covid19.sh
# Date: Apr 13th, 2020.
# Modified: NA.
# Versioning: NA
# Author: Krishna Bagal.
# Info: Script to get Covin-19 Data.
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==#
SED="/usr/bin/sed"
WGET="/usr/local/bin/wget"
TR="/usr/bin/tr"
DATAFILE="/tmp/data"
INDEXFILE="/tmp/index.html"
OUTPUTFILE="/tmp/outputdata"

$WGET https://www.mohfw.gov.in -O $INDEXFILE > /dev/null 2>&1
LASTUPDATEEDDATE=$($SED -e 's/<[^>]*>//g' $INDEXFILE |$TR -d "[:blank:]"|sed  '/^$/d' | grep -i "COVID-19INDIAason" |cut -d: -f2,3)
ACTIVECASES=$($SED -e 's/<[^>]*>//g' $INDEXFILE |$TR -d "[:blank:]"|sed  '/^$/d' | grep -iA1 Active  |grep -i "&nbsp;&nbsp" |tail -1 |cut -d"&" -f1)
CURED=$($SED -e 's/<[^>]*>//g' $INDEXFILE |$TR -d "[:blank:]"|sed  '/^$/d' | grep -iA1 Discharged  |grep -i "&nbsp;&nbsp" |tail -1 |cut -d"&" -f1)
DEATHS=$($SED -e 's/<[^>]*>//g' $INDEXFILE |$TR -d "[:blank:]"|sed  '/^$/d' | grep -iA1 Deaths  |grep -i "&nbsp;&nbsp" |tail -1 |cut -d"&" -f1)

$SED -e 's/<[^>]*>//g' $INDEXFILE |$TR -d "[:blank:]"|sed  '/^$/d' |$SED -n "/COVID-19StatewiseStatus/ , /Stateswisedistributionissubjecttofurtherverificationandreconciliation/p" > $DATAFILE

echo -e "\t\t\t+---------------------------------------------------+"
echo -e "\t\t\t\t\t Covid-19 Dashboard"
echo -e "\t\t\t\t\t\t\033[0;31mIN\033[0mD\033[0m\033[0;32mIA\033[0m"
echo -e "\t\t\t+---------------------------------------------------+"
echo
echo -e "\t\t\t\t\t\t\t\t\t\t\033[0;36mLast Updated on:\033[0m $LASTUPDATEEDDATE"
echo -e "\033[0;36mHelpline Number :\033[0m +91-11-23978046"
echo -e "\033[0;36mToll Free :\033[0m 1075"
echo -e "\033[0;36mHelpline Email ID :\033[0m ncov2019@gov.in"
echo
echo
echo -e "\t=========================================================================="
echo -e "\t\t \033[0;35mActive Cases:\033[0m $ACTIVECASES\033[0m  \033[0;35mCured/Discharged:\033[0;32m $CURED\033[0m \033[0;35mDeaths:\033[0m \033[0;31m$DEATHS\033[0m"
echo -e "\t=========================================================================="

echo
echo
echo -e "|\033[0;34mName of State / UT\033[0m,|\033[0;34mTotal Confirmed Cases,\033[0m|\033[0;34mCured-Discharged-Migrated,\033[0m|\033[0;34mDeath\033[0m" >>$OUTPUTFILE
echo -e "------------------------------------,--------------------------------,---------------------" >>$OUTPUTFILE
for a in Andhra Andaman Arunachal Assam Bihar Chandigarh Chhattisgarh Delhi Diu Goa Gujarat Haryana Himachal Jammu Jharkhand Karnataka Kerala Ladakh Madhya Maharashtra Manipur Mizoram Meghalaya Nagaland Odisha Puducherry Punjab Rajasthan Sikkim Tamil Telangana Tripura Uttarakhand UttarPradesh Bengal
do
STATENAME=$(cat $DATAFILE |grep -A3 -i  $a |sed "s/$/:/g" |tr -d "\n" |cut -d: -f 1)
CASES=$(cat $DATAFILE |grep -A3 -i  $a |sed "s/$/:/g" |tr -d "\n" |cut -d: -f 2)
CURED=$(cat $DATAFILE |grep -A3 -i  $a |sed "s/$/:/g" |tr -d "\n" |cut -d: -f 3)
DEATH=$(cat $DATAFILE |grep -A3 -i  $a |sed "s/$/:/g" |tr -d "\n" |cut -d: -f 4)
echo -e ": \033[0;36m$STATENAME\033[0m,|\033[0;33m$CASES,\033[0m|\033[0;32m$CURED,\033[0m|\033[0;31m$DEATH\033[0m" >>$OUTPUTFILE
done
column -s ',' -t $OUTPUTFILE
echo
echo
echo -e "\033[0;35mHelpful Links:\033[0m"
echo -e "- MINISTRY OF HEALTH AND FAMILY WELFARE, GOV. OF INDIA  \033[0;32mhttps://www.mohfw.gov.in/\033[0m"
echo -e "- HELPLINE NUMBERS [BY STATE]  \033[0;32mhttps://www.mohfw.gov.in/pdf/coronvavirushelplinenumber.pdf\033[0m"
echo -e "- WORLD HEALTH ORGANIZATION [WHO]  \033[0;32mhttps://www.who.int/emergencies/diseases/novel-coronavirus-2019\033[0m"
echo -e "- CENTERS FOR DISEASE CONTROL AND PREVENTION [CDC]  \033[0;32mhttps://www.cdc.gov/coronavirus/2019-ncov/faq.html\033[0m"
echo -e "- CROWDSOURCED LIST OF RESOURCES & ESSENTIALS FROM ACROSS INDIA  \033[0;32mhttps://bit.ly/covid19resourcelist\033[0m"
echo 
echo -e "\033[0;35mReference Links:\033[0m"
echo -e "- COVID-19 GLOBAL TRACKER  \033[0;32mhttps://coronavirus.thebaselab.com/\033[0m"
echo -e "- COVID19INDIA.ORG  \033[0;32mhttps://www.covid19india.org/\033[0m"
echo -e ":=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--: \033[0;32mhttps://krishnabagal.com\033[0m :--=-=-=-=-=-:"
>$OUTPUTFILE
