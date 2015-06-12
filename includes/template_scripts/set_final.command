#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#set_final.command template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

clear;

cd "${this_p_location}/assets/";
printf "\e[7mSelect Asset to use for final\e[0m\n";
select asset_final in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
	
 	if [[ "${asset_final}" == "Abort" ]]; then
 		exit;
 	else
 		printf "\n";
 		printf "\e[7mSelect Task\e[0m\n";
		cd "${this_p_location}/assets/${asset_final}/";
		select task_final in Abort $(ls -d */ | grep -vi ${asset}_output | grep -vi LNK__ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
			if [[ "${task_final}" == "Abort" ]]; then
				exit;
			else
				cd "${this_p_location}/assets/${asset_final}/${task_final}/lib/current";
				printf "\n";
				printf "\e[7mSelect Tasks existing Output\e[0m\n";
				select output_final in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
					if [[ "${output_final}" == "Abort" ]]; then
						exit;
					else
						#rm "${this_p_location}/assets/${asset_input}/${task_input}/input/${output}";
						ln -sfn "${this_p_location}/assets/${asset_final}/${task_final}/lib/current/${output_final}" "${this_p_location}/final/${asset_final}___${task_final}___${output_final}";
						break;
					fi;
				done;
				break;
			fi;
		done;
		break;
 	fi;
done;

exit;
