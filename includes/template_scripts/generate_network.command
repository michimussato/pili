#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};




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



function set_TSK_edge_color {

	#cd ${assets_directory}/${asset}/${task}/input/;

	if [[ "${array_truncate_input[1]}__" == "LNK__" ]]; then
		
		cd $(readlink ${input})../../../;
		
		#pwd;
	
		#printf "./lib/current/${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]}\n";
		
		if [[ ! -d ./lib/current/${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]}/ ]]; then
	
			edge_color=$2;
			edge_style="dashed";
			
		else
			
			edge_color=$2;
			edge_style="bold";
			
			
		fi;

	elif [[ "${array_truncate_input[1]}__" != "LNK__" ]]; then

		cd $(readlink ${input})../../../;
		
		#pwd;
	
		#goddam .mayaSwatches...
		
		if [[ ${1} == "quick" ]]; then
		
			cksum_output="ignored";
			cksum_lib="ignored";
		
		elif [[ ${1} == "full" ]]; then
			
			cksum_output=$(find ./output/${array_truncate_input[3]}/current/ -type f \( -name "*.*" ! -name ".*" ! -name "*.swatch" \) -exec cksum {} + | awk '{print $1}' | sort | cksum);
			cksum_lib=$(find ./lib/current/${array_truncate_input[3]}/ -type f \( -name "*.*" ! -name ".*" ! -name "*.swatch" \) -exec cksum {} + | awk '{print $1}' | sort | cksum);
		
		fi;
	
		#cksum_output=$(find ./output/${array_truncate_input[3]}/current/ -type f -name "*.*" -exec cksum {} + | awk '{print $1}');
		#cksum_lib=$(find ./lib/current/${array_truncate_input[3]}/ -type f -name "*.*" -exec cksum {} + | awk '{print $1}');
	
		#pwd;
		#printf "${input}\n";
		#printf "$(readlink ${input})";
		#printf "${array_truncate_input[3]}\n";
		printf "Checksum output: ${cksum_output}\n";
		printf "Checksum lib:    ${cksum_lib}\n";
	
		if [[ ! -d ./lib/current/${array_truncate_input[3]}/ ]]; then
		
			edge_color=$2;
			edge_style="dashed";
		
		elif [[ ${cksum_output} == ${cksum_lib} ]]; then
	
	
			edge_color=$2;
			edge_style="bold";
		
		else
	
			edge_color="\"#ee0000\"";
			edge_style="bold";
			printf "\e[91mWe've got unpublished outputs here!\e[0m\n";
	
		fi;
		
	fi;
	cd ${assets_directory}/${asset}/${task}/input/;

}










project_name=$(basename -- "$(dirname -- "${current_directory}")");
project_directory=$(dirname "${current_directory}");






spaghetti_root="${project_directory}/spaghetti";


spaghetti_data="${spaghetti_root}/spaghetti.dot";
spaghetti_data_temp="${spaghetti_root}/spaghetti.dot.${USER}.tmp";

launchers_root="${spaghetti_root}/launchers";
launchers_root_temp="${spaghetti_root}/launchers.${USER}.tmp"

mkdir -p ${spaghetti_root};
touch ${spaghetti_data_temp};
mkdir -p ${launchers_root_temp};





cd ${project_directory}/assets/;
assets_directory=$(pwd);

#printf "${assets_directory}\n";


cluster_id=0;
struct_id=0;

printf "" > ${spaghetti_data_temp};



printf "//\n" >> ${spaghetti_data_temp};
printf "// pili (c)by Michael Mussato\n" >> ${spaghetti_data_temp};
printf "// michimussato@gmail.com\n" >>  ${spaghetti_data_temp};
printf "// reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov\n" >> ${spaghetti_data_temp};
printf "//\n" >> ${spaghetti_data_temp};
printf "\n" >> ${spaghetti_data_temp};
printf "\n" >> ${spaghetti_data_temp};




printf "digraph G {\n" >> ${spaghetti_data_temp};
printf "	rankdir=LR;\n" >> ${spaghetti_data_temp};
#printf "	ratio=0.4;\n" >> ${spaghetti_data_temp};
printf "	ranksep=3.0;\n" >> ${spaghetti_data_temp};
printf "	margin=0;\n" >> ${spaghetti_data_temp};
printf "	bgcolor=\"#333333\";\n" >> ${spaghetti_data_temp};
printf "	graph [style=\"rounded\" fontsize=12 fontname=\"Verdana\" compound=true fontcolor=\"#888888\"];\n" >> ${spaghetti_data_temp};
printf "	node [shape=record fontsize=10 fontname=\"Verdana\"];\n" >> ${spaghetti_data_temp};
printf "	edge  [arrowhead=\"empty\" fontsize=8 fontname=\"Verdana\"];\n" >> ${spaghetti_data_temp};
printf "	\n"  >> ${spaghetti_data_temp};



