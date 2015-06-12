#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_task.command.template

#Font: http://patorjk.com/software/taag/#p=display&f=Standard&t=Nuke

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;





#######################################
#Read all tasks from file "tasks" and
#save the lines as Elements in task_array().
#Make sure that the last line in "task" is
#empty!!!
#
#

task_array=();
while read line;
do 
	task_array[${#task_array[*]}]=${line};
done < ${current_directory}/tasks;

#######################################

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




clear;

printf "\e[7mCreate New Task\e[0m\n";
#printf "\n";

#printf "New Asset- or Shot-Task?\n";
printf "1) Abort\n";
printf "2) \e[1mCreate Task in Asset\e[0m\n";
printf "3) \e[1mCreate Task in Shot\e[0m\n";
printf "#? ";
read a_s_choice;

while [[ "${a_s_choice}" == "" ]]; do
	printf "No choice given...\n";
	printf "(3 to abort)\n";
	read a_s_choice;
done;

case "${a_s_choice}" in
	1)	exit;
		;;
	2)	a_s_kind="AST_";
		asset_or_shot="Asset";
		;;
	3)	a_s_kind="SHT_";
		asset_or_shot="Shot";
#		printf "\n";
#		printf "Select Shot to create a Task for\n";
		;;
	*)	printf "Invalid selection\n";
		printf "exitting...\n";
		sleep 3;
		exit;
		;;
esac

cd ${this_p_location}/assets;

if [[ -z $(ls -d ${a_s_kind}*/) ]]; then
	printf "No ${asset_or_shot} found.\n";
	printf "Cannot create a task outside of a ${asset_or_shot}.\n";
	sleep 1;
	printf "Go and create a ${asset_or_shot} first!\n";
	sleep 2;
	exit;
fi;





printf "\n";
printf "\e[7mSelect ${asset_or_shot} to create a Task for\e[0m\n";
	
