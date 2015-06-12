#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_output.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;
#source ${current_directory}/create_new_outputversion.command;


#######################################
#Read all tools from file "tools" and
#save the lines as Elements in tool_array().
#Make sure that the last line in "tools" is
#empty!!!
#
#

tool_array=();
while read line;
do 
	tool_array[${#tool_array[*]}]=${line};
done < ${current_directory}/tools;

#######################################


#######################################
#Read all outputs from file "outputs" and
#save the lines as Elements in output_array().
#Make sure that the last line in "output" is
#empty!!!
#
#

output_array=();
while read line;
do 
	output_array[${#output_array[*]}]=${line};
done < ${current_directory}/outputs;

#######################################




clear;

printf "\e[7mCreate New Output for\e[0m\n";
#printf "(q to abort)\n";
#printf "\n";
printf "1) Abort\n";
printf "2) \e[1mTask\e[0m\n";
printf "3) \e[1mAsset\e[0m\n";
printf "#? ";
read a_t_kind;

case "${a_t_kind}" in


1)	exit;
	;;


2)	#Create New Task Output
	cd "${this_p_location}/assets/";
	printf "\n";
	printf "\e[7mSelect Asset to create Output for\e[0m\n";

	select asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
		
		if [[ "${asset}" == "Abort" ]]; then
			exit;
		else
			
			cd "${this_p_location}/assets/${asset}/";
		
			printf "\n";
			printf "\e[7mSelect Task to create Output for\e[0m\n";
		
			select task in Abort $(ls -d */ | grep -v ${asset}_output | grep -v LNK__ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
				if [[ "${task}" == "Abort" ]]; then
					exit;
				else
					
					printf "\n";
					printf "\e[7mChoose output\e[0m\n";
					
					
###################bleibt noch in dieser Schlaufe hŠngen :(((					
					
					select o_choice in Abort ${output_array[@]}; do
						if [[ "${o_choice}" == "Abort" ]]; then
							exit;
						else
							printf "\n";
							printf "\e[7mEnter output name\e[0m\n";
							printf "(q to abort)\n";
							printf "\e[92mAllowed:       A-Z, a-z, 0-9, _\e[0m\n";
							printf "\e[92mWithout extension\e[0m\n";
							#printf "\e[91mNot allowed:   space . , - __ ? # $ \" * etc\e[0m\n";
							printf "${o_choice:0:3}_";
							read o_name;
							
							if [[ "${o_name}" == "q" ]]; then
								exit;
							fi;
							

							
							
							while [[ "${o_name}" == "" ]]; do
								printf "No name given...\n";
								printf "(q to abort)\n";
								printf "${o_choice:0:3}_";
								read o_name;
								if [[ "${o_name}" == "q" ]]; then
									exit;
								fi;
							done;
							
							output=${o_choice:0:3}_${o_name};
							
							if [[ "${task:3:5}" == "_${tool_array[14]:0:3}_" ]]; then
								printf "\n";
								printf "\e[7mExtension of output needed\e[0m\n";
								printf "(q to abort)\n";
								printf "\e[92mAllowed:       EXR, TGA, JPG\e[0m\n";
								printf "${o_choice:0:3}_${o_name}_";
								read o_extension;
								
								if [[ "${o_extension}" == "q" ]]; then
									exit;
								fi;
								
								
								while [[ "${o_extension}" == "" ]]; do
									printf "No extension given...\n";
									printf "(q to abort)\n";
									printf "${o_choice:0:3}_${o_name}_";
									read o_extension;
									if [[ "${o_extension}" == "q" ]]; then
										exit;
									fi;
								done;
								
								output=${o_choice:0:3}_${o_name}_${o_extension};
							fi;
							

							
							
							

							mkdir -p "${this_p_location}/assets/${asset}/${task}/output/${output}";

							
							sh ${this_p_location}/scripts/create_new_outputversion.command ${asset} ${task} ${output};
								

						fi;
					printf "HALLLLLLLLO\n";
					done;
					break;
				fi;
			done;
			break;
		fi;

	done;
	break;

	;;
	
3)	#Create New Asset Output
	cd "${this_p_location}/assets/";
	printf "\n";
	printf "\e[7mSelect Asset to create Output for\e[0m\n";

	select asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
		
		if [[ "${asset}" == "Abort" ]]; then
			exit;
		else
			
			cd "${this_p_location}/assets/${asset}/";
		
			printf "\n";
			printf "\e[7mSelect Task to use Output from\e[0m\n";
			
			select task in Abort $(ls -d */ | grep -vi ${asset}_output | sed -e 's/lib\///g' | sed -e 's/\///g'); do
				if [[ "${task}" == "Abort" ]]; then
					exit;
				else
					
					#if [[ ! -d  "${this_p_location}/assets/${asset}/${task}/lib/current" ]]; then
					if [[ ! $(ls -A "${this_p_location}/assets/${asset}/${task}/output/") ]]; then
						printf "Task ${task} has no output.\n";
						printf "Go and fix.\n";
					else
						cd "${this_p_location}/assets/${asset}/${task}/output/";
						printf "\n";
						printf "\e[7mSelect Output to use as Asset/Shot output\e[0m\n";
						select output in Abort $(ls -d */ | sed -e 's/\///g'); do
							if [[ "${output}" == "Abort" ]]; then
								exit;
							else
								printf "${output}\n";
								mkdir -p "${this_p_location}/assets/${asset}/${asset}_output/input/";
								mkdir -p "${this_p_location}/assets/${asset}/${asset}_output/output/";
								#ln -sfn "${this_p_location}/assets/${asset}/${task}/lib/current/${publish}" "${this_p_location}/assets/${asset}/${asset}_output/input/${asset}__${task}__${publish}";
								
								cd "${this_p_location}/assets/${asset}/${asset}_output/input/";
								ln -sfn "./../../../../assets/${asset}/${task}/lib/current/${output}/" "${asset}__${task}__${output}";
								
								break;
							fi;
						done;
						break;
					fi;
				fi;
			done;
			break;
			
		fi;
	done;
	
	sh ${current_directory}/spaghetti_refresher.command;
	
	break;
	;;
	
*)	printf "Invalid selection\n";
	printf "exitting...\n";
	sleep 3;
	exit;
	;;

esac;



exit;