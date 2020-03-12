#!/bin/bash
#git lsf unlock all users' locked *.oa files underneath given directory

LVCdir=$(realpath $1)
#rootdir=$(realpath $2)
output=()
cd ${LVCdir}
files=$(find . -name '*.oa')

for f in $files
	do
		lockCount=0
		if [ -z "$(git lfs locks --path=${f})" ]
		then
			git lfs lock $f
		else
			echo "${f} already locked"
		fi
	done

