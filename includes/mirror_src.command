#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################



clear;



current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd ${current_directory};



printf "This syncs src (includes) to destination\n";
printf "Drop destination path - I will create a subdirectory...\n";
read src_mirror;



rsync -rhv ${current_directory}/. ${src_mirror}/ --exclude="__*" --exclude=".git*" --exclude="mirror_src.command" --exclude="create_new_backup.command" --checksum --progress --delete --delete-before;
#rsync -rhv /Users/michaelmussato/Dropbox/development/workspace/pili/. /Volumes/Senic_Daten/pipeline_tests/src/ --exclude="__*" --exclude=".git*" --checksum --progress --delete --delete-before;