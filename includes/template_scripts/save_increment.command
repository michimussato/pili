#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################

#save_increment.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;



function save_increment {
	
	#printf "argv1 = ${1}\n";
	#printf "argv2 = ${2}\n";
	#printf "argv3 = ${3}\n";
	
	
	time_stamp=`date +"%Y-%m-%d_%H%M-%S"`;
	

	#clear;
	
	printf "\e[31mHit key to save increment\e[0m\n";
	
	yes_no="lets_skip_this_shit";
	
	read -n 1 -s -t 2 yes_no;
	
	#strangely, this if function works inversely :-///
	if [[ ${yes_no} != "lets_skip_this_shit" ]]; then
	
		printf "\e[32mSaving increment...\e[0m\n";
		sleep 1;
		cd "${2}";
		mkdir -p "${2}/increments/${time_stamp}";
		cp "${1}" "${2}/increments/${time_stamp}/${1}";
		if [[ -n ${3} ]]; then
			cp -r "${3}" "${2}/increments/${time_stamp}/";
		fi;
		
		#break;
		
	else
	
		printf "\e[31mNo increment saved...\e[0m\n";
		sleep 1;
		#break;
	
	fi;
	
	#exit;
	
	}