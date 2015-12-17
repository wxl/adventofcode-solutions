#!/usr/bin/env bash

function santaformula {
	
	move=$(( $move + 1 ))

	if [ "$1" == "(" ]; then
		change=1
	elif [ "$1" == ")" ]; then
		change=-1
	else
		change=0
	fi

	finalfloor=$(( $finalfloor + $change ))
	
	if [[ $finalfloor = -1 && -z $basementmove ]]; then
		basementmove=$move
	fi

}

if [ $# != 0 ]; then

	while IFS= read -r -n1 char; do
		santaformula $char
	done <<< $1

else

	read -er -i "$HOME/Downloads/input.txt" -p "Input file: " INPUT
	
	if [ -z $INPUT ]; then
		INPUT="$HOME/Downloads/input.txt"
	fi
	
	# stupid tilde expansion
	INPUT="${INPUT/#\~/$HOME}"

	if [ ! -f "$INPUT" ]; then
		echo "File does not exist."
		exit 1
	fi

	while IFS= read -r -n1 char; do
		santaformula $char
	done < $INPUT

fi

echo "Santa's instructions took him to floor $finalfloor."

if [ -n "$basementmove" ]; then
	echo "He first entered the basement on move $basementmove."
fi

exit 0
