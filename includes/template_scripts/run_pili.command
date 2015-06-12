#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#run_pili.command


current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};



project_name=$(basename -- "$(dirname -- "${current_directory}")");
project_path=$(dirname "${current_directory}");

sh ${current_directory}/spaghetti_refresher.command;
"/Applications/Graphviz.app/Contents/MacOS/Graphviz" ${project_path}/spaghetti/spaghetti.dot & PID=$!;

printf "\n";
printf "GraphViz PID=${PID}";

while :; do
	
	#sh ${current_directory}/generate_network.command;
	
	clear;

	
	printf "\e[92m       .__.__  .__ \e[0m                      https://code.google.com/p/pili-pipeline\n";
	printf "\e[92m______ |__|  | |__|\e[0m                                   pili (c)by Michael Mussato\n";
	printf "\e[92m\____ \|  |  | |  |\e[0m                                       michimussato@gmail.com\n";
	printf "\e[92m|  |_> >  |  |_|  |\e[0m\n";
	printf "\e[92m|   __/|__|____/__|\e[0m\n";
	printf "\e[92m|__|\e[0m_________________\n";
	#printf "\e[92m|__|_______________\e[0m\n";
	#printf "\e[92m/_____/_____/_____/\e[0m\n";
	#printf "\n";
	
	printf "\e[1mproject: \e[93m${project_name}\e[0m\n";
	printf "open in \e[1mf\e[0minder\n";
	printf "\n";
	
	#printf "=====================\n";
	#printf "How can I assist you?\n";
	#printf "=====================\n";
	#printf "_____________________\n";
	#printf "\n";
	
	
	
	printf "a) create \e[1ma\e[0msset\n";
	printf "t) create \e[1mt\e[0mask\n";
	printf "d) \e[1md\e[0muplicate existing task\n";
	#printf "e) run \e[1me\e[0mxisting task\n";
	printf "o) create new \e[1mo\e[0mutput\n";
	printf "v) create new output \e[1mv\e[0mersion\n";
	printf "p) create \e[1mp\e[0mublish\n";
	printf "i) create \e[1mi\e[0mnput\n";
	printf "l) create asset \e[1ml\e[0mink\n";
	printf "c) create \e[1mc\e[0morrespondence\n";
	printf "n) set a fi\e[1mn\e[0mal version\n";
	printf "r) \e[1mr\e[0mefresh spaghetti\n";
	printf "s) open \e[1ms\e[0mpaghetti\n";
	printf "q) \e[1mq\e[0muit\n";
	printf "\n";
	
	read pili_choice;

		case "${pili_choice}" in
		a)	printf "\n";
			sh ./create_new_asset.command;
			;;
		t)	printf "\n";
			#xterm -e maya 
			sh ./create_new_task.command;
			;;
		d)	printf "\n";
			sh ./duplicate_task.command;
			;;
#		e)	printf "\n";
#			sh ./run_task.command;
#			;;
		o)	printf "\n";
			sh ./create_new_output.command;
			;;
		v)	printf "\n";
			sh ./create_new_outputversion.command;
			;;
		p)	printf "\n";
			sh ./create_new_publish.command;
			;;
		i)	printf "\n";
			sh ./create_new_input.command;
			;;
		l)	printf "\n";
			sh ./create_new_asset_link.command;
			;;
		c)	printf "\n";
			sh ./create_new_correspondence.command;
			;;
		n)	printf "\n";
			sh ./set_final.command;
			;;
		f)	open ${project_path};
			;;
		q)	printf "Exitting...\n";
			sleep 1;
			if [[ $(ps -p ${PID} | grep Graphviz) ]]; then
				printf "Killing Graphviz...\n";
				sleep 3;
				kill -9 "${PID}";
				break;
			else
				printf "Couldn't kill Graphviz...\n";
				printf "You probably killed it already.\n";
				sleep 3;
				break;
			fi;
			exit;
			;;
		r)	printf "\n";
			sh ./spaghetti_refresher.command;
			;;
		s)	printf "\n";
			"/Applications/Graphviz.app/Contents/MacOS/Graphviz" ${project_path}/spaghetti/spaghetti.dot &
			;;
		*)	printf "Invalid selection\n";
			sleep 1;
			;;
	esac;
done;