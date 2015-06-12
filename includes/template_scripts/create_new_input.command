#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_input.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

clear;

cd "${this_p_location}/assets/";
printf "\e[7mSelect Asset which contains the task you want to create new Input for\e[0m\n";
select asset_input in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
	#printf "${asset_input} selected\n";
	
 	if [[ "${asset_input}" == "Abort" ]]; then
 		exit;
# 	elif [[ ! -d "${this_p_location}/assets/${asset_input}/*" ]]; then
# 	 	printf "Asset contains no tasks\n";
# 		printf "Exitting...";
# 		sleep 2;
#		exit;
 	else
 		printf "\n";
 		printf "\e[7mSelect Task you want to create the Input for\e[0m\n";
		cd "${this_p_location}/assets/${asset_input}/";
		select task_input in Abort $(ls -d */ | grep -vi ${asset}_output | grep -vi LNK__ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
			if [[ "${task_input}" == "Abort" ]]; then
				exit;
			else
#				cd "${this_p_location}/assets/";
#				printf "\n";
#				printf "Choose Existing Output:\n";
#				select asset_output in $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g') q; do
#					if [[ "${asset_output}" == "q" ]]; then
#						exit;
#					else
#						cd "${this_p_location}/assets/${asset_input}/";
						printf "\n";
						printf "\e[7mSelect Task which contains the existing Output\e[0m\n";
						select task_output in Abort $(ls -d */ | grep -vi ${task_input} | grep -vi ${asset}_output | sed -e 's/lib\///g' | sed -e 's/\///g'); do
							if [[ "${task_output}" == "Abort" ]]; then
								exit;
							elif [[ "${task_output}" == "${task_input}" ]]; then
								printf "Same Task chosen twice.\n";
								printf "Can't create an Input to itself\n";
								printf "cancelled...\n";
								sleep 3;
								exit;
							else
								#if [[ -d "${this_p_location}/assets/${asset_input}/${task_output}/lib/current" ]]; then
								if [[ $(ls -A ${this_p_location}/assets/${asset_input}/${task_output}/output/) ]]; then
									cd "${this_p_location}/assets/${asset_input}/${task_output}/output/";
									printf "\n";
									printf "\e[7mSelect Tasks existing Output(s)\e[0m\n";
									
									
									
									
									outputs=($(ls | sed -e 's/\///g'));
					
									menu() {
#										echo "Avaliable options:"
										for i in ${!outputs[@]}; do 
											printf "%1d%s) %s\n" $((i+1)) "${choices[i]:-}" "${outputs[i]}";
										done;
										[[ "$msg" ]] && echo "$msg"; :
									}
					
									prompt="Check/uncheck an option, ENTER when done: ";
									
									while menu && read -rp "$prompt" num && [[ "$num" ]]; do
										printf "\n";
										printf "\e[7mSelect Tasks existing Output(s)\e[0m\n";
										[[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#outputs[@]} )) || {
											msg="Invalid option: $num"; continue;
										}
										((num--)); #msg="${outputs[num]} was ${choices[num]:+un}checked"
										[[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
									done;
									
									printf "\nWill publish"; msg=" nothing"
									for b in ${!outputs[@]}; do 
										#printf "${choices[b]}";
										[[ "${choices[b]}" ]] && { printf " %s" "${outputs[b]}"; msg=""; }
									done
									printf "\n";
									echo "$msg"
												
														
																
											
									
									
									printf "\n";
									printf "\e[7mRun Spaghetti Refresher after input creation?\e[0m\n";
									select update_spaghetti in Abort Yes No; do
										if [[ "${update_spaghetti}" == "Abort" ]]; then
											exit;
										elif [[ "${update_spaghetti}" == "Yes" ]]; then
											printf "Will run Spaghetti Refresher after input creation\n";
											break;
										elif [[ "${update_spaghetti}" == "No" ]]; then
											printf "Will skip Spaghetti Refresher after input creation\n";
											break;
										fi;
									done;
									
									
									
									
									
									
									
									
									
									#select output in Abort $(ls | sed -e 's/lib\///g' | sed -e 's/\///g'); do
										#if [[ "${output}" == "Abort" ]]; then
											#exit;
										#else
											#rm "${this_p_location}/assets/${asset_input}/${task_input}/input/${output}";
											
									cd "${this_p_location}/assets/${asset_input}/${task_input}/input/";
									
									for i in ${!outputs[@]}; do
										if [[ "${choices[i]}" ]] ; then
											ln -sfn "./../../../../assets/${asset_input}/${task_output}/lib/current/${outputs[i]}/" "${asset_input}__${task_output}__${outputs[i]}";
										fi;
									done;
											

									break;
									
								else
									printf "There is no output for ${task_output}!\n";
									printf "Go and create one!\n";
									printf "Exitting...\n";
									sleep 5;
									exit;
								fi;
							fi;
						done;
						break;
					fi;
				done;
				break;
#			fi;
#		done;
		break;
 	fi;
done;

if [[ "${update_spaghetti}" == "Yes" ]]; then
	sh ${current_directory}/spaghetti_refresher.command;
fi;

exit;