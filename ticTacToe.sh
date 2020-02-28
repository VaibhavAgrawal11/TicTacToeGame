#!/bin/bash -x
printf "Added feature to play computer like player \n"
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
	printf "\n\n"
}

#LOGIC TO ASSIGN LETTER
function assignLetter()
{
	random=$((RANDOM%2))
	case $random in
	   $DOT)
	   playerLetter=O
		computerLetter=X
	   ;;
	   $CROSS)
	   playerLetter=X
		computerLetter=O
	   ;;
	esac
}

#LOGIC TO GIVE FIRST CHANCE RANDOMLY
function firstChance()
{
	checkChance=$((RANDOM%2))
	case $checkChance in
   	$PLAYER)
   	echo "playerChance"
   	;;
   	$COMPUTER)
   	echo "computerChance"
   	;;
	esac
}

#LOGIC FOR PLAYER TURN
function playerTurn(){
	playerLetter=$1
	printf "Enter index between 0 to 8 you want to chose\n"
	read response
	#IF NO VALUE IS ASSIGN TO THE INDEX THEN GO AHEAD ELSE RETURN FUCTION
	if [ "${display[$response]}" != X ] && [ "${display[$response]}" != O ]
	then
		display[$response]="$playerLetter"
		displayBoard
	else
		printf "Invalid input\n"
		playerTurn $playerLetter
	fi
}

#LOGIC TO CHECK THE WINNER ON EVERY MOVE
function checkWin(){
	letter=$1
	if [ "${display[0]}${display[1]}${display[2]}" = "$letter$letter$letter" ];
 	then
		result="wins"
	elif [ "${display[3]}${display[4]}${display[5]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[6]}${display[7]}${display[8]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[0]}${display[3]}${display[6]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[1]}${display[4]}${display[7]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[2]}${display[5]}${display[8]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[0]}${display[3]}${display[6]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[0]}${display[4]}${display[8]}" = "$letter$letter$letter" ]
   then
      result="wins"
	elif [ "${display[2]}${display[4]}${display[6]}" = "$letter$letter$letter" ]
   then
      result="wins"
	else
		flag=0
		for(( index=0; index<${#display[@]}; index++))
		do
			if [ "${display[$index]}" != X ] && [ "${display[$index]}" != O ]
			then
				flag=1
			fi
		done
		if(($flag==0))
		then
			result="draw"
		else
			result="change"
		fi
fi
echo $result
}

#COMPUTER WIN RANDOMLY PLAY ON ITS TURN
function computerTurn()
{
	computerLetter=$1
   response=$((RANDOM%9))
   #IF NO VALUE IS ASSIGN TO THE INDEX THEN GO AHEAD ELSE RETURN FUCTION
   if [ "${display[$response]}" != X ] && [ "${display[$response]}" != O ]
   then
		echo "Computer turn: "
      display[$response]="$computerLetter"
		displayBoard

   else
      computerTurn $computerLetter
   fi
}

displayBoard
assignLetter
chance="$(firstChance)"
flag=0
if [ "$chance" = "computerChance" ]
then
   flag=1
fi
while ((0==0 ))
do
   if(( flag%2==0 ))
   then
      computerTurn $computerLetter
      result="$(checkWin $computerLetter)"
      if [[ $result = "wins" ]] || [[ $result = "draw" ]]
      then
         printf " Computer $result\n"
         break 
      fi
   else
      playerTurn $playerLetter
      result="$(checkWin $playerLetter)"
      if [ $result = "wins" ] || [ $result = "draw" ]
      then
         printf " Player $result\n"
         break 
      fi
   fi
   flag=$((flag+1))
done

