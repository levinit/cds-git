#!/bin/bash
# get a list of lockable file types for current repo
# then find all files in given directory matching the file types

LCVdir=$(realpath $1)
#cd ${LCVdir}
# get lockable files for this repo
lockable=$(git lfs track | grep lockable | awk '{print $1}')
find_cmd=()
for p in $lockable
do
	[ "$find_cmd" ] && find_cmd+=(-o)
	find_cmd+=(-name "$p")
done

find $LCVdir -type f \( "${find_cmd[@]}" \)