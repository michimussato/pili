#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#timetracker.command.template


current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

timetracker_root=${this_p_location}/timetracker;
timetracker_data=${timetracker_root}/timetracker.csv;


function track_time {
	
	if [ ${1} == "help" ]; then
	
		printf "Usage:\n";
		printf "track_time start\n";
		printf "\tStart tracking\n";
		printf "track_time stop\n";
		printf "\tStop tracking\n";
		printf "track_time calc start_time end_time\n";
		printf "\tStart time & End time in seconds\n";
		return
	
	fi;
	
	
	
	
	if [ ${1} == "start" ]; then
	
		if [ ! -d "${timetracker_root}" ]; then
			
			mkdir -p "${timetracker_root}";
			
		fi;
	
		if [ ! -f "${timetracker_data}" ]; then
			
			touch "${timetracker_data}";
			
		fi;
			
		task_start=`date +"%Y.%m.%d\t%H:%M:%S"`;
		printf "${USER}\t${asset}__${task}\tSTART\t${task_start}\n" >> "${timetracker_data}";
		
	
	fi;
	
	if [ ${1} == "stop" ]; then
	
		task_stop=`date +"%Y.%m.%d\t%H:%M:%S"`;
		printf "${USER}\t${asset}__${task}\tSTOP\t${task_stop}\n" >> "${timetracker_data}";
	
	fi;
	
	if [ ${1} == "calc" ]; then
	
		task_seconds=$((${3} - ${2} | bc));
		printf "task_end       @ ${3} seconds\n";
		printf "task_start     @ ${2} seconds\n";
		printf "task_duration  = ${task_seconds} seconds\n";
		
		task_hours=$(echo "scale=2;${task_seconds}/3600" | bc );
		printf "or               ${task_hours} hours\n";
		printf "${USER}\t${asset}__${task}\tHOURS\t\t\t${task_hours}\n" >> "${timetracker_data}";
	
	fi;
	
	if [ ${1} == "*" ]; then
	
		printf "track_time help for help:\n";
		
	fi;
	
	}