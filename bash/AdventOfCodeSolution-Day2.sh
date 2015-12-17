#!/usr/bin/env bash

function papercalc {
	
	l=$(echo $1 | cut -dx -f1)
	w=$(echo $1 | cut -dx -f2)
	h=$(echo $1 | cut -dx -f3)
	
	sidearea1=$(( $l * $w ))
	sidearea2=$(( $w * $h ))
	sidearea3=$(( $h * $l ))

	# area of right rectangular prism
	present=$(( 2 * $sidearea1 + 2 * $sidearea2 + 2 * $sidearea3 ))
	# area of smallest side
	slack=$(echo -e "$sidearea1\n$sidearea2\n$sidearea3" | sort -g | head -n1)

	totalpaper=$(( $totalpaper + $present + $slack ))

}

function ribboncalc {

	sideperimiter1=$(( 2 * $w + 2 * $l ))
	sideperimiter2=$(( 2 * $w + 2 * $h ))
	sideperimiter3=$(( 2 * $l + 2 * $h ))

	# perimiter of smallest side
	ribbon=$(echo -e "$sideperimiter1\n$sideperimiter2\n$sideperimiter3" | sort -g | head -n1)
	# cubic volume
	bow=$(( $l * $w * $h ))

	totalribbon=$(( $totalribbon + $ribbon + $bow ))

}

if [ $# != 0 ]; then

	papercalc $1
	ribboncalc $1

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

	while read line; do
		papercalc $line
		ribboncalc $line
	done < $INPUT

fi

echo "The elves need $totalpaper feet² of wrapping paper and $totalribbon feet of ribbon."
exit 0
