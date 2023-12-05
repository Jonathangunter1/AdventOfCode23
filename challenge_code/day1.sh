#!/bin/bash

source ../helpers/helper_functions.sh

get_input 1

function part1 {
  # Total count
  num_total=0
  # Loop through each line in the file
  while IFS= read -r line; do
    # Get only the numbers
    numbers=$(echo "$line" | sed 's/[^0-9]*//g')
    # Get the first and last numbers
    first_number="${numbers:0:1}"
    last_number="${numbers: -1}"
    # Add them to the running total
    num_total=$((num_total + $first_number$last_number))
  done <<< "$INPUT"
  #Print total
  echo "$num_total"
}

#part1

function part2 {

  declare -A numbers=(
    ["one"]=1
    ["two"]=2
    ["three"]=3
    ["four"]=4
    ["five"]=5
    ["six"]=6
    ["seven"]=7
    ["eight"]=8
    ["nine"]=9
  )

  while IFS= read -r line; do
    tmp_word=""
    for ((i=0; i<${#line}; i++)); do
      tmp_word+=${line:i:1}
      for number_str in "${!numbers[@]}"; do
        if [[ $tmp_word == *"$number_str"* ]]; then
          # Replaces the number string (minus the last letter) with the number.
          # The last letter stays because letters do not matter in this case,
          # and the letter may be part of another number.
          tmp_word=${tmp_word//${number_str%?}/${numbers[$number_str]}}
        fi
      done
    done

    ################### FROM PART 1 ###################
    # Get only the numbers
    the_numbers=$(echo "$tmp_word" | sed 's/[^0-9]*//g')
    # Get the first and last numbers
    first_number="${the_numbers:0:1}"
    last_number="${the_numbers: -1}"
    # Add them to the running total
    num_total=$((num_total + $first_number$last_number))
    ###################################################
  done <<< "$INPUT"
echo "$num_total"
}

part2