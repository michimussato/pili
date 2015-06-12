#!/bin/bash

for LINE in $(<assets.tmp); 
	do printf "${LINE}\n"; 
done;