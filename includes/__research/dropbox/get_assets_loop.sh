#!/bin/bash



touch get_assets_loop.tmp;

ls /*/ > get_assets_loop.tmp;

for ENTRY in $(<get_assets_loop.tmp);
	do
		printf "$ENTRY\n";
done;

rm get_assets_loop.tmp;