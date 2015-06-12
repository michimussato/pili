#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_publish.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

time_stamp=`date +"%Y-%m-%d_%H%M-%S"`;

clear;

printf "\e[7mSelect Asset to Publish new output contents from\e[0m\n";

cd "${this_p_location}/assets/";

select asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
	printf "\n";
	if [[ "${asset}" == "Abort" ]]; then
		exit;
	else
		printf "\e[7mSelect Task\e[0m\n";
		cd "${this_p_location}/assets/${asset}/";
		select task in Abort $(ls -d */ | grep -vi ${asset}_output | grep -vi LNK__ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
			if [[ "${task}" == "Abort" ]]; then
				exit;
			else
				cd "${this_p_location}/assets/${asset}/${task}/output";
				printf "\n";
				printf "\e[7mSelect Output(s)\e[0m\n";
				
			
				

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
					printf "\e[7mSelect Output(s)\e[0m\n";
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


					
						
						
						
				while [ -f "${this_p_location}/assets/${asset}/${task}/publishing" ]; do
					
					clear;
					cat "${this_p_location}/assets/${asset}/${task}/publishing";
					printf "\e[1m\e[31mis currently publishing\e[0m";
					printf "\n";
					sleep 0.2;
					clear;
					cat "${this_p_location}/assets/${asset}/${task}/publishing";
					printf "\e[1m\e[31mis currently publishing.\e[0m";
					printf "\n";
					sleep 0.2;
					clear;
					cat "${this_p_location}/assets/${asset}/${task}/publishing";
					printf "\e[1m\e[31mis currently publishing..\e[0m";
					printf "\n";
					sleep 0.2;
					clear;
					cat "${this_p_location}/assets/${asset}/${task}/publishing";
					printf "\e[1m\e[31mis currently publishing...\e[0m";
					printf "\n";
					sleep 1;
					
				
				done;
						
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
						
						touch "${this_p_location}/assets/${asset}/${task}/publishing";
						printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/publishing";
						
						#latest_output=$(ls -t "${this_p_location}/assets/${asset}/${task}/output/${output}/" | grep -v current | sort -nr | head -1);
						#latest_output="${this_p_location}/assets/${asset}/${task}/output/${output}/current/";
						
						if [ ! -z "$(ls ${this_p_location}/assets/${asset}/${task}/lib/)" ]; then
						
    						last_publish=$(ls -t "${this_p_location}/assets/${asset}/${task}/lib/" | grep -v current | sort -nr | head -1);
    						
    						#create folder with the name of the latest output to publish:
    						mkdir -p "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/";
    						
    						#sync copy everything from the last lib folder to the new latest lib folder:
							rsync -rvht --min-size="1" --progress ${this_p_location}/assets/${asset}/${task}/lib/${last_publish}/. "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/";
							#sync-copy everyting from the latest output version to the new latest lib folder; overwrite older versions of the same files
							
							
							for i in ${!outputs[@]}; do 
								latest_output=$(ls -t "${this_p_location}/assets/${asset}/${task}/output/${outputs[i]}/" | grep -v current | sort -nr | head -1);
								
								if [[ "${choices[i]}" ]] ; then
									rsync -rvht --min-size="1" --progress --delete --delete-before ${this_p_location}/assets/${asset}/${task}/output/${outputs[i]}/${latest_output}/. "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/${outputs[i]}/";
									touch "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/${outputs[i]}.version.txt";
									printf ${latest_output} > "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/${outputs[i]}.version.txt";
								
								fi;
							
							done;
							
							#check, if current folder is still available; if not, create it:
							#if [ ! -d "$(ls ${this_p_location}/assets/${asset}/${task}/lib/current)" ]; then
							#	mkdir -p "${this_p_location}/assets/${asset}/${task}/lib/current";
								#break;
							#fi;
							
							#break;
							
							
						else
							
							#create folder with the name of the latest output to publish:
							mkdir -p "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/";
							#sync-copy everyting from the latest output version to the new latest lib folder; overwrite older versions of the same files
							
							
							for i in ${!outputs[@]}; do 
								latest_output=$(ls -t "${this_p_location}/assets/${asset}/${task}/output/${outputs[i]}/" | grep -v current | sort -nr | head -1);
								
								if [[ "${choices[i]}" ]] ; then 
									rsync -rvht --min-size="1" --progress --delete --delete-before ${this_p_location}/assets/${asset}/${task}/output/${outputs[i]}/${latest_output}/. "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/${outputs[i]}/";
									touch "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/${outputs[i]}.version.txt";
									printf ${latest_output} > "${this_p_location}/assets/${asset}/${task}/lib/${time_stamp}/${outputs[i]}.version.txt";
																
								fi;
							
							done;
							
							#create current folder:
							#mkdir -p "${this_p_location}/assets/${asset}/${task}/lib/current/";
							
							#break;
							
						fi;
						
						#sync the latest lib folder with the new current (latest and current are now copies!!!)
						#rsync -rvh --progress --delete --delete-before --checksum ${this_p_location}/assets/${asset}/${task}/lib/${latest_output}/. "${this_p_location}/assets/${asset}/${task}/lib/current";
						
						cd "${this_p_location}/assets/${asset}/${task}/lib/";
						#rm current;
						ln -sfn "./../../../../assets/${asset}/${task}/lib/${time_stamp}/" "current";
						
						#ln -sfn "${this_p_location}/scripts/create_asset_output.command" "${this_p_location}/assets/${asset}/Create Asset Output";
						
						break;
#					fi;
# 				done;
# 				break;
 			fi;
		done;
		break;
	fi;
done;

rm "${this_p_location}/assets/${asset}/${task}/publishing";

if [[ "${update_spaghetti}" == "Yes" ]]; then
	sh ${current_directory}/spaghetti_refresher.command;
fi;

#done;

#exit;