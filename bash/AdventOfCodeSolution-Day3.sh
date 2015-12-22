#!/usr/bin/env bash

function present_tally {

   case $1 in
      ">")
         position[1]=$(( ${position[1]} + 1 ))
         ;;
      "<")
         position[1]=$(( ${position[1]} - 1 ))
         ;;
      "^")
         position[0]=$(( ${position[0]} + 1 ))
         ;;
      "v")
         position[0]=$(( ${position[0]} - 1 ))
         ;;
      *)
         break
         ;;
   esac

   house="${position[0]},${position[1]}"
   printf "%s " "$house"
 
   if [ "$(grep -c -e "$house" houselist)" -eq 0 ]; then
      houses=$(( $houses + 1 ))
      printf "$houses"
      printf "%s\n" "$house" >> houselist
   fi

   printf "\n"

}

counter=0
houses=1
position=(0 0)
house="${position[0]},${position[1]}"
printf "$counter . $house $houses\n"
printf "%s\n" "$house" >> houselist

if [ $# != 0 ]; then
   while IFS= read -r -n1 char; do
      counter=$(( $counter + 1 ))
      printf "$counter $char "
      present_tally "$char"
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
      counter=$(( $counter + 1 ))
      printf "$counter $char "
      present_tally "$char"
	done < $INPUT

fi

rm houselist
echo -e "\n$houses houses receive at least one present from Santa."
exit 0
