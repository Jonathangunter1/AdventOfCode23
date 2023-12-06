#!/bin/bash

source ../helpers/helper_functions.sh

get_input 2

function part1 {

  running_total_of_possible_games=0

  while IFS= read -r line; do
    game_id=$(echo "$line" | awk '{ print $2 }' | sed 's/://')
    max_num_blue_cubes=0
    max_num_green_cubes=0
    max_num_red_cubes=0
    impossible=0
    echo "Game ID : $game_id"

    # Set the IFS to semicolon
    IFS=';'

    # Use the read command to split the string into an array
    read -ra sets <<< "$line"

    for set in "${sets[@]}"; do
      num_blue_cubes=0
      num_green_cubes=0
      num_red_cubes=0
      set=$(echo "$set" | sed "s/^Game $game_id://")

      IFS=','
      read -ra colors <<< "$set"
      # Get the number of each color for each run
      for color in "${colors[@]}"; do
        if [[ $color == *red* ]]; then
            num_red_cubes=$(echo "${color//'red'/}" | tr -d ' ')
        elif [[ $color == *blue* ]]; then
            num_blue_cubes=$(echo "${color//'blue'/}" | tr -d ' ')
        elif [[ $color == *green* ]]; then
            num_green_cubes=$(echo "${color//'green'/}" | tr -d ' ')
        fi
      done
      
      # Get the max numbers 
      if [ "$num_blue_cubes" -gt "$max_num_blue_cubes" ]; then
          max_num_blue_cubes="$num_blue_cubes"
      fi
      if [ "$num_green_cubes" -gt "$max_num_green_cubes" ]; then
          max_num_green_cubes="$num_green_cubes"
      fi
      if [ "$num_red_cubes" -gt "$max_num_red_cubes" ]; then
          max_num_red_cubes="$num_red_cubes"
      fi
    done

    if [ "$max_num_blue_cubes" -gt "14" ]; then
      impossible=1
    fi
    if [ "$max_num_green_cubes" -gt "13" ]; then
      impossible=1
    fi
    if [ "$max_num_red_cubes" -gt "12" ]; then
      impossible=1
    fi

    if [ "$impossible" -eq 0 ]; then
        running_total_of_possible_games=$((running_total_of_possible_games + game_id))
    fi
    echo "TOTAL : $running_total_of_possible_games"

  done <<< "$INPUT"

  echo $running_total_of_possible_games
}

#part1

function part2 {

  running_total_of_power=0

  while IFS= read -r line; do
    game_id=$(echo "$line" | awk '{ print $2 }' | sed 's/://')
    max_num_blue_cubes=0
    max_num_green_cubes=0
    max_num_red_cubes=0
    impossible=0
    echo "Game ID : $game_id"

    # Set the IFS to semicolon
    IFS=';'

    # Use the read command to split the string into an array
    read -ra sets <<< "$line"

    # Print each set

    for set in "${sets[@]}"; do
      num_blue_cubes=0
      num_green_cubes=0
      num_red_cubes=0
      set=$(echo "$set" | sed "s/^Game $game_id://")

      IFS=','
      read -ra colors <<< "$set"
      # Get the number of each color for each run
      for color in "${colors[@]}"; do
        if [[ $color == *red* ]]; then
            num_red_cubes=$(echo "${color//'red'/}" | tr -d ' ')
        elif [[ $color == *blue* ]]; then
            num_blue_cubes=$(echo "${color//'blue'/}" | tr -d ' ')
        elif [[ $color == *green* ]]; then
            num_green_cubes=$(echo "${color//'green'/}" | tr -d ' ')
        fi
      done

      # Get the max numbers
      if [ "$num_blue_cubes" -gt "$max_num_blue_cubes" ]; then
          max_num_blue_cubes="$num_blue_cubes"
      fi
      if [ "$num_green_cubes" -gt "$max_num_green_cubes" ]; then
          max_num_green_cubes="$num_green_cubes"
      fi
      if [ "$num_red_cubes" -gt "$max_num_red_cubes" ]; then
          max_num_red_cubes="$num_red_cubes"
      fi

    done

    game_power=$((max_num_green_cubes * max_num_blue_cubes * max_num_red_cubes))
    running_total_of_power=$((running_total_of_power + game_power))

    echo "TOTAL : $running_total_of_power"

  done <<< "$INPUT"

  echo $running_total_of_power
}

part2
