#!/bin/bash -x
printf "Added feature for player turn.\n"
#CONSTANTS
PLAYER=0
COMPUTER=1
DOT=0
CROSS=1
declare -a displayBoard
display=(" " " " " " " " " " " " " " " " " ")

#DISPLAY THE ARRAY IN TICTACTOE BOARD
function displayBoard(){
	row=0
	column=0
	for(( index=0; index<${#display[@]}; index++))
	do
		printf " ${display[$index]} "
		column=$((column+1))
		row=$((row+1))
		if((row%3!=0))
		then
			printf " | "
		fi
		if(($column%3==0 && $column!=9))
		then
			printf "\n----+-----+----\n"
		fi
	done
	printf "\n"
}

#LOGIC FOR PLAYER TURN
function playerTurn(){
	playerLetter=$1
	printf "Enter index between 0 to 8 you want to chose\n"
	read response
	#IF NO VALUE IS ASSIGN TO THE INDEX THEN GO AHEAD ELSE RETURN FUCTION
	if [[ "${display[$response]}"!=X || "${display[$response]}"!=O ]]
	then
		display[$response]="$playerLetter"
	else
		playerTurn $playerLetter
	fi
	displayBoard
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
playerTurn $playerLetter
