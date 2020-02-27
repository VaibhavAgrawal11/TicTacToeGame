#!/bin/bash -x
printf "Assign letter to player.\n"
#VARIABLES
count=0
#CONSTANTS
PLAYER=0
COMPUTER=1
DOT=0
CROSS=1
declare -a displayBoard
displayBoard=(" " " " " " " " " " " " " " " " " ")

function displayBoard(){
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
}

displayBoard
random=$((RANDOM%2))
case $random in
	$DOT)
	playerLetter=O
	;;
	$CROSS)
	playerLetter=X
	;;
esac
checkChance=$((RANDOM%2))
case $checkChance in
	$PLAYER)
	printf "playerChance\n"
	;;
	$COMPUTER)
	printf "computerChance\n"
	;;
esac
