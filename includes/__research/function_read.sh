#!/bin/bash

function read_user_input() {

	read user_input;
	
	
	user_input=$(printf "${user_input}" | \
		sed -e 's/Ä/Ae/g' | \
		sed -e 's/ä/ae/g' | \
		sed -e 's/Ö/Oe/g' | \
		sed -e 's/ö/oe/g' | \
		sed -e 's/Ü/Ue/g' | \
		sed -e 's/ü/ue/g' | \
		sed -e 's/ß/ss/g' | \
		sed -e 's/[.,:;\"-\" ]//g' | \
		sed -e 's/__/_/g');


	while [[ "${user_input}" == "" ]]; do
	#while [[ "${user_input}" == "" ]]; do
		printf "No name given...\n";
		printf "(q to abort)\n";
		printf "${o_choice:0:3}_";
		read user_input;
		user_input=$(printf "${user_input}" | \
			sed -e 's/Ä/Ae/g' | \
			sed -e 's/ä/ae/g' | \
			sed -e 's/Ö/Oe/g' | \
			sed -e 's/ö/oe/g' | \
			sed -e 's/Ü/Ue/g' | \
			sed -e 's/ü/ue/g' | \
			sed -e 's/ß/ss/g' | \
			sed -e 's/[.,:;\"-\" ]//g' | \
			sed -e 's/__/_/g');

	done;
	
	while [[ "${user_input}" == "_" ]]; do
	
		printf "fuck you\n";
		
	done;
	
	#return ${user_input};
	printf ${user_input};
	
}


o_name=$(read_user_input);

printf "${o_name}\n";