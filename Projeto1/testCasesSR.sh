#!/bin/bash

echo "Test case 1: Normal running"
./spacerate.sh Folder1_20231113 Folder1_20231112
echo
./spacerate.sh -r Folder1_20231113 Folder1_20231112
echo
./spacerate.sh -a Folder1_20231113 Folder1_20231112
echo
./spacerate.sh -a -r Folder1_20231113 Folder1_20231112
echo
./spacerate.sh -a -r Folder1_20231113 Folder1_20231113
echo

echo "Test case 2: Invalid number of arguments"
./spacerate.sh SO_20231106
./spacerate.sh -r -a -r SO_20231106 SO_20210101
echo

echo "Test case 3: File(s) in the wrong type"
./spacerate.sh SO_20231106 spacecheck.sh
./spacerate.sh SO_20231106 testFolder
echo

echo "Test case 4: Invalid type of arguments"
./spacerate.sh -r a SO_20231106 SO_20210101
echo

echo "Test case 5: Non existent file(s)"
./spacerate.sh SO_20231106 SO_2021
./spacerate.sh -r -a SO_20231106 SO_2021
./spacerate.sh -a asnkdga SO_2021
echo

echo "Test case 6: Different directories"
./spacerate.sh SO_20231106 S_20210101
./spacerate.sh SO_20231106 testFolder_20231111
echo

echo "Test case 7: File(s) is(are) not a spacecheck.sh output"
./spacerate.sh S_20231106 S_20210101
./spacerate.sh SO_20231106 SO_1
echo

echo "Test case 8: Different selection/conditional flags"
./spacerate.sh SO_20231106 SO_20200101
echo

echo "Test case 9: Different flag(s) condition(s)"
./spacerate.sh -a -r testFolder_20231111 testFolder_20231110
echo
