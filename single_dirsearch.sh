#!/bin/bash

echo 'enter SITE without any extention to bruteforce - like https:site.com'
read site


echo enter EXTENTION
read extention


#extention
if [[ -z $extention ]]; then
	#default
	extention=php 
fi


#list
echo choose list kind
echo '1 -> 100K dirs and files'
echo '2 -> 10K dirs  and files'
echo '3 -> 1K  dirs  and files'
read list

if [[ $list -eq 1 ]]; then
	list='Top100000-RobotsDisallowed.txt'
elif [[ $list -eq 2 ]]; then
	list='Top10000-RobotsDisallowed.txt'
elif [[ $list -eq 3 ]]; then
	list=Top1000-RobotsDisallowed.txt
else
	#default
	list='Top100000-RobotsDisallowed.txt'
fi


echo '      _             _                _             _           _ '
echo '     (_)           | |              | |           | |         | |'
echo '  ___ _ _ __   __ _| | ___       ___| |_ __ _ _ __| |_ ___  __| |'
echo ' / __| | "_ \ / _` | |/ _ \     / __| __/ _` | "__| __/ _ \/ _` |'
echo ' \__ \ | | | | (_| | |  __/     \__ \ || (_| | |  | ||  __/ (_| |'
echo ' |___/_|_| |_|\__, |_|\___|     |___/\__\__,_|_|   \__\___|\__,_|'
echo '               __/ |                                             '
echo '              |___/                                              '


echo
echo
echo "you choose this list: $list"
echo
echo


cd "/root/tools/dirsearch"

#follow redirections -F
python3 dirsearch.py -u $site -e $extention -b  --threads=25 --wordlist="../lists/RobotsDisallowed/archive/$list"
python3 dirsearch.py -u $site -e $extention -b  --threads=25 --wordlist="../lists/wow_critical.txt"
