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


time_stamp=`date +"%Y-%m-%d_%H%M-%S"`;

clear;

printf "\e[7mCreate new correspondence\e[0m\n";
printf "1) Abort\n";
printf "2) Outgoing\n";
printf "3) Incoming\n";
printf "#? ";
read c_kind;

case "${c_kind}" in

1)	exit;
	;;

2)	cd "${this_p_location}/assets/";
	printf "\n";
	printf "\e[7mSelect Asset to create Output for\e[0m\n";

	select asset in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g') "Folder only"; do
		if [[ "${asset}" == "Abort" ]]; then
			exit;
		elif [[ "${asset}" == "Folder only" ]]; then
			mkdir -p ${this_p_location}/transfer/outgoing/${time_stamp};
			open ${this_p_location}/transfer/outgoing/${time_stamp};
			break;
		else
			cd "${this_p_location}/assets/${asset}/";
			printf "\n";
			printf "\e[7mSelect Task to use for new outgoing\e[0m\n";
		
			select task in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
				if [[ "${task}" == "Abort" ]]; then
					exit;
				elif [[ "${task:(-7)}" == "_output" ]]; then
					printf "Cannot create outgoing connection from Asset output.\n";
					printf "cancelled...\n";
					sleep 3;
					exit;
				else
					cd "${this_p_location}/assets/${asset}/${task}"/lib/current/;
					printf "\n";
					printf "\e[7mChoose output\e[0m\n";
					select output in Abort $(ls -d */ | sed -e 's/lib\///g' | sed -e 's/\///g'); do
						if [[ "${output}" == "Abort" ]]; then
							exit;
						else
							current_target=$(readlink ../current);
							mkdir -p ${this_p_location}/transfer/outgoing/${time_stamp};
							cd ${this_p_location}/transfer/outgoing/${time_stamp};
							ln -sfn ../../../assets/${asset}/${task}/lib/${current_target:(-19):18}/${output}/ "${asset}__${task}__${output}__${current_target:(-19):18}";
							printf "Opening new folder at transfer/outgoing/${time_stamp}\n";
							open ${this_p_location}/transfer/outgoing/${time_stamp};
							break;
						fi;
					done;
					break;
				fi;
			done;
			break;
		fi;
	done;
	;;
	
3)	#printf "Input not working yet\n";
	#sleep 3;
	#exit;
	mkdir -p ${this_p_location}/transfer/incoming/${time_stamp}/client_data/;
	touch  ${this_p_location}/transfer/incoming/${time_stamp}/client_data/place_stuff_from_client_here;
	mkdir -p ${this_p_location}/transfer/incoming/${time_stamp}/to_pili/;
	mkdir -p ${this_p_location}/transfer/incoming/${time_stamp}/to_pili/copy_and_rename_me/${time_stamp}/;
	touch ${this_p_location}/transfer/incoming/${time_stamp}/to_pili/copy_and_rename_me/${time_stamp}/place_stuff_for_pili_here;
	#printf "\n";
	printf "Opening new folder at transfer/incoming/${time_stamp}/client_data\n";
	open ${this_p_location}/transfer/incoming/${time_stamp}/client_data;
	sleep 3;
	;;
	
*)	printf "Invalid selection\n";
	printf "exitting...\n";
	sleep 3;
	exit;
	;;
	
esac;

exit;