#!/bin/bash -x
printf "Added feature that computer will check for sides. \n"
#CONSTANTS
PLAYER=0
COMPUTER=1
DOT=0
CROSS=1
IS_EMPTY=" "
#VARIABLES
computerLetter=""
playerLetter=""

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
	  		playerLetter="O"
			computerLetter="X"
	   	;;
	   $CROSS)
	   	playerLetter="X"
			computerLetter="O"
	   	;;
	esac
	echo "Computer letter:  $computerLetter"
	echo "Player letter: $playerLetter"
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
	if [ "${display[$response]}" != "X" ] && [ "${display[$response]}" != "O" ] && [ $response -le 8 ]
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
			if [ "${display[$index]}" != "X" ] && [ "${display[$index]}" != "O" ]
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

#CHECKING IF COMPUTER CAN WIN NEXT MOVE
function check_Block_WiningMove()
{
	local letter=$1
	index=0
	#CHECKING FOR ROWS
	while(($index<8))
	do
		if [[ ${display[$index]} == $letter && ${display[$((index+1))]} == $letter && ${display[$((index+2))]} == $IS_EMPTY ]]
   	then
			display[$((index+2))]=$computerLetter
			compPlay=1
			return
      elif [[ ${display[$index]} == $letter && ${display[$((index+2))]} == $letter && ${display[$((index+1))]} == $IS_EMPTY ]]
      then
         display[$((index+1))]=$computerLetter
         compPlay=1
         return
		elif [[ ${display[$((index+2))]} == $letter && ${display[$((index+1))]} == $letter && ${display[$index]} == $IS_EMPTY ]]
      then
         display[$index]=$computerLetter
         compPlay=1
         return
		fi
		index=$((index+3))
	done
	index=0
	#CHECKING FOR COLUMNS
	while(($index<8))
   do
		if [[ ${display[$index]} == $letter && ${display[$((index+3))]} == $letter && ${display[$((index+6))]} == $IS_EMPTY ]]
      then
         display[$((index+6))]=$computerLetter
         compPlay=1
         return
		elif [[ ${display[$index]} == $letter && ${display[$((index+6))]} == $letter && ${display[$((index+3))]} == $IS_EMPTY ]]
      then
         display[$((index+3))]=$computerLetter
         compPlay=1
         return
		elif [[ ${display[$((index+3))]} == $letter && ${display[$((index+6))]} == $letter && ${display[$index]} == $IS_EMPTY ]]
      then
         display[$index]=$computerLetter
         compPlay=1
         return
		fi
		index=$((index+1))
	done
	#CHECKING FOR PRIMARY DIAGONAL
	if [[ ${display[0]} == $letter && ${display[4]} == $letter && ${display[8]} == $IS_EMPTY ]]
	then
		display[8]=$computerLetter
	   compPlay=1
	   return
	elif [[ ${display[0]} == $letter && ${display[8]} == $letter && ${display[4]} == $IS_EMPTY ]]
	then
	   display[4]=$computerLetter
	   compPlay=1
	   return
	elif [[ ${display[8]} == $letter && ${display[4]} == $letter && ${display[0]} == $IS_EMPTY ]]
	then
	   display[0]=$computerLetter
	   compPlay=1
	   return
	fi
	#CHECKING FOR SECONDARY DIAGONAL
	if [[ ${display[2]} == $letter && ${display[4]} == $letter && ${display[6]} == $IS_EMPTY ]]
	then
	   display[6]=$computerLetter
	   compPlay=1
	   return
	elif [[ ${display[2]} == $letter && ${display[6]} == $letter && ${display[4]} == $IS_EMPTY ]]
	then
	   display[4]=$computerLetter
	   compPlay=1
	   return
	elif [[ ${display[6]} == $letter && ${display[4]} == $letter && ${display[2]} == $IS_EMPTY ]]
	then
	   display[2]=$computerLetter
	   compPlay=1
	   return
	fi
}
#FILLING CORNERS RANDOMLY
function fillCorners()
{
	local letter=$1
	compPlay=0
	randomCorner=$((RANDOM%4))
	case $randomCorner in
	0)
		if [[ ${display[0]} == $IS_EMPTY ]]
		then
			display[0]=$letter
   	   compPlay=1
   	   return
		else
			fillCorners $letter
		fi
		;;
	1)
		if [[ ${display[2]} == $IS_EMPTY ]]
   	then
   	   display[2]=$letter
   	   compPlay=1
   	   return
		else
   	   fillCorners $letter
  		fi 
   	;;
	2)
		if [[ ${display[6]} == $IS_EMPTY ]]
   	then
   	   display[6]=$letter
      	compPlay=1
      	return
		else
   	   fillCorners $letter
   	fi 
		;;
	3)
		if [[ ${display[8]} == $IS_EMPTY ]]
   	then
   	   display[8]=$letter
   	   compPlay=1
   	   return
		else
   	   fillCorners $letter
   	fi
		;; 
	esac
}

