#source ./array;
file="/Users/michaelmussato/Dropbox/development/workspace/pili/includes/__research/source_array/array";
#test=("5","6","7")

#printf ${string};
#printf ${test[*]};
#${contents[*]};


array=();
while read line;
do 
	array[${#array[*]}]=${line};
done < "/Users/michaelmussato/Dropbox/development/workspace/pili/includes/__research/source_array/array"

#printf ${array[@]};

printf ${array[0]:0:3}"\n";
printf ${array[1]}"\n";
printf ${array[2]}"\n";
