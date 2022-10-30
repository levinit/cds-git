#!/bin/bash

p=$(realpath $1)
shift
lockable="$@"

#if path is a file then return the parent directory
if [ -f "$1" ]
then
	LCVdir=$(dirname ${p})
else
	LCVdir=${p}
fi

cd ${LCVdir}

# build a find command using the lockable file types
find_cmd=()
for p in $lockable
do
	[ "$find_cmd" ] && find_cmd+=(-o)
	find_cmd+=(-name "$p")
done

# find files to be locked under the given dir
files=$(find $LCVdir -type f \( "${find_cmd[@]}" \))

#echo "Files: ${files}"
if [ -z "$files" ]
then
    echo "Nothing to lock in path $LCVdir"
else
    if git lfs --version | grep -q "^git-lfs/3\.[0-9]\.[0-9]"
    then
	# With git-lfs v3.0.0 and higher we can lock multiple files as a batch
		git lfs lock $files
    else
		for f in $files
		do
			git lfs lock $f
		done
    fi
fi

