#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_outputversion.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;



function new_outputversion {

	time_stamp=`date +"%Y-%m-%d_%H%M-%S"`;

	mkdir -p "${this_p_location}/assets/${1}/${2}/output/${3}/${time_stamp}/";
	touch "${this_p_location}/assets/${1}/${2}/output/${3}/${time_stamp}/${3}";
	
	cd "${this_p_location}/assets/${1}/${2}/output/${3}/";
	ln -sfn "./../../../../../assets/${1}/${2}/output/${3}/${time_stamp}/" "current";
	
	#ln -sfn "${this_p_location}/assets/${1}/${2}/output/${3}/${time_stamp}/outputset" "${this_p_location}/assets/${1}/${2}/output/${3}/current";
						

}









if [ ${1} != "" ]; then

	printf ${1};

	new_outputversion ${1} ${2} ${3};
	
else


	clear;

	printf "\e[7mSelect Asset or Shot to create a new Output version for\e[0m\n";

	cd "${this_p_location}/assets/";

	select asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
		if [[ "${asset}" == "Abort" ]]; then
			exit;
		else
			cd "${this_p_location}/assets/${asset}/";
			printf "\n";
			printf "\e[7mSelect Task which contains your Output channel\e[0m\n";
			select task in Abort $(ls -d */| grep -vi ${asset}_output | grep -vi LNK__ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
				printf "\n";
				if [[ "${task}" == "Abort" ]]; then
					exit;
				else
					cd "${this_p_location}/assets/${asset}/${task}/output";
					printf "\n";
					printf "\e[7mSelect Output you need a new version for\e[0m\n";
					
					
					
					outputs=($(ls -d */ | sed -e 's/\///g'));
					
					
					menu() {
#					echo "Avaliable options:"
						for i in ${!outputs[@]}; do 
							printf "%1d%s) %s\n" $((i+1)) "${choices[i]:-}" "${outputs[i]}";
						done;
						[[ "$msg" ]] && echo "$msg"; :
					}
	
					prompt="Check/uncheck an option, ENTER when done: ";
					
					while menu && read -rp "$prompt" num && [[ "$num" ]]; do
						printf "\n";
						printf "\e[7mSelect Output you need a new version for\e[0m\n";
						[[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#outputs[@]} )) || {
							msg="Invalid option: $num"; continue;
						}
						((num--)); #msg="${outputs[num]} was ${choices[num]:+un}checked"
						[[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
					done;
					
					printf "\nWill create a new output version for"; msg=" nothing"
					for b in ${!outputs[@]}; do 
						#printf "${choices[b]}";
						[[ "${choices[b]}" ]] && { printf " %s" "${outputs[b]}"; msg=""; }
					done
					printf "\n";
					echo "$msg"
					
					
					
					
					printf "\n";
					printf "\e[7mRun Spaghetti Refresher after publish?\e[0m\n";
					select update_spaghetti in Abort Yes No; do
						if [[ "${update_spaghetti}" == "Abort" ]]; then
							exit;
						elif [[ "${update_spaghetti}" == "Yes" ]]; then
							printf "Will run Spaghetti Refresher after publish\n";
							break;
						elif [[ "${update_spaghetti}" == "No" ]]; then
							printf "Will skip Spaghetti Refresher after publish\n";
							break;
						fi;
					done;
					
					
					for i in ${!outputs[@]}; do 
						if [[ "${choices[i]}" ]] ; then
							new_outputversion ${asset} ${task} ${outputs[i]};
						fi;
					done;
					break;
				fi;
			done;
			break;
		fi;
	done;

fi;

if [[ "${update_spaghetti}" == "Yes" ]]; then
	sh ${current_directory}/spaghetti_refresher.command;
fi;

exit;