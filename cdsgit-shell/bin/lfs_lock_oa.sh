#!/bin/bash
#git lsf unlock all users' locked *.oa files underneath given directory

LCVdir=$(realpath $1)
#rootdir=$(realpath $2)
output=()
cd ${LCVdir}
files=$(find . -name '*.oa')

for f in $files
	do
		if [ -z "$(git lfs locks --path=${f})" ]
		then
			#checkout latest before we lock the file
			git lfs lock ${f} && git fetch && git checkout origin/master -- $(dirname ${f})
		else
			echo "${f} already locked"
		fi
	done

