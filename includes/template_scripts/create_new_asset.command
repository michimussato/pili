#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_asset.command.template

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/conf/config.p_conf;

clear;

printf "\e[7mCreate new asset\e[0m\n";
#printf "\n";

printf "1) Abort\n";
printf "2) \e[1mAsset\e[0m\n";
printf "3) \e[1mShot\e[0m\n";

printf "#? ";

read a_s_choice;

case "${a_s_choice}" in
	1)	exit;
		;;
	2)	a_s_kind="asset";
		a_s_tag="AST";
		;;
	3)	a_s_kind="shot";
		a_s_tag="SHT";
		;;
	*)	printf "Invalid selection\n";
		printf "exitting...\n";
		sleep 3;
		exit;
		;;
esac


printf "\n";
printf "\e[7mEnter ${a_s_kind} name\e[0m\n";
printf "(q to abort)\n";
printf "\e[92mAllowed:       A-Z, a-z, 0-9, _\e[0m\n";
#printf "\e[91mNot allowed:   space . , - __ ? # $ \" * etc\e[0m\n";
printf "${a_s_tag}_";
read a_s_name;

while [[ "${a_s_name}" == "" ]]; do
	printf "No name given...\n";
	printf "(q to abort)\n";
	printf "${a_s_tag}_";
	read a_s_name;
done;

if [ ${a_s_name} == "q" ]; then
	exit;
fi;

a_s_root=${this_p_location}/assets;
a_s_path=${a_s_root}/${a_s_tag}_${a_s_name};

#printf "${a_s_path}\n";

if [ -d "${a_s_path}" ]; then

	printf "${a_s_tag}_${a_s_name} already exists.\n";
	printf "Operation cancelled.\n";
	sleep 3;
	exit;
	
else

	mkdir -p ${a_s_path};
	
fi;

#ln -sf ${this_p_location}/scripts/create_new_task.command "${a_path}/Create New Task";
#ln -sf ${this_p_location}/scripts/duplicate_task.command "${a_path}/Duplicate Task";

sh ${current_directory}/spaghetti_refresher.command;

exit;