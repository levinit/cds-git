#!/bin/bash
#git lsf unlock all users' locked *.oa files underneath given directory

path=$(realpath $1)
if [ -f "$1" ]
then
	LCVdir=$(dirname ${path})
else
	LCVdir=${path}
fi
#rootdir=$(realpath $2)
output=()
cd ${LCVdir}
files=$(find . -name '*.oa')

for f in $files
	do
		if [ -n "$(git lfs locks --local --path=${f})" ]
		then
			#output+=( $(git lfs lock $f) )
			git lfs unlock $f
			#output+=( , )
		fi
	done
#echo -n ${output[@]}

