#!/bin/bash
#git lsf unlock all users' locked *.oa  and *.sdb files underneath given directory

path=$(realpath $1)

#if path is a file then return the parent directory
if [ -f "$1" ]
then
	LCVdir=$(dirname ${path})
else
	LCVdir=${path}
fi

cd ${LCVdir}
#get repo root
rootstr=$(git rev-parse --show-toplevel)

#find all the oa and sdb files under the given directory
files=$(find ${path} -type f \( -name '*.oa' -o -name '*.sdb' \))
#get paths of user's own locks for current repo
locks=$(git lfs locks --verify | grep "^O" | awk '{ print $2 }')

cd ${rootstr}
for lf in $locks
   do
      #check if this locked file is one in our list of potential files to unlock
      if [[ "$files" == *"$lf"* ]]
      then
         if [ -n "$(git diff HEAD ${lf})" ] 
         then
            echo "Can't unlock ${lf} : file is locally modified"
         else
            #not locally modified so we can unlock it
            #echo "${lf} will be unlocked!";
            git lfs unlock ${lf}
         fi
      fi
   done


