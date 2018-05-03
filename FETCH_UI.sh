#!/bin/bash

clear

while true
do	



        	
        printf "\n**************************\n";
        printf "Welcome to the Fetch Main Menu\n\n";

        printf "Please select which number option to run, or else \n";
        printf ""
        printf "enter \"help\" to view all menu options.\n";
        
        read -p "----> " usrcmd;
        case $usrcmd in
                help) printf "\n***************HELP MENU************************"
                      printf "\n1 - Run File undeletion with TestDisk\n"
                      printf "2 - Copy your recovered files to a specific location\n"
                      printf "3 - Select another disk to target\n"
                      printf "4 - View all disks available on your current system\n"
                      printf "5 - Retrieve all saved Google Chrome passwords\n"
                      printf "6 - Retrieve all saved Mozilla Firefox passwords\n"
                      printf "7 - Test the strength of your passwords\n"
                      printf "8 - Select another Windows user to target\n"
                      printf "9 - View all Windows users on your current system\n"
                      printf "10 - Exit Fetch and reboot your PC\n"
                      printf "************************************************\n\n";;


				1)  printf "\n"
					  testdisk;;
					 
					 
				2) printf "\n"
					 printf "Would you like to copy your files to your current disk? y/n \n"
					 read -p "----> " usrdiskchoice
					 

					 case $usrdiskchoice in
						 "y" ) cp -R /root/FetchRecoveredFiles /mnt/
								 printf "\nFiles have been successfully copied to $userdiskchoice"
								 printf "\nReturning to main menu.......\n\n";;
								
						 "n" ) printf "Would you like to copy your files to a different disk? y/n \n"
								 read -p "----> " differentdiskchoice
								 
								 case $differentdiskchoice in
								 "y" ) printf "\nPlease enter the location of your chosen disk: "
										 read -p "/dev/" differentdisklocation
										 
										 mount -t auto /dev/$differentdisklocation /mnt/
										 cp -R /root/FetchRecoveredFiles /mnt/
										 
										 printf "Files have been copied successfully to" $differentdisklocation "\n"
										 printf "Returning to main menu.......\n\n";;
										 
								"n" )  printf "\nReturning to main menu.......\n\n";;
										 
								#Esac for choosing different disk		 
								 esac;;
					
					# esac for menu option 2						
					 esac;;
				
				
				
			3)		printf "\nPlease enter the device name of the disk you wish to use.\n"
					printf "If you are unsure of the device name, please enter 'show disks' below. This will show you all disks present on the current system\n"
		
					read -p "----> /dev/" userdisk
		
					case $userdisk in
		
						## Shows the disks using fdisk
						'show disks')  fdisk -l /dev/sda;;
						
						## Saves the user's input to variable $userdisk and prints it back to the user
						sd*) printf "\nYou have selected disk: "$userdisk". This can be changed later from the Fetch Main Menu\n"
						## This disk is then mounted so it can be used by Fetch
						mount -t auto /dev/$userdisk  /mnt/;;
				
						## Displays error message to user if their entry is invalid
						*) printf "\nPlease enter a valid device name. If you are unsure, enter 'show disks' to see a list of all disks present.\n";;
			
					esac;;
				
				
					 
			4) 	printf "\n"
					printf "Please select your chosen option "
					printf "\n1  Show all disks on system"
					printf "\n2  Show partitions on main disk only\n"
					 
					read -p "----> " choice
					 
					case $choice in
						1) fdisk -l;;
							  
						2) fdisk -l /dev/sda;;
							  
						*) printf "Invalid option selected";;
					 esac;;
					 

			5) python ChromeFetch.py;;
			6) python MozillaFireFetch.py /mnt/Users/$username/AppData/Roaming/Mozilla/Firefox/Profiles/*;;
			
			7) python Strength_Checker.py;;
			
			8)	## Allows the user to enter their chosen username
				## This is stored in the $username variable
				printf "\nPlease enter the Windows Username of the user you wish to use.\n"
				printf "If you are unsure of the username, please enter 'show users' below, to display\n"
		
				read -p "----> " username
				case $username in
			
					## Shows all Windows users from the SAM file on the Windows partition
					'show users') chntpw -l /mnt//Windows/System32/config/SAM;;
			
					## Saves the user's input to variable $username and displays it to the user
					*) printf "\nYou have selected user: "$username". This can be changed later from the Fetch Main Menu\n";;
		
				esac;;
				
			
			9) chntpw -l /mnt/$userdisk/Windows/System32/config/SAM;;
			
			10) rm /root/FetchRecoveredFiles/*
				  
				  printf "Shutting down Fetch...."
				
				  sleep 5
				
				 reboot;;
					 
		#Esac for Fetch
		esac
        
done
