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

  convert_string() {
    # TODO This doesn't work because eightwothree becomes eigh23... not what we want
    input_string="$1"
    echo "$input_string" | sed 's/one/1/g; s/two/2/g; s/three/3/g; s/four/4/g; s/five/5/g; s/six/6/g; s/seven/7/g; s/eight/8/g; s/nine/9/g'
  }

  # Total count
  num_total=0

  # Loop through each line in the file
  while IFS= read -r line; do
    convert_string "$line"
    converted_string=$(convert_string "$line")
    echo "$converted_string"
    numbers=$(echo "$converted_string" | sed 's/[^0-9]*//g')
    first_number="${numbers:0:1}"
    last_number="${numbers: -1}"
    echo "$first_number$last_number"
    num_total=$((num_total + $first_number$last_number))
  done <<< "$INPUT"
  echo "$num_total"
}

part2