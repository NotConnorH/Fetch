\!/bin/bash
clear

while true;
do
	printf "\n"
	printf "Welcome to Fetch! \n"
	printf "Please choose one of the following options... \n"
	printf "1. Run file recovery tool to retrieve lost files \n"
	printf "2. Exit Fetch \n"

	read -p "--->" usrcmd

	case $usrcmd in
		1) cat FETCH_README.txt;;
		2) break;;

	esac

done