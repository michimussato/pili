#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#create_new_project.command

clear;

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/config/environment_vars.conf;
source ${current_directory}/functions/functions.conf;

printf "Create new project\n";
printf "\n";
printf "Enter project name:\n";
read p_name;

printf "\n";
printf "Enter client\n";
read p_client;

printf "\n";
printf "Enter project number\n";
printf "(leave empty if none)\n";
read p_number;

if [[ ${p_number} == "" ]]; then

	p_name="${p_prefix}___${p_client}___${p_name}";

else

	p_name="${p_prefix}___${p_number}___${p_client}___${p_name}";
	
fi;

p_location="${p_root}/${p_name}";

create_project_folders;

rsync -rvht --progress "${s_root}/." "${p_location}/scripts/";
rsync -rvht --progress "${d_root}/" "${p_location}/scripts/template_documents/";
cd "${p_location}";
ln -sfn "./scripts/run_pili.command" "Run Pili (${p_name})";

#copy_asset_template;
#copy_asset_link_template;
#copy_task_template;
#copy_duplicate_task_template;
#copy_output_template;
#copy_outputversion_template;
##copy_asset_output_template;
#copy_input_template;
##copy_shot_template;
#copy_publish_template;
#copy_run_task;
#copy_template_documents;
#copy_set_final_template;
#copy_tasks_tools_outputs;
#copy_correspondence_template;
#copy_run_pili;
#copy_generate_network;
#copy_screencapture;
#copy_timetracker;
#copy_spaghetti_refresher;
##copy_functions;

p_conf_absolute="${p_location}/${p_conf}";

touch "${p_conf_absolute}";
chmod a+rwx "${p_conf_absolute}";

printf "this_p_location='${p_location}';\n" >> "${p_conf_absolute}";
printf "this_app_vlc='${app_vlc}';\n" >> "${p_conf_absolute}";
printf "this_app_maya2013x64='${app_maya2013x64}';\n" >> "${p_conf_absolute}";
printf "this_app_photoshopcs6x64='${app_photoshopcs6x64}';\n" >> "${p_conf_absolute}";
printf "this_app_photoshopcc121x64='${app_photoshopcc121x64}';\n" >> "${p_conf_absolute}";
printf "this_app_aftereffectscs6x64='${app_aftereffectscs6x64}';\n" >> "${p_conf_absolute}";
printf "this_app_aftereffectscc121x64='${app_aftereffectscc121x64}';\n" >> "${p_conf_absolute}";
printf "this_app_premierecs6x64='${app_premierecs6x64}';\n" >> "${p_conf_absolute}";
printf "this_app_premierecc121x64='${app_premierecc121x64}';\n" >> "${p_conf_absolute}";
printf "this_app_indesigncs6x64='${app_indesigncs6x64}';\n" >> "${p_conf_absolute}";
printf "this_app_indesigncc121x64='${app_indesigncc121x64}';\n" >> "${p_conf_absolute}";
printf "this_app_illustratorcs6x64='${app_illustratorcs6x64}';\n" >> "${p_conf_absolute}";
printf "this_app_illustratorcc121x64='${app_illustratorcc121x64}';\n" >> "${p_conf_absolute}";
printf "this_app_nuke631x64='${app_nuke631x64}';\n" >> "${p_conf_absolute}";
printf "this_app_nuke708x64='${app_nuke708x64}';\n" >> "${p_conf_absolute}";
printf "this_app_realflow6000055x32='${app_realflow6000055x32}';\n" >> "${p_conf_absolute}";
printf "this_app_realflow7010131x32='${app_realflow7010131x32}';\n" >> "${p_conf_absolute}";
printf "this_app_pftrack41r3x32='${app_pftrack41r3x32}';\n" >> "${p_conf_absolute}";
printf "this_app_zbrush4r5x32='${app_zbrush4r5x32}';\n" >> "${p_conf_absolute}";
printf "this_app_zbrush4r6x32='${app_zbrush4r6x32}';\n" >> "${p_conf_absolute}";
printf "this_app_mudbox2013x64='${app_mudbox2013x64}';\n" >> "${p_conf_absolute}";
printf "this_app_cinema4dr15x64='${app_cinema4dr15x64}';\n" >> "${p_conf_absolute}";
printf "this_app_blender269x64='${app_blender269x64}';\n" >> "${p_conf_absolute}";
printf "this_app_houdini130314x64='${app_houdini130314x64}';\n" >> "${p_conf_absolute}";

open "${p_location}";