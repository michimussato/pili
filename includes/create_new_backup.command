#!/bin/bash


############################################################################
# pili (c)by Michael Mussato                                               #
# michimussato@gmail.com                                                   #
# reel: https://www.dropbox.com/s/dxem0hl677fiapi/current_reelCut_h264.mov #
############################################################################


# This script creates a backup of the pili source folder "includes"
# and copies it to the "version" and dropbox directory

current_directory="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

v_prefix=`date +"%Y-%m-%d_%H%M-%S"`;

cd "${current_directory}";


cd ../version;
cd "${current_directory}"/..; 
tar -czvf version/"${v_prefix}".tar.gz includes/;

cp version/"${v_prefix}".tar.gz /Users/michaelmussato/Dropbox/pili/version/;