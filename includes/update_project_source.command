#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


#update_project_source.command

clear;

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};

source ${current_directory}/config/environment_vars.conf;
source ${current_directory}/functions/functions.conf;

printf "This syncs project script sources and template documents with the actual build\n";
printf "1. Update single project\n";
printf "2. Batch update all\n";
read p_batch_update;

time_stamp=`date +"%Y-%m-%d_%H%M-%S"`;

case ${p_batch_update} in
	1)
		printf "Choose project to update\n";
		read p_update;

		#rsync scripts
		rsync -rhv ${current_directory}/template_scripts/. ${p_update}/scripts/ --exclude="*/" --checksum --progress --delete --delete-before;
		#rsync -rhv /pili/includes/template_scripts/. /pili/projects/2013-12-02___salihoi___hoi/scripts/ --exclude="*/" --checksum --progress --delete --delete-before


		#rsync template_documents
		rsync -rhv ${current_directory}/template_documents/. ${p_update}/scripts/template_documents/ --progress --checksum --delete --delete-before;
		# rsync -rhv /pili/includes/template_documents/. /pili/projects/2013-12-02___test___test/scripts/template_documents/ --progress --delete --delete-before
		
		#backup project conf-file 
		conf_new=${p_update}/scripts/conf/config.p_conf;
		conf_backup=${p_update}/scripts/conf/${time_stamp}_config.p_conf;
		touch ${conf_backup};
		cat ${conf_new} > ${conf_backup};
		
		#clear out projects' conf-file
		printf "" > ${conf_new};
		
		printf "this_p_location='${p_update}';\n" >> "${conf_new}";
		printf "this_app_vlc='${app_vlc}';\n" >> "${conf_new}";
		printf "this_app_maya2013x64='${app_maya2013x64}';\n" >> "${conf_new}";
		printf "this_app_maya2014x64='${app_maya2014x64}';\n" >> "${conf_new}";
		printf "this_app_photoshopcs6x64='${app_photoshopcs6x64}';\n" >> "${conf_new}";
		printf "this_app_photoshopcc12x64='${app_photoshopcc12x64}';\n" >> "${conf_new}";
		printf "this_app_aftereffectscs6x64='${app_aftereffectscs6x64}';\n" >> "${conf_new}";
		printf "this_app_aftereffectscc12x64='${app_aftereffectscc12x64}';\n" >> "${conf_new}";
		printf "this_app_premierecs6x64='${app_premierecs6x64}';\n" >> "${conf_new}";
		printf "this_app_premierecc12x64='${app_premierecc12x64}';\n" >> "${conf_new}";
		printf "this_app_indesigncs6x64='${app_indesigncs6x64}';\n" >> "${conf_new}";
		printf "this_app_indesigncc12x64='${app_indesigncc12x64}';\n" >> "${conf_new}";
		printf "this_app_illustratorcs6x64='${app_illustratorcs6x64}';\n" >> "${conf_new}";
		printf "this_app_illustratorcc12x64='${app_illustratorcc12x64}';\n" >> "${conf_new}";
		printf "this_app_nuke631x64='${app_nuke631x64}';\n" >> "${conf_new}";
		printf "this_app_nuke708x64='${app_nuke708x64}';\n" >> "${conf_new}";
		printf "this_app_realflow6000055x32='${app_realflow6000055x32}';\n" >> "${conf_new}";
		printf "this_app_realflow7010131x32='${app_realflow7010131x32}';\n" >> "${conf_new}";
		printf "this_app_pftrack41r3x32='${app_pftrack41r3x32}';\n" >> "${conf_new}";
		printf "this_app_zbrush4r5x32='${app_zbrush4r5x32}';\n" >> "${conf_new}";
		printf "this_app_zbrush4r6x32='${app_zbrush4r6x32}';\n" >> "${conf_new}";
		printf "this_app_mudbox2013x64='${app_mudbox2013x64}';\n" >> "${conf_new}";
		printf "this_app_mudbox2015x64='${app_mudbox2015x64}';\n" >> "${conf_new}";
		printf "this_app_cinema4dr15x64='${app_cinema4dr15x64}';\n" >> "${conf_new}";
		printf "this_app_blender269x64='${app_blender269x64}';\n" >> "${conf_new}";
		printf "this_app_houdini130314x64='${app_houdini130314x64}';\n" >> "${conf_new}";
		
		;;
		
	2)
		printf "Choose project root to update all containing projects\n";
		read p_update;
		
		for p_subfolder in $(ls ${p_update}); do
			rsync -rhv ${current_directory}/template_scripts/. ${p_update}/${p_subfolder}/scripts/ --exclude="*/" --checksum --progress --delete --delete-before;
			rsync -rhv ${current_directory}/template_documents/. ${p_update}/${p_subfolder}/scripts/template_documents/ --progress --checksum --delete --delete-before;
			
			
			
			#backup project conf-file 
			conf_new=${p_update}/${p_subfolder}/scripts/conf/config.p_conf;
			conf_backup=${p_update}/${p_subfolder}/scripts/conf/${time_stamp}_config.p_conf;
			touch ${conf_backup};
			cat ${conf_new} > ${conf_backup};
			
			#clear out projects' conf-file
			printf "" > ${conf_new};
			
			printf "this_p_location='${p_update}/${p_subfolder}';\n" >> "${conf_new}";
			printf "this_app_vlc='${app_vlc}';\n" >> "${conf_new}";
			printf "this_app_maya2013x64='${app_maya2013x64}';\n" >> "${conf_new}";
			printf "this_app_maya2014x64='${app_maya2014x64}';\n" >> "${conf_new}";
			printf "this_app_photoshopcs6x64='${app_photoshopcs6x64}';\n" >> "${conf_new}";
			printf "this_app_photoshopcc12x64='${app_photoshopcc12x64}';\n" >> "${conf_new}";
			printf "this_app_aftereffectscs6x64='${app_aftereffectscs6x64}';\n" >> "${conf_new}";
			printf "this_app_aftereffectscc12x64='${app_aftereffectscc12x64}';\n" >> "${conf_new}";
			printf "this_app_premierecs6x64='${app_premierecs6x64}';\n" >> "${conf_new}";
			printf "this_app_premierecc12x64='${app_premierecc12x64}';\n" >> "${conf_new}";
			printf "this_app_indesigncs6x64='${app_indesigncs6x64}';\n" >> "${conf_new}";
			printf "this_app_indesigncc12x64='${app_indesigncc12x64}';\n" >> "${conf_new}";
			printf "this_app_illustratorcs6x64='${app_illustratorcs6x64}';\n" >> "${conf_new}";
			printf "this_app_illustratorcc12x64='${app_illustratorcc12x64}';\n" >> "${conf_new}";
			printf "this_app_nuke631x64='${app_nuke631x64}';\n" >> "${conf_new}";
			printf "this_app_nuke708x64='${app_nuke708x64}';\n" >> "${conf_new}";
			printf "this_app_realflow6000055x32='${app_realflow6000055x32}';\n" >> "${conf_new}";
			printf "this_app_realflow7010131x32='${app_realflow7010131x32}';\n" >> "${conf_new}";
			printf "this_app_pftrack41r3x32='${app_pftrack41r3x32}';\n" >> "${conf_new}";
			printf "this_app_zbrush4r5x32='${app_zbrush4r5x32}';\n" >> "${conf_new}";
			printf "this_app_zbrush4r6x32='${app_zbrush4r6x32}';\n" >> "${conf_new}";
			printf "this_app_mudbox2013x64='${app_mudbox2013x64}';\n" >> "${conf_new}";
			printf "this_app_mudbox2015x64='${app_mudbox2015x64}';\n" >> "${conf_new}";
			printf "this_app_cinema4dr15x64='${app_cinema4dr15x64}';\n" >> "${conf_new}";
			printf "this_app_blender269x64='${app_blender269x64}';\n" >> "${conf_new}";
			printf "this_app_houdini130314x64='${app_houdini130314x64}';\n" >> "${conf_new}";
			
			
			
			
		done;
		;;
		
esac;