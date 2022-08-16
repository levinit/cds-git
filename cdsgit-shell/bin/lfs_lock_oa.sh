#!/bin/bash

p=$(realpath $1)
#if path is a file then return the parent directory
if [ -f "$1" ]
then
	LCVdir=$(dirname ${p})
else
	LCVdir=${p}
fi

cd ${LCVdir}
# get locakable files for this repo
files=$(/bin/bash $CDSGIT_PATH/cdsgit-shell/bin/find_lockable.sh "$LCVdir")
#echo "Files: ${files}"
if git lfs --version | grep -q "^git-lfs/3\.[0-9]\.[0-9]"
then
	# With git-lfs v3.0.0 and higher we can lock multiple files as a batch
	#echo "git-lfs v3 or higher detected"
	dirs=$(dirname ${files})
	git lfs lock ${files} && git fetch && git checkout origin/master -- $dirs
else
	for f in $files
	do
		if [ -z "$(git lfs locks --path=${f})" ]
		then
			#checkout latest before we lock the file
			git lfs lock ${f} && git fetch && git checkout origin/master -- $(dirname ${f})
			echo "Locking file ${f}"
		else
			echo "${f} already locked"
		fi
	done
fi

