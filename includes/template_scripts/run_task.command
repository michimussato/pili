#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#run_task.command.template

#Font: http://patorjk.com/software/taag/#p=display&f=Standard&t=Nuke

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;
source ${current_directory}/timetracker.command;
source ${current_directory}/screencapture.command;
source ${current_directory}/save_increment.command;





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








function run_task {

#if [ -f "${this_p_location}/assets/${asset}/${task}/locked" ]; then
#	printf "${task} is \e[1m\e[31mlocked\e[0m by ";
#	cat "${this_p_location}/assets/${asset}/${task}/locked";
#	read -n 1 -s;
#else
	

#read -n 1 -s -t 1 run_me;


while [ -f "${this_p_location}/assets/${asset}/${task}/locked" ]; do
	
	exit_me="exit_here";
						
	clear;
	printf "${task} is \e[1m\e[31mlocked\e[0m by ";
	cat "${this_p_location}/assets/${asset}/${task}/locked";
	#printf "\n";
	read -n 1 -s -t 1 exit_me;
	if [[ "${exit_me}" != "exit_here" ]]; then
		exit;
	fi;
	clear;
	printf "${task} is \e[1m\e[31mlocked\e[0m by ";
	cat "${this_p_location}/assets/${asset}/${task}/locked";
	printf ".";
	read -n 1 -s -t 1 exit_me;
	if [[ "${exit_me}" != "exit_here" ]]; then
		exit;
	fi;
	clear;
	printf "${task} is \e[1m\e[31mlocked\e[0m by ";
	cat "${this_p_location}/assets/${asset}/${task}/locked";
	printf "..";
	read -n 1 -s -t 1 exit_me;
	if [[ "${exit_me}" != "exit_here" ]]; then
		exit;
	fi;
	clear;
	printf "${task} is \e[1m\e[31mlocked\e[0m by ";
	cat "${this_p_location}/assets/${asset}/${task}/locked";
	printf "...";
	read -n 1 -s -t 1 exit_me;
	if [[ "${exit_me}" != "exit_here" ]]; then
		exit;
	fi;
						
done;

clear;


	#######################################
	#  __  __                   
	# |  \/  | __ _ _   _  __ _ 
	# | |\/| |/ _` | | | |/ _` |
	# | |  | | (_| | |_| | (_| |
	# |_|  |_|\__,_|\__, |\__,_|
	#               |___/       

	if [[ "${task:4:3}" == "${tool_array[0]:0:3}" ]]; then
		printf "This is a Maya task\n";
		printf "Think I'm gonne start ${tool_array[0]:5} for you...\n";
	
		. /Applications/Autodesk/maya2014/Maya.app/Contents/bin/MayaENV.sh;
	
		cd "${this_p_location}/assets/${asset}/${task}/usr/scenes";
		latest_ma=$(ls -t *.ma | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_maya2013x64}" -proj "${projectpath}" -file "${this_p_location}/assets/${asset}/${task}/usr/scenes/${latest_ma}" &

		save_increment "${latest_ma}" "${projectpath}/scenes/";
	

	
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_maya2014x64}" -proj "${projectpath}" -file "${this_p_location}/assets/${asset}/${task}/usr/scenes/${latest_ma}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
	
		rm "${this_p_location}/assets/${asset}/${task}/locked";
	
		sleep 3;
	
		#break;

	#######################################



	#######################################
	#   ____ _                              _  _   ____  
	#  / ___(_)_ __   ___ _ __ ___   __ _  | || | |  _ \ 
	# | |   | | '_ \ / _ \ '_ ` _ \ / _` | | || |_| | | |
	# | |___| | | | |  __/ | | | | | (_| | |__   _| |_| |
	#  \____|_|_| |_|\___|_| |_| |_|\__,_|    |_| |____/ 
	#                                                    

	elif [[ "${task:4:3}" == "${tool_array[1]:0:3}" ]]; then
		printf "This is a Cinema4D task\n";
		printf "Think I'm gonna start ${tool_array[1]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_c4d=$(ls -t *.c4d | head -1);
		custom_homedir="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_cinema4dr15x64}" -homedir "${custom_homedir}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_c4d}" &
		
		save_increment "${latest_c4d}" "${custom_homedir}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_cinema4dr15x64}" -homedir "${custom_homedir}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_c4d}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#  __  __           _ _               
	# |  \/  |_   _  __| | |__   _____  __
	# | |\/| | | | |/ _` | '_ \ / _ \ \/ /
	# | |  | | |_| | (_| | |_) | (_) >  < 
	# |_|  |_|\__,_|\__,_|_.__/ \___/_/\_\
	#                                     

	elif [[ "${task:4:3}" == "${tool_array[2]:0:3}" ]]; then
		printf "This is a Mudbox task\n";
		printf "Think I'm gonne start ${tool_array[2]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_mud=$(ls -t *.mud | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		additional_folder=$(ls -d */ | grep -vi increments | sed -e 's/\///g');
		#xterm -T "${asset} ${task}" -e "${this_app_mudbox2013x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_mud}" &
		
		save_increment "${latest_mud}" "${projectpath}" "${additional_folder}";
		
	
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_mudbox2015x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_mud}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
	
	
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#  ____            _ _____ _               
	# |  _ \ ___  __ _| |  ___| | _____      __
	# | |_) / _ \/ _` | | |_  | |/ _ \ \ /\ / /
	# |  _ <  __/ (_| | |  _| | | (_) \ V  V / 
	# |_| \_\___|\__,_|_|_|   |_|\___/ \_/\_/  
	#                                          

	elif [[ "${task:4:3}" == "${tool_array[3]:0:3}" ]]; then
		printf "This is a RealFlow task\n";
		printf "Think I'm gonne start ${tool_array[3]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_flw=$(ls -t *.flw | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_realflow6000055x32}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_flw}" &
		
		save_increment "${latest_flw}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_realflow7010131x32}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_flw}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
	
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#  ____  _           _            _                 
	# |  _ \| |__   ___ | |_ ___  ___| |__   ___  _ __  
	# | |_) | '_ \ / _ \| __/ _ \/ __| '_ \ / _ \| '_ \ 
	# |  __/| | | | (_) | || (_) \__ \ | | | (_) | |_) |
	# |_|   |_| |_|\___/ \__\___/|___/_| |_|\___/| .__/ 
	#                                            |_|    

	elif [[ "${task:4:3}" == "${tool_array[4]:0:3}" ]]; then
		printf "This is a Photoshop task\n";
		printf "Think I'm gonne start ${tool_array[4]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_psd=$(ls -t *.psd | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_photoshopcs6x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_psd}" &
		
		save_increment "${latest_psd}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_photoshopcc12x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_psd}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#  _   _       _        
	# | \ | |_   _| | _____ 
	# |  \| | | | | |/ / _ \
	# | |\  | |_| |   <  __/
	# |_| \_|\__,_|_|\_\___|
	#                       

	elif [[ "${task:4:3}" == "${tool_array[5]:0:3}" ]]; then
		printf "This is a Nuke task\n";
		printf "Think I'm gonne start ${tool_array[5]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_nk=$(ls -t *.nk | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_nuke631x64}" -V "${this_p_location}/assets/${asset}/${task}/usr/${latest_nk}" &
		
		save_increment "${latest_nk}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_nuke708x64}" -V "${this_p_location}/assets/${asset}/${task}/usr/${latest_nk}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#  ___ _ _           _             _             
	# |_ _| | |_   _ ___| |_ _ __ __ _| |_ ___  _ __ 
	#  | || | | | | / __| __| '__/ _` | __/ _ \| '__|
	#  | || | | |_| \__ \ |_| | | (_| | || (_) | |   
	# |___|_|_|\__,_|___/\__|_|  \__,_|\__\___/|_|   
	#                                                
				
	elif [[ "${task:4:3}" == "${tool_array[6]:0:3}" ]]; then
		printf "This is an Illustrator task\n";
		printf "Think I'm gonne start ${tool_array[6]:5} for you...\n";
		
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_ai=$(ls -t *.ai | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_indesigncs6x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_indd}" $
		
		save_increment "${latest_ai}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_illustratorcc12x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_ai}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
					
	#######################################



	#######################################
	#  ___           _           _             
	# |_ _|_ __   __| | ___  ___(_) __ _ _ __  
	#  | || '_ \ / _` |/ _ \/ __| |/ _` | '_ \ 
	#  | || | | | (_| |  __/\__ \ | (_| | | | |
	# |___|_| |_|\__,_|\___||___/_|\__, |_| |_|
	#                              |___/       

	elif [[ "${task:4:3}" == "${tool_array[7]:0:3}" ]]; then
		printf "This is an Indesign task\n";
		printf "Think I'm gonne start ${tool_array[7]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_indd=$(ls -t *.indd | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_indesigncs6x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_indd}" $
		
		save_increment "${latest_indd}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_indesigncc12x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_indd}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#     _     __ _                 __  __           _       
	#    / \   / _| |_ ___ _ __ ___ / _|/ _| ___  ___| |_ ___ 
	#   / _ \ | |_| __/ _ \ '__/ _ \ |_| |_ / _ \/ __| __/ __|
	#  / ___ \|  _| ||  __/ | |  __/  _|  _|  __/ (__| |_\__ \
	# /_/   \_\_|  \__\___|_|  \___|_| |_|  \___|\___|\__|___/
	#                                                         

	elif [[ "${task:4:3}" == "${tool_array[8]:0:3}" ]]; then
		printf "This is an Aftereffects task\n";
		printf "Think I'm gonne start ${tool_array[8]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_aep=$(ls -t *.aep | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_aftereffectscs6x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_aep}" $
		
		save_increment "${latest_aep}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_aftereffectscc12x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_aep}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################



	#######################################
	#  _________                 _     
	# |__  / __ ) _ __ _   _ ___| |__  
	#   / /|  _ \| '__| | | / __| '_ \ 
	#  / /_| |_) | |  | |_| \__ \ | | |
	# /____|____/|_|   \__,_|___/_| |_|
	#                                  
	
	elif [[ "${task:4:3}" == "${tool_array[9]:0:3}" ]]; then
		printf "This is a ZBrush task\n";
		printf "Think I'm gonne start ${tool_array[9]:5} for you...\n";
		
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_zpr=$(ls -t *.ZPR | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
	#	if [[ -z "$latest_zpr" ]]; then
	#		latest_zpr=$(ls -t *.ZPR | head -1);
	#	else
	#		break;
	#	fi;
		
		#xterm -T "${asset} ${task}" -e open -W -n -a "${this_app_zbrush4r5x32}" --args "${this_p_location}/assets/${asset}/${task}/usr/${latest_zpr}" $
		
		save_increment "${latest_zpr}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
	
		start_time=`date +%s` && open -W -n -a "${this_app_zbrush4r6x32}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_zpr}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
	
		track_time stop;
		rm "${this_p_location}/assets/${asset}/${task}/locked";
					
	
		sleep 3;
	
		#break;
		
	#######################################



	#######################################
	#  ____                     _               
	# |  _ \ _ __ ___ _ __ ___ (_) ___ _ __ ___ 
	# | |_) | '__/ _ \ '_ ` _ \| |/ _ \ '__/ _ \
	# |  __/| | |  __/ | | | | | |  __/ | |  __/
	# |_|   |_|  \___|_| |_| |_|_|\___|_|  \___|
	#                                           

	elif [[ "${task:4:3}" == "${tool_array[10]:0:3}" ]]; then
		printf "This is a Premiere task\n";
		printf "Think I'm gonne start ${tool_array[10]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_prproj=$(ls -t *.prproj | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_premierecs6x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_prproj}" &
		
		save_increment "${latest_prproj}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_premierecc12x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_prproj}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################



	########################################
	##  ____  _____ _____               _    
	## |  _ \|  ___|_   _| __ __ _  ___| | __
	## | |_) | |_    | || '__/ _` |/ __| |/ /
	## |  __/|  _|   | || | | (_| | (__|   < 
	## |_|   |_|     |_||_|  \__,_|\___|_|\_\
	##                                       
	#
	#elif [[ "${task:4:3}" == "${tool_array[11]:0:3}" ]]; then
	#	printf "This is a PFtrack task\n";
	#	printf "Think I'm gonne start ${tool_array[11]:5} for you...\n";
	#	
	#	cd "${this_p_location}/assets/${asset}/${task}/usr";
	#	ptp=$(ls -t *.ptp | head -1);
	#	#projectpath="${this_p_location}/assets/${asset}/${task}/usr";
	#	#xterm -T "${asset} ${task}" -e open -W -n -a "${this_app_pftrack41r3x32}" --args "${this_p_location}/assets/${asset}/${task}/usr/${ptp}" $
	#	
	#	
	#	touch "${this_p_location}/assets/${asset}/${task}/locked";
	#	printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
	#	
	#	track_time start;
	
	#	capture_screen start &
	#
	#	start_time=`date +%s` && open -W -n -a "${this_app_pftrack41r3x32}" --args "${this_p_location}/assets/${asset}/${task}/usr/${ptp}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
	#	
	#	capture_screen stop;
	#
	#	track_time stop;
	
	#	rm "${this_p_location}/assets/${asset}/${task}/locked";
	#						
	#
	#	sleep 3;
	#	#break;
	#
	########################################




	#######################################
	#  ____  _                _           
	# | __ )| | ___ _ __   __| | ___ _ __ 
	# |  _ \| |/ _ \ '_ \ / _` |/ _ \ '__|
	# | |_) | |  __/ | | | (_| |  __/ |   
	# |____/|_|\___|_| |_|\__,_|\___|_|   
	#    

	elif [[ "${task:4:3}" == "${tool_array[12]:0:3}" ]]; then
		printf "This is a Blender task\n";
		printf "Think I'm gonna start ${tool_array[12]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_blend=$(ls -t *.blend | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_blender269x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_blend}" &
		
		save_increment "${latest_blend}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_blender269x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_blend}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################


	#######################################
	#  _   _                 _ _       _ 
	# | | | | ___  _   _  __| (_)_ __ (_)
	# | |_| |/ _ \| | | |/ _` | | '_ \| |
	# |  _  | (_) | |_| | (_| | | | | | |
	# |_| |_|\___/ \__,_|\__,_|_|_| |_|_|
                                    

	elif [[ "${task:4:3}" == "${tool_array[13]:0:3}" ]]; then
		printf "This is a Houdini task\n";
		printf "Think I'm gonna start ${tool_array[13]:5} for you...\n";
	
		cd "${this_p_location}/assets/${asset}/${task}/usr";
		latest_hip=$(ls -t *.hip | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		#xterm -T "${asset} ${task}" -e "${this_app_blender269x64}" "${this_p_location}/assets/${asset}/${task}/usr/${blend}" &
		
		save_increment "${latest_hip}" "${projectpath}";
		
		
		touch "${this_p_location}/assets/${asset}/${task}/locked";
		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
		
		track_time start;
		
		capture_screen start &
		
		start_time=`date +%s` && "${this_app_houdini130314x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_hip}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
		
		capture_screen stop;
		
		track_time stop;
		
		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################
	
	
	#######################################
	#     ____                 _ _ _            
	#	 |  _ \  ___  __ _  __| | (_)_ __   ___ 
	#	 | | | |/ _ \/ _` |/ _` | | | '_ \ / _ \
	#	 | |_| |  __/ (_| | (_| | | | | | |  __/
	#	 |____/ \___|\__,_|\__,_|_|_|_| |_|\___| 
                                    

	elif [[ "${task:4:3}" == "${tool_array[14]:0:3}" ]]; then
		printf "This is a Deadline task\n";
		printf "Think I'm gonna start ${tool_array[14]:5} for you...\n";
	
		#cd "${this_p_location}/assets/${asset}/${task}/usr/job_info";
		#latest_job_info=$(ls -t *.txt | head -1);
		#cd "${this_p_location}/assets/${asset}/${task}/usr/plugin_info";
		#latest_plugin_info=$(ls -t *.txt | head -1);
		projectpath="${this_p_location}/assets/${asset}/${task}/usr";
		projectname="$(basename ${this_p_location})";
		
		#cd "${this_p_location}/assets/${asset}/${task}/output/";
		#output_directory=$(ls -d */| sed -e 's/\///g');
		
		#xterm -T "${asset} ${task}" -e "${this_app_blender269x64}" "${this_p_location}/assets/${asset}/${task}/usr/${blend}" &
		
		#save_increment "${latest_job_info}" "${projectpath}";
		#save_increment "${latest_plugin_info}" "${projectpath}";
		
		printf "\n";
		printf "\e[7mConfigure or Execute?\e[0m\n";
		
		select whattodo in Abort Configure Execute; do
			if [[ "${whattodo}" == "Abort" ]]; then
				exit;
			
			elif [[ "${whattodo}" == "Configure" ]]; then
			
			
			
			
			
			
			
				if [[ -f "${this_p_location}/assets/${asset}/${task}/usr/${task}.txt" ]]; then
					
					printf "Configuration file already exists. Remove or edit manually\n";
					sleep 4;
					#exit;
					break;
				
				else
				
				
				
				
				
				
				
				
				
				
					
					
					#output_version=$(ls -t "${this_p_location}/assets/${asset}/${task}/output/${output_directory}/" | grep -v current | sort -nr | head -1);
					
					printf "\n";
					printf "\e[7mSelect Plugin\e[0m\n";
					
					select plugin in Abort Nuke7.0v8 Arnold; do
					
						if [[ "${plugin}" == "Abort" ]]; then
							exit;
						fi;
						
						
					
						printf "\n";
						printf "\e[7mFrames to render\e[0m\n";
						printf "stepping info:\n";
						printf "\e[92mi.e.: 1-100x10,1-100x5,1-100x2,1-100\e[0m\n";
						printf "\e[92mrender ever 10th, every 5th, every 2nd frame, then the rest\e[0m\n";
						read frames;
						
						printf "\n";
						printf "\e[7mPriority (1-100)\e[0m\n";
						read priority;
						
						#chunksize funktioniert nicht, es wird jeweils nur das erste frame des chunks gerendert :(
						#printf "\n";
						#printf "\e[7mChunk size (frames per task, 1 for default)\e[0m\n";
						#read chunksize;
						
						printf "\n";
						printf "\e[7mOutput file extension\e[0m\n";
						printf "Valid: tga exr jpg\n";
						printf "<FILE>.####.";
						read extension;
						
						printf "\n";
						printf "\e[7mSelect Output directory\e[0m\n";
						
						cd "${this_p_location}/assets/${asset}/${task}/output";
						
						if [[ ! -d $(ls -t ${this_p_location}/assets/${asset}/${task}/output/${output_directory}/ | grep -v current | sort -nr | head -1) ]]; then
							printf "No output found for ${task}\n";
							printf "Exitting\n";
							sleep 3;
							exit;
						fi;
						
						select output_directory in Abort $(ls -d */ | grep -i _${extension} | sed -e 's/\///g'); do
						
							#output=$(ls -d */ | grep -i _${extension} | sed -e 's/\///g');
								
							output_version=$(ls -t ${this_p_location}/assets/${asset}/${task}/output/${output_directory}/ | grep -v current | sort -nr | head -1);
						
							cd "${this_p_location}/assets/${asset}/${task}/input";
						
							printf "\n";
							printf "\e[7mDeadline status\e[0m\n";
						
							select initialstatus in Abort "Active" "Suspended"; do
						
								if [[ "${plugin}" == "Nuke7.0v8" ]]; then
								
									executable="/Applications/Nuke7.0v8/Nuke7.0v8.app/Contents/MacOS/Nuke7.0v8";
								
									printf "\n";
									printf "\e[7mSelect input directory\e[0m\n";
								
									select input_directory in Abort $(ls | grep __NUK_ | sed -e 's/\///g'); do
									
										cd "${this_p_location}/assets/${asset}/${task}/input/${input_directory}/";
									
										input_file=$(ls -t *.nk | head -1);
										#input_file=$(ls | sed -e 's/\///g' | head -n 1);

					
										arguments="-V 2 -X ${output_directory} --cont -F <STARTFRAME>-<ENDFRAME> -x <QUOTE>${this_p_location}/assets/${asset}/${task}/input/${input_directory}/${input_file}<QUOTE>";
								
								
										touch "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
								
								
										echo -e "deadlinecommand \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-SubmitCommandLineJob \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-executable \"${executable}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-startupdirectory \"${this_p_location}/assets/${asset}/${task}/usr/\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-chunksize \"1\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-arguments \"${arguments}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-frames \"${frames}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-initialstatus \"${initialstatus}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"Comment=${plugin}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"Priority=${priority}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"Interruptible=true\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										#echo -e "-prop \"OutputDirectory0=${this_p_location}/assets/${asset}/${task}/output/${output_directory}/current\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"OutputDirectory0=${this_p_location}/assets/${asset}/${task}/output/${output_directory}/undefined_output_version\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"OutputFilename0=${output_directory}.####.${extension}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";	
										echo -e "-prop \"Name=${projectname}  |  ${asset}  |  ${task}  |  ${output_directory}  |  undefined_output_version\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
									
										break;
							

									done;					
									exit;
						
								elif [[ "${plugin}" == "Arnold" ]]; then
							
									executable="/Applications/MtoA/bin/kick";
								
									printf "\n";
									printf "\e[7mSelect input directory\e[0m\n";
								
									select input_directory in "Abort" $(ls | grep __ASS_ | sed -e 's/\///g'); do
								
										if [[ "${input_directory}" == "Abort" ]]; then
											exit;
										fi;
									
										cd "${this_p_location}/assets/${asset}/${task}/input/${input_directory}";
								
										input_file=$(ls *.ass | head -n 1);
									
										input_file_basename=$(ls *.ass | sed 's/\.[0-9]*.ass/./g' | head -n 1);
									
										frame_array=$(ls *.ass);
									
										printf "\n";
										printf "\e[7mAA Sampling\e[0m\n";
										read aa_sampling;
								
										arguments="-nstdin -dw -v 2 -as ${aa_sampling} -i <QUOTE>${this_p_location}/assets/${asset}/${task}/input/${input_directory}/${input_file_basename}<STARTFRAME%4>.ass<QUOTE> -o <QUOTE>${this_p_location}/assets/${asset}/${task}/output/${output_directory}/undefined_output_version/${output_directory}.<STARTFRAME%4>.${extension}<QUOTE>";
									
									
									
										touch "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
								
								
										echo -e "deadlinecommand \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-SubmitCommandLineJob \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-executable \"${executable}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-startupdirectory \"${this_p_location}/assets/${asset}/${task}/usr/\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-chunksize \"1\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-arguments \"${arguments}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-frames \"${frames}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-initialstatus \"${initialstatus}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"Comment=${plugin}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"Priority=${priority}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"Interruptible=true\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"OutputDirectory0=${this_p_location}/assets/${asset}/${task}/output/${output_directory}/undefined_output_version\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
										echo -e "-prop \"OutputFilename0=${output_directory}.####.${extension}\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";	
										echo -e "-prop \"Name=${projectname}  |  ${asset}  |  ${task}  |  ${output_directory}  |  undefined_output_version\" \\" >> "${this_p_location}/assets/${asset}/${task}/usr/${input_directory}<->${asset}__${task}__${output_directory}.txt";
									
										break;
								
									done;
									break;
							
								fi;
						
							done;
							break;
						done;
						break;
					done;
					break;
				
				fi;
				
				
			elif [[ "${whattodo}" == "Execute" ]]; then
			
				cd "${this_p_location}/assets/${asset}/${task}/usr/";
				
				
				ddljobs=($(ls *.txt | sed -e 's/\///g'));

				menu() {
#					echo "Avaliable options:"
					for i in ${!ddljobs[@]}; do 
						printf "%1d%s) %s\n" $((i+1)) "${choices[i]:-}" "${ddljobs[i]}";
					done;
					[[ "$msg" ]] && echo "$msg"; :
				}

				prompt="Check/uncheck an option, ENTER when done: ";
				
				while menu && read -rp "$prompt" num && [[ "$num" ]]; do
					printf "\n";
					printf "\e[7mSelect Deadline Jobs(s) to submit\e[0m\n";
					[[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#ddljobs[@]} )) || {
						msg="Invalid option: $num"; continue;
					}
					((num--)); #msg="${ddljobs[num]} was ${choices[num]:+un}checked"
					[[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
				done;
				
				printf "\nWill publish"; msg=" nothing"
				for b in ${!ddljobs[@]}; do 
					#printf "${choices[b]}";
					[[ "${choices[b]}" ]] && { printf " %s" "${ddljobs[b]}"; msg=""; }
				done
				printf "\n";
				echo "$msg"
				
				
				
				for i in ${!ddljobs[@]}; do 
					
					#printf "\n";
					#printf "\n";
					#printf "\n";
					#printf ${ddljobs[i]}; #txt dateiname


					
					if [[ "${choices[i]}" ]] ; then
					
						# ${ddljobs[i]} ist txt-dateiname
						
						
						array_output_directory=(${ddljobs[i]//<->/ });
						
						
						array_output_path=(${array_output_directory[1]//__/ });
						
						
						output_directory=$(printf ${array_output_path[3]//.txt/});
						
						#printf ${output_directory};
						#printf "\n";
						#printf "\n";
						#printf "\n";

						sh ${this_p_location}/scripts/create_new_outputversion.command ${asset} ${task} ${output_directory};
						output_version=$(ls -t ${this_p_location}/assets/${asset}/${task}/output/${output_directory}/ | grep -v current | sort -nr | head -1);
						
						sed -i .previous \
							-e "s/|  undefined_output_version\" /|  ${output_version}\" /g" \
							-e "s/[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][_][0-9][0-9][0-9][0-9][-][0-9][0-9]/${output_version}/g" \
							"${this_p_location}/assets/${asset}/${task}/usr/${ddljobs[i]}";
							
							
						bash "${this_p_location}/assets/${asset}/${task}/usr/${ddljobs[i]}";
						printf "Job submitted to Deadline.\n";
						sleep 3;
						
					fi;
				
				done;				

				


				
				break;
				
			fi;
				
		done;
#####################################		break;
		
		
# 		touch "${this_p_location}/assets/${asset}/${task}/locked";
# 		printf "${USER}@${HOSTNAME}\n" > "${this_p_location}/assets/${asset}/${task}/locked";
# 		
# 		track_time start;
# 		
# 		capture_screen start &
# 		
# 		start_time=`date +%s` && "${this_app_houdini130314x64}" "${this_p_location}/assets/${asset}/${task}/usr/${latest_hip}" && end_time=`date +%s` && track_time calc ${start_time} ${end_time} && sleep 5;
# 		
# 		capture_screen stop;
# 		
# 		track_time stop;
# 		
# 		rm "${this_p_location}/assets/${asset}/${task}/locked";
		
		
		sleep 3;
	
		#break;
	
	#######################################


	#######################################
	#              _                              
	#  _   _ _ __ | | ___ __   _____      ___ __  
	# | | | | '_ \| |/ / '_ \ / _ \ \ /\ / / '_ \ 
	# | |_| | | | |   <| | | | (_) \ V  V /| | | |
	#  \__,_|_| |_|_|\_\_| |_|\___/ \_/\_/ |_| |_|
	#                                             

	else
		printf "This task is unknown\n";
	
		printf "${asset}\n";
		printf "${task:4:3}\n";
	
		sleep 3;
	
		#break;
	
	#######################################
	fi;



}






cd "${this_p_location}/assets/";



clear;


if [[ ${1} != "" ]]; then
	#printf "${1}\n";
	
	#cd ${1};
	
	
	pathelement_array=(${1//\// });
	

	
	pathelement_array_length=${#pathelement_array[@]};
	
	#pwd;
	#printf "Path elements: ${pathelement_array_length}\n";
	
	

	
	taskID=$((${pathelement_array_length} -1 | bc));
	assetID=$((${pathelement_array_length} -2 | bc));
	
	#printf "${taskID}\n";
	#printf "${assetID}\n";
	
	#run_task ${1};

	printf "AssetID: ${pathelement_array[${assetID}]}\n";
	printf "TaskID:  ${pathelement_array[${taskID}]}\n";
	printf "\n";
	
	asset=${pathelement_array[${assetID}]};
	task=${pathelement_array[${taskID}]};
	
	#printf "Asset: ${asset}\n";
	#printf "Task: ${task:4:3}\n";
	
	run_task ${asset} ${task:4:3};
	
	
else


	printf "Run Task with...\n";
	printf "\n";
	printf "Select Asset\n";



	select asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
		if [[ "${asset}" == "Abort" ]]; then
			exit
		else
			printf "\n";
			printf "Select Task\n";
			cd "${this_p_location}/assets/${asset}/";
			select task in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
				if [[ "${task}" == "Abort" ]]; then
					exit;
				else
					
					printf "${asset}\n";
					printf "${task:4:3}\n";

					run_task ${asset} ${task:4:3};
					
					break;
				fi;
			done;
			break;
		fi;
	done;
	break;
fi;

exit;