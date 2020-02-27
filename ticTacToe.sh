#!/bin/bash -x
printf "Display fresh board\n"
count=0
declare -a displayBoard
displayBoard=(" " " " " " " " " " " " " " " " " ")
for(( index=0; index<${#displayBoard[@]}; index++))
do
	printf " ${displayBoard[$index]} | "
	count=$((count+1))
	if(($count%3==0 && count!=9))
	then
		printf "\n---+----+----+----\n"
	fi
done
printf "\n"
