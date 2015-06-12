#!/bin/bash -x


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#capture_screen.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

clear;


socket_location="${HOME}/vlc.sock";
makingof_location="${this_p_location}/making_of";


function capture_screen {
	
	if [ ${1} == "help" ]; then
	
		printf "Usage:\n";
		printf "capture_screen start\n";
		printf "\tStart capturing\n";
		printf "capture_screen stop\n";
		printf "\tStop capturing\n";
		return
	
	fi;
	
	
	
	
	if [ ${1} == "start" ]; then
		
		capture_start=`date +"%Y-%m-%d_%H-%M-%S"`;
		printf "ScreenCapture starting...\n";
		xterm -T "ScreenCapture - ${asset}__${task}" -e ${this_app_vlc} -I rc --rc-fake-tty --rc-unix="${socket_location}.${asset}__${task}" screen:// --screen-fps=4 --quiet --sout "#transcode{vcodec=h264,vb=512,scale=0.5}:standard{access=file,mux=mp4,dst="${makingof_location}/${capture_start}__${USER}__${asset}__${task}.mp4"}";
		
	fi;
	

	
	if [ ${1} == "stop" ]; then
	
		#printf "Socket: ${socket_location}.${asset}__${task}\n";
		#printf "Asset: ${asset}\n";
		#printf "Task: ${task}\n";
	
		if [ -S "${socket_location}.${asset}__${task}" ]; then
		
			echo -n stop | nc -U "${socket_location}.${asset}__${task}"; 
			echo -n quit | nc -U "${socket_location}.${asset}__${task}";
			printf "ScreenCapture stopped\n";
	
		else
		
			printf "No screen capturing active...\n";
		
		fi;
		
	fi;
	
	
	}