#!/bin/bash

verification(){
  if [[ ! (( -e $1 && -e $2 )) ]]; then
    echo "Error: Non existent file(s)"
  else
    IFS="." read -r temp fExt1 <<< "$1"  # Get the extension of the argument
    IFS="." read -r temp fExt2 <<< "$2"
    fType1=$(file -b $1)
    fType2=$(file -b $2)
    if [[ ! (( $fType1 == *"text"* && $fType2 == *"text"*  && $fExt1 == "" && $fExt2 == "" )) ]]; then # Files type verification (plain text, doesn't include files like random.sh)
      echo "Error: File(s) in the wrong type"
    else
      IFS="/" read -ra arg1 <<< "$1" # To function even when the script is called from a different "path" (example: SO/Projeto1/spacerate.sh instead of calling ./spacerate.sh)
      IFS="/" read -ra arg2 <<< "$2"
      i1=$((${#arg1[@]} - 1))
      i2=$((${#arg2[@]} - 1))
      IFS="_" read -r dir1 date1 <<< "${arg1[i1]}" # Get the directory name in the name of the file
      IFS="_" read -r dir2 date2 <<< "${arg2[i2]}"
      if [[ $dir1 != $dir2 ]]; then
        echo "Error: The directories are different"
      else
        echo "$dir1 $date1 $date2" # Output the directory and both dates
      fi
    fi
  fi
}



if [ $# -eq 2 ]; then # If the number of arguments is 2, then proceed to call the verification function and test $1 and $2 (the last 2 arguments have to be the files with the spacecheck output)
  output=$(verification "$1" "$2")
  f1=$1
  f2=$2
elif [[ (( $1 == "-r" || $1 == "-a" )) && $# -gt 2 && $# -lt 5 ]]; then # If the number of arguments is 3 and $1 is a "sort expression", then proceed to call the verification function and test $2 and $3
  mod=$1
  if [ $# -eq 3 ]; then
    output=$(verification "$2" "$3")
    f1=$2
    f2=$3
  elif [[ $# -eq 4 && (( $2 == "-r" || $2 == "-a" )) ]]; then # If the number of arguments is 3 and $1 and $2 are a "sort expression", then proceed to call the verification function and test $3 and $4
    output=$(verification "$3" "$4")
    f1=$3
    f2=$4
    mod2=$2S
  else
    echo "Error: Invalid type of arguments"
    exit 1
  fi
else
  echo "Error: Invalid number of arguments"
  exit 1
fi



read -r dir date1 date2 <<< "$output"
if [ "$dir" == "Error:" ]; then # If $output is an error message, then exit
  echo $output 
  exit 1
fi



declare -A list1 list2 fArray newList removedList flags
fLine1=() # Holds the first line of the file
fLine2=()
args1=()
args2=()
flags["-r"]=0 # Counts how many times does a flag appear in both files
flags["-a"]=0
flags["-l"]=0
flags["-s"]=0
flags["-n"]=0
flags["-d"]=0
n=0 # Helps to save the conditions atatched to the flags (like "-s 123")
i=0 # Helps to separate the first and the rest of the lines
while IFS=$'\t' read -r line; do # Reads both files at the same time line by line
  if [ $i != 0 ]; then # Checks if it isn't the first line
    read -r p1 p2 <<< "$line" # Splits a line in 2, $p1 is the size and $p2 the directory name
    if [[ $p1 != "" && $p2 != "" ]]; then
      list1["$p2"]=$p1
    fi
 
  else # If read line is the first
    for s in $line; do
      fLine1+=("$s") # Save the contents of it in a list
      if [[ $s == "-r" || $s == "-a" || $s == "-l" || $s == "-s" || $s == "-n" || $s == "-d" ]]; then 
        flags["$s"]+=1 # Adds 1 to the correspondent flag counter
        n=$((n+1))
      else
        args1[$n]+="$s"
      fi
    done
    
    lastIndex1=$((${#fLine1[@]} - 1)) # Gets the index of the last item of the first line
    dir1=${fLine1[$lastIndex1]} # Gets the directory name in the first line
    
    if [[ ${fLine1[0]} != "SIZE" || ${fLine1[1]} != "NAME" || ${fLine1[2]} != "$date1" || "$dir" != "$dir1" ]]; then # Check if the first line corresponds to a spacecheck output, if the correspondent dates and directory name are the same as the ones in the name of the files
      echo "Error: File(s) is(are) not a spacecheck.sh output"
      exit 1
    fi
    
  fi
  i=$((i+1)) # Line counting
done < <(paste "$f1")


n=0
i=0 # Help to separate the first and the rest of the lines
while IFS=$'\t' read -r line; do # Reads both files at the same time line by line
  if [ $i != 0 ]; then # Checks if it isn't the first line
    read -r p1 p2 <<< "$line" # Splits a line in 2, $p1 is the size and $p2 the directory name
    if [[ $p1 != "" && $p2 != "" ]]; then
      list2["$p2"]=$p1
    fi
 
  else # If read line is the first
    for s in $line; do
      fLine2+=("$s") # Save the contents of it in a list
      if [[ $s == "-r" || $s == "-a" || $s == "-l" || $s == "-s" || $s == "-n" || $s == "-d" ]]; then 
        flags["$s"]+=1 # Adds 1 to the correspondent flag counter
        n=$((n+1))
      else
        args2[$n]+="$s"
      fi
    done
    
    lastIndex2=$((${#fLine2[@]} - 1)) # Gets the index of the last item of the first line
    dir2=${fLine2[$lastIndex2]} # Gets the directory name in the first line
    
    if [[ ${fLine2[0]} != "SIZE" || ${fLine2[1]} != "NAME" || ${fLine2[2]} != "$date2" || "$dir" != "$dir2" ]]; then # Check if the first line corresponds to a spacecheck output, if the correspondent dates and directory name are the same as the ones in the name of the files
      echo "Error: File(s) is(are) not a spacecheck.sh output"
      exit 1
    fi
    
  fi
  i=$((i+1)) # Line counting
done < <(paste "$f2")



if [[ ${flags["-d"]} -eq 1 || ${flags["-s"]} -eq 1 || ${flags["-n"]} -eq 1 || ${flags["-l"]} -gt 0 ]]; then # If only one is sorted by these flags, then it's meaningless to compare the files
  echo "Error: Different selection/conditional flags" 
  exit 1
fi
args1=("${args1[@]:1}") # Remove the first argument
args2=("${args2[@]:1}")
args1li=$((${#args1[@]} - 1)) # Gets the index of the last item of the list
args2li=$((${#args2[@]} - 1))
args1[$args1li]=${args1[$args1li]/"$dir1"/} # Remove the directory name in the last item
args2[$args2li]=${args2[$args2li]/"$dir2"/}
    
# Checks if the condition of the flags are equal in both files
for arg in "${args1[@]}" "${args2[@]}"; do
  if [[ ! "${args1[@]}" =~ "$arg" || ! "${args2[@]}" =~ "$arg" ]]; then
    echo "Error: Different flag(s) condition(s)"
    exit 1 
  fi
done




if [[ ! -n $mod ]]; then # If $mod doesn't exist (it wasn't given as an argument, which has priority over the sort flags inside the files) use the flags in the first line of the file
  if [[ ${flags["-r"]} != 0 ]]; then
    mod="-r"
  fi
  if [[ ${flags["-a"]} != 0 ]]; then
    mod2="-a"
  fi
fi



# Checks and adds to an array equal elements of both lists
for dir in "${!list1[@]}" "${!list2[@]}"; do
  if [[ -n "${list1[$dir]}" && -n "${list2[$dir]}" ]]; then
    dif=$((list1["$dir"] - list2["$dir"]))
    fArray["$dir"]=$dif
    
  # NEW directories
  elif [ -n "${list1[$dir]}" ]; then
    dif=$((list1["$dir"]))
    fArray["$dir"]=$dif
    newList["$dir"]="1" # Adds to a list the new directories
    
  # REMOVED directories
  elif [ -n "${list2[$dir]}" ]; then
    dif=$((0 - list2["$dir"]))
    fArray["$dir"]=$dif
    removedList["$dir"]="1" # Adds to a list the removed directories
  fi
done



sortedKeys=()
  for key in "${!fArray[@]}"; do
    sortedKeys+=("$key")
  done
if [[ $mod == "-a" || $mod2 == "-a" ]]; then # Uses $m to sort, which in this case, to reverse we have to have "nothing" and to sort normally we have to put "r"
  m=""
  if [[ $mod == "-r" || $mod2 == "-r" ]]; then
    m="r"
  fi

  # Sort the sortedKeys array based on the names of dir
  sortedKeys=($(for key in "${sortedKeys[@]}"; do
    echo "$key"
  done | sort -"$m"n)) # Sort by the names of the directories

  # Print the sorted keys and their corresponding values
  echo "SIZE NAME"
  for dir in "${sortedKeys[@]}"; do
    dif=${fArray[$dir]}
    if [ -n "${newList[$dir]}" ]; then
      dir="$dir NEW" # If exists in the newList, then it's a new directory
    fi
    if [ -n "${removedList[$dir]}" ]; then
      dir="$dir REMOVED" # If exists in the removedList, then it's a directory that was removed
    fi
    echo "$dif $dir"
  done

else
  m="r"
  if [[ $mod == "-r" || $mod2 == "-r" ]]; then
    m=""
  fi
  
  # Sort the sortedKeys array based on the values in fArray
  sortedKeys=($(for key in "${sortedKeys[@]}"; do
    echo "${fArray[$key]} $key"
  done | sort -"$m"n | cut -d' ' -f2)) # Sort by the size difference of the directories
  
  echo "SIZE NAME"
  for dir in "${sortedKeys[@]}"; do
    dif=${fArray[$dir]}
    if [ -n "${newList[$dir]}" ]; then
      dir="$dir NEW"
    fi
    if [ -n "${removedList[$dir]}" ]; then
      dir="$dir REMOVED"
    fi
    echo "$dif $dir"
  done
fi