#FUNCTION TO TAKE CENTER
function takeCenter()
{
	computerLetter=$1
	compPlay=0
	if [[ ${display[4]} == $IS_EMPTY ]]
	then
		display[4]=$computerLetter
		compPlay=1
	fi
}

#FUNTION TO TAKE ANY ONE SIDE
function takeSides()
{
	local letter=$1
   compPlay=0
   randomCenter=$((RANDOM%4))
   case $randomCenter in
   0)
   	if [[ ${display[1]} == $IS_EMPTY ]]
   	then
   	   display[1]=$letter
   	   compPlay=1
   	   return
   	else
   	   takeSides $letter
   	fi
   	;;
   1)
   	if [[ ${display[3]} == $IS_EMPTY ]]
   	then
   	   display[3]=$letter
   	   compPlay=1
   	   return
   	else
   	   takeSides $letter
   	fi 
   	;;
   2)
   	if [[ ${display[5]} == $IS_EMPTY ]]
   	then
   	   display[5]=$letter
   	   compPlay=1
   	   return
   	else
   	   takeSides $letter
   	fi
   	;;
	 3)
   	if [[ ${display[7]} == $IS_EMPTY ]]
   	then
   	   display[7]=$letter
   	   compPlay=1
   	   return
   	else
  	   	takeSides $letter
   	fi
		;;
   esac
}

#COMPUTER TURN
function computerTurn()
{
	computerLetter=$1
	playerLetter=$2
	compPlay=0
	echo "Computer turn: "
	check_Block_WiningMove $computerLetter
	if(($compPlay==0))
	then
		check_Block_WiningMove $playerLetter
	fi
	if(($compPlay==0))
	then
		fillCorners $computerLetter
	fi
	if(($compPlay==0))
	then
		takeCenter $computerLetter
	fi
	if(($compPlay==0))
	then
		takeSides $computerLetter
	fi
	displayBoard
}

#FUCTION TO PLAY BOTH THE PLAYERS ALTERNATIVELY
function alternatePlay()
{
	chance="$(firstChance)"
	flag=0
	if [ "$chance" = "computerChance" ]
	then
	   flag=1
	fi
	while ((0==0 ))
	do
	   if(( flag%2!=0 ))
	   then
  	    computerTurn $computerLetter $playerLetter
  	    result=$(checkWin $computerLetter)
  	    if [[ $result = "wins" ]] || [[ $result = "draw" ]]
 	     then
 	        printf " Computer $result\n"
 	        break 
 	     fi
 	  else
 	     playerTurn $playerLetter
 	     result="$(checkWin $playerLetter)"
 	     if [[ $result = "wins" ]] || [[ $result = "draw" ]]
 	     then
 	        printf " Player $result\n"
 	        break 
 	     fi
 	  fi
 	  flag=$((flag+1))
	done
}

displayBoard
assignLetter
alternatePlay