#select asset_or_shot in $(ls -d */ | grep -i ${a_s_kind} | sed -e s/${a_s_kind}//g | sed -e 's/lib\///g' | sed -e 's/\///g') q; do
select asset_or_shot in Abort $(ls -d */ | grep -i ${a_s_kind} | sed -e 's/lib\///g' | sed -e 's/\///g'); do
	if [[ "${asset_or_shot}" == "Abort" ]]; then
		exit;
	else
		printf "\n";
		#printf "${asset_or_shot}\n";
		printf "\e[7mChoose task to create\e[0m\n";
		#printf "${task_array[15]:0:3}\n";
		select t_kind in Abort ${task_array[@]}; do
			#printf ${t_kind};
			if [[ "${t_kind}" == "Abort" ]]; then
				exit;
				
			
			#elif [[ "${t_kind}" == "${task_array[15]:0:3}" ]]; then
			elif [[ "${t_kind:0:3}" == "${task_array[15]:0:3}" ]]; then
				#printf "test\n";
				#exit;
						
						
				#######################################
				#    _____ _ _      ____                _           
				#   |  ___(_) | ___|  _ \ ___  __ _  __| | ___ _ __ 
				#   | |_  | | |/ _ \ |_) / _ \/ _` |/ _` |/ _ \ '__|
				#   |  _| | | |  __/  _ <  __/ (_| | (_| |  __/ |   
				#   |_|   |_|_|\___|_| \_\___|\__,_|\__,_|\___|_|   
                                                                                      
						
				printf "\n";
				printf "\e[7mEnter task name\e[0m\n";
				printf "(q to abort)\n";
				printf "\e[92mAllowed:       A-Z, a-z, 0-9, _\e[0m\n";
				printf "${t_kind:0:3}__";
				read t_name;
				
				while [[ "${t_name}" == "" ]]; do
					printf "No name given...\n";
					printf "(q to abort)\n";
					printf "${t_kind:0:3}__";
					read t_name;
				done;
				
				if [[ "${t_name}" == "q" ]]; then
					exit;
				fi;
						
						
				a_s_root=${this_p_location}/assets/${asset_or_shot};
				a_s_path=${a_s_root}/${t_kind:0:3}__${t_name};
				
				if [ -d "${a_s_path}" ]; then
					printf "${t_kind:0:3}__${t_name} already exists.\n";
					printf "Operation cancelled.\n";
					sleep 3;
					exit;
				fi;
				
				cd ${this_p_location}/transfer/incoming/;
				
				if [[ -z $(ls -d */) ]]; then
					printf "No incoming folder found.\n";
					printf "cancelled...";
					sleep 3;
					exit;
				fi;
				
				printf "\n";
				printf "\e[7mSelect incoming folder\e[0m\n";
				select incoming_folder in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
					
					if [[ "${asset_from}" == "Abort" ]]; then
						exit;
					fi;	
					
					if [[ -d "${this_p_location}/transfer/incoming/${incoming_folder}/" ]]; then
					
						#printf "\n";
						#printf "Enter path to date folder\n";
						#printf "${this_p_location}/transfer/incoming/";
						#read t_source;
				
						#while [[ "${t_source}" == "" ]]; do
						#	printf "No path given...\n";
						#	printf "(q to abort)\n";
						#	printf "${this_p_location}/transfer/incoming/";
						#	read t_source;
						#done;
				
						mkdir -p "${a_s_path}/";
						mkdir -p "${this_p_location}/transfer/incoming/${incoming_folder}"
				
						touch ${a_s_path}/meta;
						printf "${USER}\n" > ${a_s_path}/meta;
						
						
						mkdir -p "${a_s_path}/input/";
						mkdir -p "${a_s_path}/lib/";
						#mkdir -p "${this_p_location}/assets/${asset_to}/LNK__${asset_from}/lib/";
				
						cd "${a_s_path}/";
						#pwd;
						ln -sfn "./../../../transfer/incoming/${incoming_folder}/current/" "output";
								
				
						cd "${a_s_path}/lib/";
						#pwd;
						ln -sfn "./../../../../transfer/incoming/${incoming_folder}/current/" "current";
								
				
						cd "${this_p_location}/transfer/incoming/${incoming_folder}/";
						#cd ..;
						#pwd;
						ln -sfn "./../../../transfer/incoming/${incoming_folder}/to_pili/" "current";
				
				
						cd "${this_p_location}/transfer/incoming/${incoming_folder}/current/";
						
						for incoming_subfolder in $(ls -d */); do
						
							#cd "${this_p_location}/transfer/incoming/${incoming_folder}/current/${incoming_subfolder}/";
							cd "${this_p_location}/transfer/incoming/${incoming_folder}/current/${incoming_subfolder}/";
							
							#ln -sfn "./../../../../../transfer/incoming/${incoming_folder}/current/${incoming_subfolder}/1234" "current";
							#files_subfolder=($(ls -d */));
							#for i in ${files_subfolder}; do
							for files_subfolder in $(ls -d */); do
								printf "${i}\n";
								ln -sfn "./../../../../../transfer/incoming/${incoming_folder}/current/${incoming_subfolder}/${files_subfolder}" "current";
							done;
						
						done;
						
						break;
						
					else
						
						printf "Something went wrong.\n";
						sleep 3;
						exit;
				
					fi;
					
				
					
					#######################################	
				
				done;
				break;
			
				
			else
				printf "\n";
				printf "\e[7mChoose tool for ${t_kind:0:3}-task\e[0m\n";
				select t_tool in Abort ${tool_array[@]}; do
					if [[ "${t_tool}" == "Abort" ]]; then
						exit;
						
					else
						printf "\n";
						printf "\e[7mEnter task name\e[0m\n";
						printf "(q to abort)\n";
						printf "\e[92mAllowed:       A-Z, a-z, 0-9, _\e[0m\n";
						#printf "\e[91mNot allowed:   space . , - __ ? # $ \" * etc\e[0m\n";
						printf "${t_kind:0:3}_${t_tool:0:3}__";
						read t_name;
						
						while [[ "${t_name}" == "" ]]; do
							printf "No name given...\n";
							printf "(3 to abort)\n";
							printf "${t_kind:0:3}_${t_tool:0:3}__";
							read t_name;
						done;
						
						if [[ "${t_name}" == "q" ]]; then
							exit;
						fi;
						
						
						
						a_s_root=${this_p_location}/assets/${asset_or_shot};
						a_s_path=${a_s_root}/${t_kind:0:3}_${t_tool:0:3}__${t_name};
						
						
						if [ -d "${a_s_path}" ]; then
							printf "${t_kind:0:3}_${t_tool:0:3}__${t_name} already exists.\n";
							printf "Operation cancelled.\n";
							sleep 3;
							exit;
						fi;
						
						
						mkdir -p ${a_s_path}/usr;
						mkdir -p ${a_s_path}/lib;	
						mkdir -p ${a_s_path}/output;
						mkdir -p ${a_s_path}/input;
						
						touch ${a_s_path}/meta;
						printf "${USER}\n" > ${a_s_path}/meta;
						
						#ln -sf "${this_p_location}/scripts/create_new_input.command" "${a_s_path}/input/Create New Input";
						#ln -sf "${this_p_location}/scripts/create_new_output.command" "${a_s_path}/output/Create New Output";
						
				
						#######################################
						#  __  __                   
						# |  \/  | __ _ _   _  __ _ 
						# | |\/| |/ _` | | | |/ _` |
						# | |  | | (_| | |_| | (_| |
						# |_|  |_|\__,_|\__, |\__,_|
						#               |___/       
						
						if [[ ${t_tool:0:3} == "${tool_array[0]:0:3}" ]] ; then {
							
							printf "This is gonna be a Maya task\n";
							mkdir -p "${a_s_path}/usr/externalFiles";
							mkdir -p "${a_s_path}/usr/scenes";
							mkdir -p "${a_s_path}/usr/sourceimages";
							mkdir -p "${a_s_path}/usr/tmp/renderData/mentalray";
							mkdir -p "${a_s_path}/usr/uvLayout";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Maya (latest MA)";
							cp "${this_p_location}/scripts/template_documents/null_autodesk_maya2013_x64.ma" "${a_s_path}/usr/scenes/${t_kind:0:3}_${t_tool:0:3}__${t_name}.ma";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#   ____ _                              _  _   ____  
						#  / ___(_)_ __   ___ _ __ ___   __ _  | || | |  _ \ 
						# | |   | | '_ \ / _ \ '_ ` _ \ / _` | | || |_| | | |
						# | |___| | | | |  __/ | | | | | (_| | |__   _| |_| |
						#  \____|_|_| |_|\___|_| |_| |_|\__,_|    |_| |____/ 
						#                                                    
						
						elif [ ${t_tool:0:3} == "${tool_array[1]:0:3}" ] ; then {
							printf "This is gonna be a Cinema4D task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Cinema 4D (latest C4D)";
							cp "${this_p_location}/scripts/template_documents/null_maxon_cinema4d_r15_x64.c4d" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}_0001.c4d";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  __  __           _ _               
						# |  \/  |_   _  __| | |__   _____  __
						# | |\/| | | | |/ _` | '_ \ / _ \ \/ /
						# | |  | | |_| | (_| | |_) | (_) >  < 
						# |_|  |_|\__,_|\__,_|_.__/ \___/_/\_\
						#                                     
						
						elif [ ${t_tool:0:3} == "${tool_array[2]:0:3}" ] ; then {
							printf "This is gonna be a Mudbox task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Mudbox (latest MUD)";
							cp "${this_p_location}/scripts/template_documents/null_autodesk_mudbox_2013_x64.mud" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.mud";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  ____            _ _____ _               
						# |  _ \ ___  __ _| |  ___| | _____      __
						# | |_) / _ \/ _` | | |_  | |/ _ \ \ /\ / /
						# |  _ <  __/ (_| | |  _| | | (_) \ V  V / 
						# |_| \_\___|\__,_|_|_|   |_|\___/ \_/\_/  
						#                                          
						
						elif [ ${t_tool:0:3} == "${tool_array[3]:0:3}" ] ; then {
							printf "This is gonna be a RealFlow task\n";
							mkdir -p "${a_s_path}/usr/images";
							mkdir -p "${a_s_path}/usr/initialState";
							mkdir -p "${a_s_path}/usr/log";
							mkdir -p "${a_s_path}/usr/meshes";
							mkdir -p "${a_s_path}/usr/objects";
							mkdir -p "${a_s_path}/usr/particles";
							mkdir -p "${a_s_path}/usr/preview";
							mkdir -p "${a_s_path}/usr/preview/images";
							
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run RealFlow (latest FLW)";
							cp "${this_p_location}/scripts/template_documents/null_nextlimit_realflow_6000055_x32.flw" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.flw";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  ____  _           _            _                 
						# |  _ \| |__   ___ | |_ ___  ___| |__   ___  _ __  
						# | |_) | '_ \ / _ \| __/ _ \/ __| '_ \ / _ \| '_ \ 
						# |  __/| | | | (_) | || (_) \__ \ | | | (_) | |_) |
						# |_|   |_| |_|\___/ \__\___/|___/_| |_|\___/| .__/ 
						#                                            |_|    
						
						
						elif [ ${t_tool:0:3} == "${tool_array[4]:0:3}" ] ; then {
							printf "This is gonna be a Photoshop task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Photoshop (latest PSD)";
							cp "${this_p_location}/scripts/template_documents/null_adobe_photoshop_CC12_x64.psd" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.psd";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  _   _       _        
						# | \ | |_   _| | _____ 
						# |  \| | | | | |/ / _ \
						# | |\  | |_| |   <  __/
						# |_| \_|\__,_|_|\_\___|
						#                       
						
						elif [ ${t_tool:0:3} == "${tool_array[5]:0:3}" ] ; then {
							printf "This is gonna be a Nuke task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Nuke (latest NK)";
							cp "${this_p_location}/scripts/template_documents/null_thefoundry_nuke_708_x64.nk" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.nk";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  ___ _ _           _             _             
						# |_ _| | |_   _ ___| |_ _ __ __ _| |_ ___  _ __ 
						#  | || | | | | / __| __| '__/ _` | __/ _ \| '__|
						#  | || | | |_| \__ \ |_| | | (_| | || (_) | |   
						# |___|_|_|\__,_|___/\__|_|  \__,_|\__\___/|_|   
						#                                                
						#  "${tool_array[6]:0:3}"
						
						elif [ ${t_tool:0:3} == "${tool_array[6]:0:3}" ] ; then {
							printf "This is gonna be an Illustrator task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run InDesign (latest INDD)";
							cp "${this_p_location}/scripts/template_documents/null_adobe_illustrator_CC12_x64.ai" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.ai";
							break;
							} 
						
						#######################################
			
			
			
						#######################################
						#  ___           _           _             
						# |_ _|_ __   __| | ___  ___(_) __ _ _ __  
						#  | || '_ \ / _` |/ _ \/ __| |/ _` | '_ \ 
						#  | || | | | (_| |  __/\__ \ | (_| | | | |
						# |___|_| |_|\__,_|\___||___/_|\__, |_| |_|
						#                              |___/       
						
						elif [ ${t_tool:0:3} == "${tool_array[7]:0:3}" ] ; then {
							printf "This is gonna be an Indesign task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run InDesign (latest INDD)";
							cp "${this_p_location}/scripts/template_documents/null_adobe_indesign_CC12_x64.indd" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.indd";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#     _     __ _                 __  __           _       
						#    / \   / _| |_ ___ _ __ ___ / _|/ _| ___  ___| |_ ___ 
						#   / _ \ | |_| __/ _ \ '__/ _ \ |_| |_ / _ \/ __| __/ __|
						#  / ___ \|  _| ||  __/ | |  __/  _|  _|  __/ (__| |_\__ \
						# /_/   \_\_|  \__\___|_|  \___|_| |_|  \___|\___|\__|___/
						#                                                         
						
						elif [ ${t_tool:0:3} == "${tool_array[8]:0:3}" ] ; then {
							printf "This is gonna be ab Aftereffects task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run After Effects (latest AEP)";
							cp "${this_p_location}/scripts/template_documents/null_adobe_aftereffects_CC12_x64.aep" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.aep";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  _________                 _     
						# |__  / __ ) _ __ _   _ ___| |__  
						#   / /|  _ \| '__| | | / __| '_ \ 
						#  / /_| |_) | |  | |_| \__ \ | | |
						# /____|____/|_|   \__,_|___/_| |_|
						#                                  
						
						elif [ ${t_tool:0:3} == "${tool_array[9]:0:3}" ] ; then {
							printf "This is gonna be a ZBrush task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run ZBrush (latest ZPR)";
							cp "${this_p_location}/scripts/template_documents/null_pixologic_zbrush_4r6_x32.ZPR" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.ZPR";
							break;}
							
						#######################################
			
			
			
						#######################################
						#  ____                     _               
						# |  _ \ _ __ ___ _ __ ___ (_) ___ _ __ ___ 
						# | |_) | '__/ _ \ '_ ` _ \| |/ _ \ '__/ _ \
						# |  __/| | |  __/ | | | | | |  __/ | |  __/
						# |_|   |_|  \___|_| |_| |_|_|\___|_|  \___|
						#                                           
						
						elif [ ${t_tool:0:3} == "${tool_array[10]:0:3}" ] ; then {
							printf "This is gonna be a Premiere task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Premiere (latest PRPROJ)";
							cp "${this_p_location}/scripts/template_documents/null_adobe_premiere_CC12_x64.prproj" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.prproj";
							break;
							}
							
						#######################################
			
			
			
						#######################################
						#  ____  _____ _____               _    
						# |  _ \|  ___|_   _| __ __ _  ___| | __
						# | |_) | |_    | || '__/ _` |/ __| |/ /
						# |  __/|  _|   | || | | (_| | (__|   < 
						# |_|   |_|     |_||_|  \__,_|\___|_|\_\
						#                                       
						
						elif [ ${t_tool:0:3} == "${tool_array[11]:0:3}" ] ; then {
							printf "This is gonna be a PFTrack task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run PFTrack (latest PTP)";
							cp "${this_p_location}/scripts/template_documents/null_thepixelfarm_pftrack_41r3_x32.ptp" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.ptp";
							break;
							}
							
						#######################################
			
			
			
			
						#######################################
						#  ____  _                _           
						# | __ )| | ___ _ __   __| | ___ _ __ 
						# |  _ \| |/ _ \ '_ \ / _` |/ _ \ '__|
						# | |_) | |  __/ | | | (_| |  __/ |   
						# |____/|_|\___|_| |_|\__,_|\___|_|   
						#                                       
						
						elif [ ${t_tool:0:3} == "${tool_array[12]:0:3}" ] ; then {
							printf "This is gonna be a Blender task\n";
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Blender (latest BLEND)";
							cp "${this_p_location}/scripts/template_documents/null_blenderfoundation_blender_269_x64.blend" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.blend";
							break;
							}
							
						#######################################



						#######################################
						#  _   _                 _ _       _ 
						# | | | | ___  _   _  __| (_)_ __ (_)
						# | |_| |/ _ \| | | |/ _` | | '_ \| |
						# |  _  | (_) | |_| | (_| | | | | | |
						# |_| |_|\___/ \__,_|\__,_|_|_| |_|_|                                      
						
						elif [ ${t_tool:0:3} == "${tool_array[13]:0:3}" ] ; then {
							printf "This is gonna be a Houdini task\n";
							#printf "But is not fully implemented yet...\n";
							#sleep 5;
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Blender (latest BLEND)";
							cp "${this_p_location}/scripts/template_documents/null_sidefx_houdini_130260_x64.hip" "${a_s_path}/usr/${t_kind:0:3}_${t_tool:0:3}__${t_name}.hip";
							break;
							}
							
						#######################################		
						
						
						
						#######################################
						#     ____                 _ _ _            
						#	 |  _ \  ___  __ _  __| | (_)_ __   ___ 
						#	 | | | |/ _ \/ _` |/ _` | | | '_ \ / _ \
						#	 | |_| |  __/ (_| | (_| | | | | | |  __/
						#	 |____/ \___|\__,_|\__,_|_|_|_| |_|\___| 
                                                                                      
						
						elif [ ${t_tool:0:3} == "${tool_array[14]:0:3}" ] ; then {
							printf "This is gonna be a Deadline task\n";
							#printf "But is not fully implemented yet...\n";
							#sleep 5;
							#ln -s "${this_p_location}/scripts/run_task.command" "${a_s_path}/Run Blender (latest BLEND)";
							#cp "${this_p_location}/scripts/template_documents/null_sidefx_houdini_130260_x64.hip" "${a_s_path}/usr/${t_kind:0:3}__${t_name}.hip";
							#mkdir -p "${a_s_path}/usr/job_info";
							#mkdir -p "${a_s_path}/usr/plugin_info";
							#cp "${this_p_location}/scripts/template_documents/null_thinkbox_deadline_job_info.txt" "${a_s_path}/usr/job_info/${t_kind:0:3}_${t_tool:0:3}__${t_name}_job_info.txt";
							#cp "${this_p_location}/scripts/template_documents/null_thinkbox_deadline_plugin_info.txt" "${a_s_path}/usr/plugin_info/${t_kind:0:3}_${t_tool:0:3}__${t_name}_plugin_info.txt";
							break;
							}
							
						#######################################				
									
			
						fi;
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