printf "	subgraph cluster_${cluster_id} {\n" >> ${spaghetti_data_temp};
printf "		margin=10;\n" >> ${spaghetti_data_temp};
printf "		node [style=filled];\n" >> ${spaghetti_data_temp};
#printf "		URL=\"file://${project_directory}\";\n" >> ${spaghetti_data_temp};
printf "		label=\"${project_name}\";\n" >> ${spaghetti_data_temp};
printf "		color=black;\n" >> ${spaghetti_data_temp};
printf "		\n"  >> ${spaghetti_data_temp};




cd ${assets_directory};
array_assets=($(ls -d */));


if [ ${#array_assets[@]} == 0 ]; then
	printf "\e[33mASSET    : empty assets folder\e[0m\n";
	printf "__ We need to add a node to MAINGRAPH called ${asset} here\n";
	
	
	cluster_id=$[${cluster_id} +1];
	printf "		subgraph cluster_${cluster_id} {\n" >> ${spaghetti_data_temp};
	printf "			node [style=\"rounded,filled\"];\n" >> ${spaghetti_data_temp};
	printf "			margin=50;\n" >> ${spaghetti_data_temp};
	#printf "			URL=\"file://${project_directory}/assets/${asset}\";\n" >> ${spaghetti_data_temp};
	printf "			empty_node [label=\"empty_node\" fontcolor=\"#333333\" color=\"#333333\" ];\n" >> ${spaghetti_data_temp};
	printf "			color=\"#333333\";\n" >> ${spaghetti_data_temp};
	printf "			fontcolor=\"#333333\";\n" >> ${spaghetti_data_temp};
	printf "			label=\"empty_project\";\n" >> ${spaghetti_data_temp};
	printf "		}\n" >> ${spaghetti_data_temp};

else



	#alternative:
	#shopt -s nullglob
	#array=(*/)
	#shopt -u nullglob
	#array_assets=( $( \ls ${assets_directory}/*/ ) );

	for asset in ${array_assets[*]%/}; do
		printf "\e[33mASSET    : ${asset}\e[0m\n";
		printf "__ We need to add a node to MAINGRAPH called ${asset} here\n";
	
	
		cluster_id=$[${cluster_id} +1];
		printf "		subgraph cluster_${cluster_id} {\n" >> ${spaghetti_data_temp};
		printf "			node [style=\"rounded,filled\"];\n" >> ${spaghetti_data_temp};
		printf "			margin=50;\n" >> ${spaghetti_data_temp};
		#printf "			URL=\"file://${project_directory}/assets/${asset}\";\n" >> ${spaghetti_data_temp};
	
	
	
		cd ${assets_directory}/${asset};
	
	

	
	
		array_tasks=($(ls -d */));
	
		if [ ${#array_tasks[@]} == 0 ]; then
		
			#printf "\e[35mTASK     : ${task}\e[0m\n";
			printf "Asset ${asset} is empty\n";
			#printf "__ We need to add a node to SUBGRAPH called ${task} here\n";
		
			printf "			${asset}_empty_node [label=\"${asset}_empty_node\" fontcolor=\"#333333\" color=\"#333333\" ];\n" >> ${spaghetti_data_temp};
			#printf "			${task} [label=\"{ <${task}> ${task}\l }" >> ${spaghetti_data_temp};
		
		else
	
	
			for task in ${array_tasks[*]%/}; do
	
				#owner=$(ls -ld ${assets_directory}/${asset}/${task} | awk '{print $3}');
				owner=$(sed -n "1p" < ${assets_directory}/${asset}/${task}/meta );
		
				i=0;
		
				printf "\e[35mTASK     : ${task}\e[0m\n";
				printf "__ We need to add a node to SUBGRAPH called ${task} here\n";
		
				if [[ ${task:0:3} == ${task_array[0]:0:3} ]]; then			#MDL__Modelling
					task_color="\"#ffc6c6\"";
				elif [[ ${task:0:3} == ${task_array[1]:0:3} ]]; then		#CAM__Camera
					task_color="\"#c4c7ff\"";
				elif [[ ${task:0:3} == ${task_array[2]:0:3} ]]; then		#LIT__Lighting
					task_color="\"#f5beff\"";
				elif [[ ${task:0:3} == ${task_array[3]:0:3} ]]; then		#SHD__Shading
					task_color="\"#c7b4ff\"";
				elif [[ ${task:0:3} == ${task_array[4]:0:3} ]]; then		#ANM__Animation
					task_color="\"#c6ffc6\"";
				elif [[ ${task:0:3} == ${task_array[5]:0:3} ]]; then		#SIM__Simulation
					task_color="\"#ffefc7\"";
				elif [[ ${task:0:3} == ${task_array[6]:0:3} ]]; then		#RND__Rendering
					task_color="\"#bcffed\"";
				elif [[ ${task:0:3} == ${task_array[7]:0:3} ]]; then		#TEX__Texturing
					task_color="\"#b9d7ff\"";
				elif [[ ${task:0:3} == ${task_array[8]:0:3} ]]; then		#SPT__Sculpting
					task_color="\"#e6ffbe\"";
				elif [[ ${task:0:3} == ${task_array[9]:0:3} ]]; then		#RIG__Rigging
					task_color="\"#fffcb0\"";
				elif [[ ${task:0:3} == ${task_array[10]:0:3} ]]; then		#CMP__Compositing
					task_color="\"#c4ffd6\"";
				elif [[ ${task:0:3} == ${task_array[11]:0:3} ]]; then		#FUR__FurHair
					task_color="\"#ffbee9\"";
				elif [[ ${task:0:3} == ${task_array[12]:0:3} ]]; then		#CUT__Cutting
					task_color="\"#bbe0f9\"";
				elif [[ ${task:0:3} == ${task_array[13]:0:3} ]]; then		#TRK__Tracking
					task_color="\"#c8ffd0\"";
				elif [[ ${task:0:3} == ${task_array[14]:0:3} ]]; then		#SKN__Skinning
					task_color="\"#bffdf9\"";
				elif [[ ${task} == AST_${asset:4}_output ]]; then			#Asset Output
					task_color="\"#333333\"";
					font_color="\"#FFA80D\"";
				elif [[ ${task} == SHT_${asset:4}_output ]]; then			#Shot Output
					task_color="\"#333333\"";
					font_color="\"#0099FF\"";
				elif [[ ${task} == LNK__AST_* ]]; then						#Asset Link
					task_color="\"#FFA80D\"";
					font_color="\"#000000\"";
				elif [[ ${task} == LNK__SHT_* ]]; then						#Shot Link
					task_color="\"#0099FF\"";
					font_color="\"#000000\"";
				
		
				else
					task_color="grey";
				fi;
		
		
		
		
		
		
		
				touch "${launchers_root_temp}/${asset}_${task}.command";
				chmod a+x "${launchers_root_temp}/${asset}_${task}.command";
		
		
				printf "#!/bin/bash\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "#\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "# pili (c)by Michael Mussato\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "# michimussato@gmail.com\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "#\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "cd ${project_directory}/scripts/;\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "clear;\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf 'printf "\\e[31mHit key to open directory\\e[0m";\n' >> "${launchers_root_temp}/${asset}_${task}.command";
				printf 'run_me="run_task";\n' >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "read -n 1 -s -t 1 run_me;\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf 'printf "\\n";\n' >> "${launchers_root_temp}/${asset}_${task}.command";
				printf 'if [[ "${run_me}" != "run_task" ]]; then\n' >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "	open ${project_directory}/assets/${asset}/${task};\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "	exit;\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "else\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "	./run_task.command ${project_directory}/assets/${asset}/${task};\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "	exit;\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				printf "fi;\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				
				#printf ";\n" >> "${launchers_root_temp}/${asset}_${task}.command";
				
				
				
				
		
		
		

		
		
				if [[ ${task} == ${asset}_output ]]; then
		
					printf "			${task} [label=\"{ <${task}> ${task}\l }" >> ${spaghetti_data_temp};

				elif [[ ${task} == LNK__* ]]; then
		
					printf "			${asset}__${task} [label=\"{ <${task}> ${task}\l }" >> ${spaghetti_data_temp};

				else
					printf "			${task} [label=\"{ ${task} } | { inputs\l | ${owner} | outputs\\\r }" >> ${spaghetti_data_temp};
				fi;

		
				cd ${assets_directory}/${asset}/${task}/output/;
		
				array_outputs=($(ls));
		
				for output in ${array_outputs[*]%/}; do
			
					printf "\e[36mOUTPUT   : ${output}\e[0m\n";
					printf "__ We need to add a SUBGRAPH connection out-point called ${output} here\n";
			
				done;
		
		
		
		
		
				cd ${assets_directory}/${asset}/${task}/input/;
		
				#array_inputs=($(ls -d */));
				array_inputs=($(ls -L));
		
				#for element in ${array_inputs[@]}; do
				#	printf "\e[36m${element}\e[0m\n";
				#done;
		
		

				if [ ${#array_outputs[*]} -gt ${#array_inputs[*]} ]; then
					#printf "MORE OUTPUTS!!!!\n";
					printf "Outputs: ${#array_outputs[*]}\n";
					printf "Inputs:  ${#array_inputs[*]}\n";
					for j in ${array_outputs[@]%/}; do
				
				
				
						array_truncate_input=(${array_inputs[${i}]//__/ });
						#printf "${#array_truncate_input[${i}]}\n";
				
				
						if [[ "${array_truncate_input[1]}" == "LNK" ]]; then
				
				
							if [ "${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}" == "____" ]; then
				
								printf " | { \l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
						
							else
								#" | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]%/}> ${array_truncate_input[6]%/}\l |
					
								printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]%/}> ${array_truncate_input[6]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
					
					
							fi;
				
				
				
				

				
						else
				
				
						#printf "i=${i}\n";
				
							if [ "${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}" == "____" ]; then
					
								#printf " | { \l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }";
								printf " | { \l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
					
							else
								#printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}> ${array_truncate_input[3]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }";
								printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}> ${array_truncate_input[3]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
					
					
							fi;
						fi;
						i=$[${i} +1];
						#printf "\n";
				
				
								
					done;
			
				elif [ ${#array_outputs[*]} -lt ${#array_inputs[*]} ]; then
					#printf "MORE INPUTS!!!!\n";
					printf "Outputs: ${#array_outputs[*]}\n";
					printf "Inputs:  ${#array_inputs[*]}\n";
					for j in ${array_inputs[@]}; do
				
				
				
						array_truncate_input=(${j//__/ });
				
				
						#output_label=(${array_truncate_input[3]});
				
						#for m in ${array_truncate_input[@]}; do
						#	printf "${m}\n";
						#done;
				
				
				
				
						if [[ "${array_truncate_input[1]}" == "LNK" ]]; then
				
							#for array_truncate_input_element in ${array_truncate_input[@]}; do
							#	printf "\e[33m${array_truncate_input_element}\e[0m\n";
							#	printf "${task}__${array_outputs[${i}]%/\n}";
							#done;
					
							if [ "${task}__${array_outputs[${i}]%/}" == "${task}__" ]; then
					
								printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]%/}> ${array_truncate_input[6]%/}\l | \\\r }" >> ${spaghetti_data_temp};
					
							else
					
								printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]%/}> ${array_truncate_input[6]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
					
							fi;
					
						else
				
				
				
				
							#printf "i=${i}\n";
							if [ "${task}__${array_outputs[${i}]%/}" == "${task}__" ]; then
						
								printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}> ${array_truncate_input[3]%/}\l | \\\r }" >> ${spaghetti_data_temp};
					
							else
					
								printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}> ${array_truncate_input[3]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
							fi;
				
						fi;
						i=$[${i} +1];
					done;
		
				elif [ ${#array_outputs[@]} -eq ${#array_inputs[@]} ]; then
		
					#Create 
			
					#printf "OUTPUTS equal INPUTS!!!!\n";
					printf "Outputs: ${#array_outputs[*]}\n";
					printf "Inputs:  ${#array_inputs[*]}\n";
					for j in ${array_inputs[*]}; do
				
				
				
						array_truncate_input=(${j//__/ });
				
				
				
				
						if [[ "${array_truncate_input[1]}" == "LNK" ]]; then
				
							#Create inputs/outputs for LNK-tasks
							printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}__${array_truncate_input[4]}__${array_truncate_input[5]}__${array_truncate_input[6]%/}> ${array_truncate_input[6]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
				
						else
				
							#Create connection for all other tasks
							printf " | { <${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]%/}> ${array_truncate_input[3]%/}\l | <${task}__${array_outputs[${i}]%/}> ${array_outputs[${i}]%/}\\\r }" >> ${spaghetti_data_temp};
				
						fi;
						i=$[${i} +1];
					done;
		
		
				fi;
			
				if [[ ${task} == ${asset}_output ]]; then
					printf " \" fontcolor=${font_color} color=${task_color} ]\n" >> ${spaghetti_data_temp};
				elif [[ ${task} == LNK__* ]]; then
					printf " \" fontcolor=${font_color} color=${task_color} ]\n" >> ${spaghetti_data_temp};
				else
					printf " \" color=${task_color} URL=\"file://${launchers_root}/${asset}_${task}.command\"]\n" >> ${spaghetti_data_temp};
				fi;
		
		
		
				for input in ${array_inputs[*]%/}; do
					printf "\e[32mINPUT    : ${input}\e[0m\n";
					printf "__ We need to add a SUBGRAPH connection in-point called ${input} here\n";
			
					array_truncate_input=(${input//__/ });
			
					output_label=(${array_truncate_input[3]});
		
			
					link_input_counter=0;
					if [[ "${array_truncate_input[1]}__" == "LNK__" ]]; then
				
					
						array_truncate_link_input=(${input//__/ })
				
			
				
						#printf "${array_truncate_link_input[6]:0:3}\n";
				
				
						if [[ ${array_truncate_link_input[6]:0:3} == ${output_array[0]:0:3} ]]; then		#MDL__Model
							set_TSK_edge_color ${1} "\"#b38b8b\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[1]:0:3} ]]; then		#SEQ__FileSequence
							set_TSK_edge_color ${1} "\"#93a477\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[2]:0:3} ]]; then		#PLB__Playblast
							set_TSK_edge_color ${1} "\"#b3b3b3\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[3]:0:3} ]]; then		#CAM__Camera
							set_TSK_edge_color ${1} "\"#898bb3\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[4]:0:3} ]]; then		#TEX__Texture
							set_TSK_edge_color ${1} "\"#8297b3\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[5]:0:3} ]]; then		#CCH__Cache
							set_TSK_edge_color ${1} "\"#b3a78b\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[6]:0:3} ]]; then		#SHD__Shader
							set_TSK_edge_color ${1} "\"#8c7fb2\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[7]:0:3} ]]; then		#RIG__Rig
							set_TSK_edge_color ${1} "\"#b3b17b\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[8]:0:3} ]]; then		#FUR__FurGroom
							set_TSK_edge_color ${1} "\"#b286a4\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[9]:0:3} ]]; then		#ABC__Alembic
							set_TSK_edge_color ${1} "\"#b286a4\"";
						elif [[ ${array_truncate_link_input[6]:0:3} == ${output_array[10]:0:3} ]]; then		#LIT__LightSetup
							set_TSK_edge_color ${1} "\"#77a483\"";
			
		
		
						else
							edge_color="black";
						fi;
				
				
				
			
				
						#for array_truncate_link_input_element in ${array_truncate_link_input[@]}; do
						#	printf "\e[35m${array_truncate_link_input[${link_input_counter}]}\e[0m\n";
						#	link_input_counter=$[${link_input_counter} +1];
						#done;
					
					
				
						array_output_input+=("	${asset}__${array_truncate_input[1]}__${array_truncate_input[2]}:${array_truncate_link_input[1]}__${array_truncate_link_input[2]}__${array_truncate_link_input[3]}__${array_truncate_link_input[4]}__${array_truncate_link_input[5]}__${array_truncate_link_input[6]}:e -> ${task}:${array_truncate_link_input[1]}__${array_truncate_link_input[2]}__${array_truncate_link_input[3]}__${array_truncate_link_input[4]}__${array_truncate_link_input[5]}__${array_truncate_link_input[6]}:w	[fontcolor=\"#ff000000\" taillabel=\"|||\" tailURL=\"file://${assets_directory}/${asset}/${array_truncate_input[1]}__${array_truncate_input[2]}/output/${array_truncate_input[3]}\" headlabel=\"\|||\" headURL=\"file://${assets_directory}/${asset}/${task}/input/${asset}__${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}/\" arrowhead=dot arrowtail=dot dir=both notjustify=0 labelfloat=0 style=${edge_style} color=${edge_color}];\n");
				

					else
			
			
			
						if [[ ${output_label:0:3} == ${output_array[0]:0:3} ]]; then		#MDL__Model
							set_TSK_edge_color ${1} "\"#b38b8b\"";
						elif [[ ${output_label:0:3} == ${output_array[1]:0:3} ]]; then		#SEQ__FileSequence
							set_TSK_edge_color ${1} "\"#93a477\"";
						elif [[ ${output_label:0:3} == ${output_array[2]:0:3} ]]; then		#PLB__Playblast
							set_TSK_edge_color ${1} "\"#b3b3b3\"";
						elif [[ ${output_label:0:3} == ${output_array[3]:0:3} ]]; then		#CAM__Camera
							set_TSK_edge_color ${1} "\"#898bb3\"";
						elif [[ ${output_label:0:3} == ${output_array[4]:0:3} ]]; then		#TEX__Texture
							set_TSK_edge_color ${1} "\"#8297b3\"";
						elif [[ ${output_label:0:3} == ${output_array[5]:0:3} ]]; then		#CCH__Cache
							set_TSK_edge_color ${1} "\"#b3a78b\"";
						elif [[ ${output_label:0:3} == ${output_array[6]:0:3} ]]; then		#SHD__Shader
							set_TSK_edge_color ${1} "\"#8c7fb2\"";
						elif [[ ${output_label:0:3} == ${output_array[7]:0:3} ]]; then		#RIG__Rig
							set_TSK_edge_color ${1} "\"#b3b17b\"";
						elif [[ ${output_label:0:3} == ${output_array[8]:0:3} ]]; then		#FUR__FurGroom
							set_TSK_edge_color ${1} "\"#b286a4\"";
						elif [[ ${output_label:0:3} == ${output_array[9]:0:3} ]]; then		#ABC__Alembic
							set_TSK_edge_color ${1} "\"#b286a4\"";
						elif [[ ${output_label:0:3} == ${output_array[10]:0:3} ]]; then		#LIT__LightSetup
							set_TSK_edge_color ${1} "\"#77a483\"";
						#elif [[ ${output_label:0:3} == LNK__* ]]; then						#LNK__AssetLink
						#	set_TSK_edge_color "\"#00ff00\"";
						else																#UNKNOWN OUTPUTS
							set_TSK_edge_color ${1} "\"#888888\"";
						fi;
			
			
			
			
			
			
			
						array_output_input+=("	${array_truncate_input[1]}__${array_truncate_input[2]}:${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}:e -> ${task}:${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}:w	[fontcolor=\"#ff000000\" taillabel=\"|||\" tailURL=\"file://${assets_directory}/${asset}/${array_truncate_input[1]}__${array_truncate_input[2]}/output/${array_truncate_input[3]}\" headlabel=\"\|||\" headURL=\"file://${assets_directory}/${asset}/${task}/input/${asset}__${array_truncate_input[1]}__${array_truncate_input[2]}__${array_truncate_input[3]}/\" arrowhead=dot arrowtail=dot dir=both notjustify=0 labelfloat=0 style=${edge_style} color=${edge_color}];\n");
					fi;
					#printf "_______________	${task} -> ${array_truncate_input[1]}__${array_truncate_input[2]}	[label=${output_label} fontsize=6 fontname=\"Verdana\"];\n";
			
					#printf "	${output} -> ${input}\n"  >> ${spaghetti_data_temp};
			
			
		
				done;
		
		
			done;
		
		fi;
	
		printf "			label=\"${asset}\";\n" >> ${spaghetti_data_temp};
		if [ ${asset:0:4} == "AST_" ]; then
			printf "			color=\"#FFA80D\";\n" >> ${spaghetti_data_temp};
		elif [ ${asset:0:4} == "SHT_" ]; then
			printf "			color=\"#0099FF\";\n" >> ${spaghetti_data_temp};
		fi;
		printf "		}\n" >> ${spaghetti_data_temp};
		printf "		\n"  >> ${spaghetti_data_temp};
	
	done;
	
fi;

printf "	}\n" >> ${spaghetti_data_temp};

#edges here:
#
#
for connection in ${array_output_input[@]}; do
	printf "	${connection}" >> ${spaghetti_data_temp};
done;
#
#echo ${array_output_input[*]};

printf "}\n" >> ${spaghetti_data_temp};

sleep 0.5;
mv ${launchers_root} ${launchers_root}_trash;
sleep 0.5;
rm -rf ${launchers_root}_trash;
sleep 0.5;
mv -f ${launchers_root_temp} ${launchers_root};
sleep 0.5;
mv -f ${spaghetti_data_temp} ${spaghetti_data};