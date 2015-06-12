#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#spaghetti_refresher.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;



clear;

printf "\e[31mHit key to skip Spaghetti refresher\e[0m\n";
printf "\e[31mq for quick refresher\e[0m\n";

yes_no="lets_skip_this_shit";

read -n 1 -s -t 2 yes_no;

#strangely, this if function works inversely :-///
if  [[ ${yes_no} == "q" ]]; then

	sh ${current_directory}/generate_network.command quick;
	break;

elif [[ ${yes_no} != "lets_skip_this_shit" ]]; then

	printf "Skipping...\n";
	sleep 1;
	break;
	
else

	sh ${current_directory}/generate_network.command full;
	break;

fi;

exit;