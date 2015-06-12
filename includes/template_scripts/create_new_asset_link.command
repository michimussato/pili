#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################
#create_new_asset_link.command.template


current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

clear;

printf "\e[7mCreate New Asset/Shot Link\e[0m\n";
#printf "\n";

#printf "Link Asset to Shots or Assets?\n";
printf "1) Abort\n";
printf "2) \e[1mCreate Asset Link\e[0m\n";
printf "3) \e[1mCreate Shot Link\e[0m\n";
printf "#? ";
read a_s_choice;

case "${a_s_choice}" in
	1)	exit;
		;;
	2)	#a_s_kind="assets";
		a_s_tag="AST_";
		;;
	3)	#a_s_kind="shots";
		a_s_tag="SHT_";
		;;
	*)	printf "Invalid selection\n";
		printf "exitting...\n";
		sleep 3;
		exit;
		;;
esac

cd ${this_p_location}/assets;





cd "${this_p_location}/assets/";
printf "\n";
printf "\e[7mSelect Asset/Shot to create a Link from\e[0m\n";
select asset_from in Abort $(ls -d ${a_s_tag}*/ | sed -e 's/lib\///g' | sed -e 's/\///g'); do

	if [[ "${asset_from}" == "Abort" ]]; then
		exit;
	fi;	
	
	
	
	if [[ -d "${this_p_location}/assets/${asset_from}/${asset_from}_output/input/" ]]; then
		cd "${this_p_location}/assets/${asset_from}/${asset_from}_output/input/";
		if [[ $(ls | sed -e 's/\///g') == "" ]]; then
			printf "Asset ${asset_from} has no xfer.\n";
			printf "Go and fix.\n";
			break;
		else
			#printf "Asset has output\n";
			
			cd "${this_p_location}/assets/";
			
			printf "\n";
			printf "\e[7mSelect Asset to add link to\e[0m\n";
			select asset_to in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do

				if [[ "${asset_to}" == "Abort" ]]; then
					exit;
				elif [[ "${asset_to}" == "${asset_from}" ]]; then
					printf "Can't link Asset/Shot to itself\n";
					printf "cancelled...\n";
					sleep 3;
					exit;
				fi;	
				
				mkdir -p "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/input/";
				mkdir -p "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/lib/";
				
				cd "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/";
				ln -sfn "./../../../assets/${asset_from}/${asset_from}_output/input/" "output";
				
				cd "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/lib/";
				ln -sfn "./../../../../assets/${asset_from}/${asset_from}_output/input/" "current";
				
				#ln -sfn "${this_p_location}/${a_s_kind}/${asset_from}/${asset_from}_output/input/" "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/output";
				#ln -sfn "${this_p_location}/${a_s_kind}/${asset_from}/${asset_from}_output/input/" "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/lib/current";
					
				break;
				
			done;
			break;
			
			
		fi;
	else
		printf "No directory ${asset_from}_output/input/ found.\n";
		printf "cancelled...";
		sleep 3;
		break;
	fi;
	

done;

sh ${current_directory}/spaghetti_refresher.command;

exit;
