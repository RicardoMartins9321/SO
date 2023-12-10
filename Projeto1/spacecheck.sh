#!/bin/bash

# Initialize variables for the options
regex=".*"
limit=999999
min_size=0
max_date=$(date "+%b %d %H:%M")
sort_flag="-nr" # default value, sorts by sizes in descending order
filters=""

# Function to display usage information
usage() {
  echo "Usage: $0 [-n <regex>] [-d <date>] [-s <size>] [-r] [-a] [-l <limit>] [<directory1> <directory2> ...]"
  echo "  -n <regex>   Filter files by name using a regular expression"
  echo "  -d <date>    Filter files by modification date (e.g., 'Sep 10 10:00')"
  echo "  -s <size>    Filter files by minimum size in bytes"
  echo "  -r           Sort output in reverse order"
  echo "  -a           Sort output by name (default is by size)"
  echo "  -l <limit>   Limit the number of lines in the output"
  echo "  <directory>  Directories to check"
  exit 1
}

# Function to calculate directory size and print the result
calculate_directory_size() {
  local directory="$1"
  local total_size=0

  # Calculate the total size of files in the directory
  total_size=$(find "$directory" -type f -not -newermt "$max_date" -size +"$min_size"c -regex "$regex" -exec stat -c %s {} \; 2>/dev/null | awk '{s+=$1} END {print s}')
  
  # If the directory is not readable set the total size to NA
  if [ ! -r "$directory" ]; then
    total_size="NA"
  fi
  
  # If the total size couldn't be determined, set it to 0
  if [ -z "$total_size" ]; then
    total_size=0
  fi
  
  printf "%-10s %-10s\n" "$total_size" "$directory"
}

# Process the arguments, by performing a diferent thing for each case
# The : after l:s: indicates that the -l and -s options require an argument.
# Both the 'r' and 'a' option do not require an argument, so it is handled separately.
while getopts ":n:d:s:l:ra" opt; do
  # error catching if repeated options are given
  if [[ " ${options[@]} " =~ " $opt " ]]; then
    echo "Error: Option -$opt has been repeated too many times." >&2
    printf "\n"
    usage
  fi
  case $opt in
    n)
      regex="$OPTARG" # OPTARG is the argument passed to the $opt
      if [[ ! "$OPTARG" =~ \.\* ]]; then
      echo "Error: The regular expression must be in the '.*extension' format."
      usage
      fi
      filters+="-n $OPTARG "
      ;;
    d)
      max_date="$OPTARG"
      correct_date="^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) (0[1-9]|[12][0-9]|3[01]) (([01][0-9]|2[0-3]):[0-5][0-9])$"

      if ! [[ $max_date =~ $correct_date ]]; then   
        echo "Error: Invalid date format. Please use a valid format, e.g., 'Sep 10 10:00'\n"
        usage
      fi
      filters+="-d "$OPTARG" "
      ;;
    s)
      # Use a regular expression to check if the provided value is a valid positive integer
      if ! [[ "$OPTARG" =~ ^[0-9]+$ ]] || [ "$OPTARG" -le 0 ]; then
        echo "Error: The -s value must be a positive integer."
        usage
      else
        min_size="$OPTARG"  # min size needed to count
      fi
      filters+="-s $OPTARG "
      ;;
    r)
      if [ "$sort_flag" == "-nr" ]; then
        sort_flag="-n"  # sorts by sizes in ascending order
      else
        sort_flag="-rk2"
      fi
      filters+="-r "
      ;;
    a)
      if [ "$sort_flag" == "-nr" ]; then
        sort_flag="-k2"  # sorts by names in the second column in descending order
      else
        sort_flag="-rk2"
      fi
      filters+="-a "
      ;;
    l)
      # Use a regular expression to check if the provided value is a valid positive integer
      if ! [[ "$OPTARG" =~ ^[0-9]+$ ]] || [ "$OPTARG" -le 0 ]; then
        echo "Error: The -l value must be a positive integer."
        usage
      else
        limit=$OPTARG # set the limit of lines
      fi
      filters+="-l $OPTARG "
      ;;
    \?)
      echo "Invalid Option: -$OPTARG" >&2
      usage
      ;;
    :)
      echo "Option -$OPTARG requires at least one argument." >&2
      usage
      ;;
  esac

  options+=("$opt")
done

# Shift to process remaining arguments (directories)
shift $((OPTIND-1))

if [ $# -eq 0 ]; then
  echo "Error: No directories were provided."
  printf "\n"
  usage
fi

for dir in "$@"; do 
  if [ ! -d "$dir" ]; then
    echo "Error: The argument: $dir is not a directory"
    printf "\n"
    usage
  fi
done

# Loop through directories and their subdirectories
for dir in "$@"; do
  output_file="${dir}_$(date "+%Y%m%d")"

  # Print the header line to the file and the terminal
  printf "%s %s $(date "+%Y%m%d") %s %s\n" "SIZE" "NAME" "$filters" "$dir" | tee "$output_file"
  
  # Calculate the sizes of subdirectories and print the result
  while IFS= read -r -d $'\0' subdirectory; do
      calculate_directory_size "$subdirectory"
  done < <(find "$dir" -type d -print0 2>/dev/null) | sort $sort_flag | head -n $limit | tee -a "$output_file"
  printf "\n"

done 
