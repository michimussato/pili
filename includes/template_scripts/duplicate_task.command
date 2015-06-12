#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_task.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};



source ${current_directory}/conf/config.p_conf;
cd ${this_p_location}/assets;

clear;

printf "\e[7mSelect Asset/Shot containing the Task you want to duplicate\e[0m\n";
#printf "(q to abort)\n";
#printf "\n";

#printf "Select Asset to duplicate a Task from\n";

select from_asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
	if [[ "${from_asset}" == "Abort" ]]; then
		exit;
	else
		printf "\n";
		printf "\e[7mSelect Task\e[0m\n";
		cd "${this_p_location}/assets/${from_asset}/";
		select from_task in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
			if [[ "${from_task}" == "Abort" ]]; then
				exit;
			elif [[ "${from_task:(-7)}" == "_output" ]]; then
				printf "Cannot duplicate Asset output.\n";
				printf "cancelled...\n";
				sleep 3;
				exit;
			else
				cd "${this_p_location}/assets";
				printf "\n";
				printf "\e[7mSelect Asset to duplicate to\e[0m\n";
				select to_asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
					if [[ "${to_asset}" == "Abort" ]]; then
						exit;
					else
						printf "\n";
						printf "\e[7mEnter name for Duplicate\e[0m\n";
						printf "(Leave blank for \"originalName_copy\")\n";
						printf "(q to abort)\n";
						printf "\e[92mAllowed:       A-Z, a-z, 0-9, _\e[0m\n";
						printf "${from_task:0:7}__"
						read duplicate_name;
						
						if [[ "$duplicate_name" == "q" ]]; then
							exit;
						fi;
						
						printf "\n";
						printf "\e[7mKeep outputs?\e[0m\n";
						printf "(lib will not be duplicated)\n";
						
						select keep_outputs in Abort Yes No; do
						
						#read keep_outputs;
						
							
							if [[ "$duplicate_name" == "" ]]; then
								if [[ "${keep_outputs}" == "Abort" ]]; then
									exit;
								elif [[ "${keep_outputs}" == "No" ]]; then
									rsync -arvh --progress --exclude "incrementalSave" --exclude "lib/*" --exclude "output/*" --exclude "tmp/*" --exclude "locked" "${this_p_location}/assets/${from_asset}/${from_task}/." "${this_p_location}/assets/${to_asset}/${from_task}_copy/";
								elif [[ "${keep_outputs}" == "Yes" ]]; then
									rsync -arvh --progress --exclude "incrementalSave" --exclude "lib/*" --exclude "tmp/*" --exclude "locked" "${this_p_location}/assets/${from_asset}/${from_task}/." "${this_p_location}/assets/${to_asset}/${from_task}_copy/";
									
									cd "${this_p_location}/assets/${to_asset}/${from_task}_copy/output/";
									for output_channel in $(ls -d */); do
										latest_output=$(ls -t "${this_p_location}/assets/${to_asset}/${from_task}_copy/output/${output_channel}/" | grep -v current | sort -nr | head -1);
										cd "${this_p_location}/assets/${to_asset}/${from_task}_copy/output/${output_channel}/";
										ln -sfn "./../../../../../assets/${to_asset}/${from_task}_copy/output/${output_channel}/${latest_output}/" "current";
									done;
								
								fi;
								if [[ -d "${this_p_location}/assets/${to_asset}/${from_task}_copy/usr/scenes" ]]; then
									#maya scenes rename:
									cd "${this_p_location}/assets/${to_asset}/${from_task}_copy/usr/scenes";
									for i in $(find . | grep "${from_task}"); do
										#printf "${from_task}";
										mv ${i} ${i//${from_task}/${from_task}_copy};
										done;
										
									rm -rf ${this_p_location}/assets/${to_asset}/${from_task}_copy/meta;
									touch ${this_p_location}/assets/${to_asset}/${from_task}_copy/meta;
									printf "${USER}\n" > ${this_p_location}/assets/${to_asset}/${from_task}_copy/meta;
									
									break;
								else
									#scene rename for everything else
									cd "${this_p_location}/assets/${to_asset}/${from_task}_copy/usr";
									for i in $(find . | grep "${from_task}"); do
										#printf "${from_task}";
										mv ${i} ${i//${from_task}/${from_task}_copy};
										done;
										
									rm -rf ${this_p_location}/assets/${to_asset}/${from_task}_copy/meta;
									touch ${this_p_location}/assets/${to_asset}/${from_task}_copy/meta;
									printf "${USER}\n" > ${this_p_location}/assets/${to_asset}/${from_task}_copy/meta;
									
									break;
								fi;
							
							
							else
								if [[ "${keep_outputs}" == "Abort" ]]; then
									exit;
								elif [[ "${keep_outputs}" == "No" ]]; then
									rsync -arvh --progress --exclude "incrementalSave" --exclude "lib/*" --exclude "output/*" --exclude "tmp/*" --exclude "locked" "${this_p_location}/assets/${from_asset}/${from_task}/." "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/";
								elif [[ "${keep_outputs}" == "Yes" ]]; then
									rsync -arvh --progress --exclude "incrementalSave" --exclude "lib/*" --exclude "tmp/*" --exclude "locked" "${this_p_location}/assets/${from_asset}/${from_task}/." "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/";
								
									cd "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/output/";
									for output_channel in $(ls -d */); do
										latest_output=$(ls -t "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/output/${output_channel}/" | grep -v current | sort -nr | head -1);
										cd "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/output/${output_channel}/";
										ln -sfn "./../../../../../assets/${to_asset}/${from_task:0:7}__${duplicate_name}/output/${output_channel}/${latest_output}/" "current";
									done;
								
								fi;	
								if [[ -d "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/usr/scenes" ]]; then
									#maya scenes rename:
									cd "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/usr/scenes";
									for i in $(find . | grep "${from_task}"); do
										#printf "${from_task}";
										mv ${i} ${i//${from_task}/${from_task:0:7}__${duplicate_name}};
										done;
									
									rm -rf ${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/meta;
									touch ${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/meta;
									printf "${USER}\n" > ${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/meta;
									
									break;
								else
									#scene rename for everything else
									cd "${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/usr";
									for i in $(find . | grep "${from_task}"); do
										#printf "${from_task}";
										mv ${i} ${i//${from_task}/${from_task:0:7}__${duplicate_name}};
										done;
									
									rm -rf ${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/meta;
									touch ${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/meta;
									printf "${USER}\n" > ${this_p_location}/assets/${to_asset}/${from_task:0:7}__${duplicate_name}/meta;
									
									break;
									
								fi;
								break;
							fi;
							break;
						done;
						break;
					fi;
				done;
				break;
			fi;
		done;
		break;
	fi;
done;

sh ${current_directory}/spaghetti_refresher.command;

exit;
