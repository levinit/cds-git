#!/bin/bash
#git lsf unlock all users' locked *.oa files underneath given directory

path=$(realpath $1)
if [ -f "$1" ]
then
	LCVdir=$(dirname ${path})
else
	LCVdir=${path}
fi

cd ${LCVdir}
#add .sdb files for maestro views
files=$(find . -type f \( -name '*.oa' -o -name '*.sdb' \))

for f in $files
	do
		#check we have it locked AND file is not locally modified
		if [ -n "$(git lfs locks --local --path=${f})" ]
		then
			if [ -z "$(git fetch; git diff --stat origin/master | grep ${f})" ]
			then
				git lfs unlock ${f}
			else
				echo "Can't unlock ${f} : file is locally modified"
			fi
		fi
	done


