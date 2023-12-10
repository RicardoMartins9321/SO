#!/bin/bash

# Function to generate a random number within a range
random_number() {
  local min=$1
  local max=$2
  echo $((RANDOM % (max - min + 1) + min))
}

# List of common file extensions
extensions=("txt" "pdf" "jpg" "doc" "mp3" "zip" "html" "png" "csv" "xls")

# Function to generate a random file with a random extension
generate_file() {
  local file_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9 ' | fold -w 10 | head -n 1)
  local extension=${extensions[$(random_number 0 9)]}
  local file_size=$(random_number 1 1024)  # Random file size in bytes

  dd if=/dev/zero of="$file_name.$extension" bs="$file_size" count=1 2>/dev/null

  echo "$file_name.$extension"
}

# Function to generate a random folder structure
generate_folders() {
  local num_folders=$(random_number 1 5)
  local num_files=$(random_number 1 50)

  local depth=$1  # Pass depth as an argument

  if [ "$depth" -eq 0 ]; then
    return  # Stop creating subfolders when depth reaches 0
  fi

  for ((i=1; i<=num_folders; i++)); do
    local folder_name="Folder$i"
    mkdir -p "$folder_name"  # Use -p to create parent directories if they don't exist
    cd "$folder_name"

    for ((j=1; j<=num_files; j++)); do
      local file_name=$(generate_file)
      touch "$file_name"
    done

    if [ $((RANDOM % 2)) -eq 0 ]; then
      # Recursively call the function to create subfolders
      generate_folders  "$((depth - 1))"  # Pass updated depth for recursive call
    fi

    cd ..
  done
}

# Set the maximum depth
max_depth=5

# Generate the folder structure with a maximum depth
generate_folders "$max_depth"

mkdir "emptyDirectory"    # create an empty directory
mkdir "tesdte!@#$%^&*()"  # create a directory with special characters
cd "tesdte!@#$%^&*()"   
echo "This is file 1 content." > file1.txt
echo "Content of file 2." > file2.txt
echo "Text for file 3." > file3.txt
cd ..                   # go back to the parent directory
mkdir "Debug Files"    # create a directory with spaces
cd "Debug Files"
echo "This is file 1 content." > file1.txt
echo "Content of file 2." > file2.txt
echo "Text for file 3." > file3.txt

# cd ..
# mkdir unreadable_folder
# chmod 000 unreadable_folder
# code to create an unreadable folder is commented out because using it may lead to permission errors