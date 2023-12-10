#!/bin/bash

echo "Test Case 1: Basic usage with default options"
./spacecheck.sh Folder1 "Debug Files"
echo ""

echo "Test Case 2: Filtering by name and sorting by name in descending order"
./spacecheck.sh -n ".*txt" -a Folder1
echo ""

echo "Test Case 3: Filtering by size, sorting by size in descending order"
./spacecheck.sh -s 1000 Folder1 "Debug Files"
echo ""

echo "Test Case 4: Filtering by size while sorting by size in ascending order"
./spacecheck.sh -s 512 -r Folder1
echo ""

echo "Test Case 5: Limiting the number of lines in the output"
./spacecheck.sh -l 5 Folder1
echo ""

echo "Test Case 6: Invalid options"
./spacecheck.sh -x Folder1
echo ""

echo "Test Case 7: Inaccessible directory"
./spacecheck.sh unreadable_folder
echo ""

echo "Test Case 8: Combining filters for extension and date while sorting by size in reverse"
./spacecheck.sh -n ".*txt" -d "Nov 12 10:00" -r Folder1 "Debug Files"
echo ""

echo "Test Case 9: Filter by name, date, and size, sort by size in ascending order, limit output"
./spacecheck.sh -n ".*txt" -d "Nov 12 10:00" -s 512 -r -l 3 Folder1

echo "Test Case 10: Filter by name, sort by name in descending order, and include multiple directories"
./spacecheck.sh -n ".*xls" -a Folder1 "Debug Files"
echo ""

echo "Test Case 11: Filter by size, include a directory with spaces in its name"
./spacecheck.sh -s 248 "Debug Files"
echo ""

echo "Test Case 12: Include a directory with special characters in its name"
./spacecheck.sh "tesdte!@#$%^&*()"
echo ""

echo "Test Case 13: Invalid date format"
./spacecheck.sh -d "10 Sep 10:00" Folder1
echo ""

echo "Test Case 14: Sorting by name in ascending order"
./spacecheck.sh -a -r Folder1
echo ""

echo "Test Case 15: No directories provided"
./spacecheck.sh -n ".*txt" -a
echo ""

echo "Test Case 16: Non-existent directories"
./spacecheck.sh nonExistentFolder
echo ""

echo "Test Case 17: Mixed filters and sorting, limit to 1 line of output"
./spacecheck.sh -n ".*jpg" -s 512 -r -l 10 Folder1
echo ""

echo "Test Case 18: Empty directory"
./spacecheck.sh emptyDirectory
echo ""

echo "Test case 19: Repeated commands"
./spacecheck.sh -n ".*txt" -l 5 -l Folder1 10 
echo ""

