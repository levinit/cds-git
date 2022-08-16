#!/bin/bash

#get repo root
rootstr=$(git rev-parse --show-toplevel)
cd ${rootstr}
if [ "$1" = "-f" ]
then
	force="TRUE"
	shift
fi

locks="$@"

files_to_unlock=()

for lf in $locks
do
   diffresult=$(git diff HEAD -- ${lf})
   if [[ -n "${diffresult}" ]] 
   then
      echo "Can't unlock ${lf} : file is locally modified"
   else
      files_to_unlock+="$lf "
   fi   
done

if [[ ! -z "$files_to_unlock" ]]
then
   #if using newer git-lfs we can unlock files as a batch
   if git lfs --version | grep -q "^git-lfs/3\.[0-9]\.[0-9]"
   then
    	if [[ "${force}" = "TRUE" ]]
      	then
			git lfs unlock --force ${files_to_unlock}
		else
			git lfs unlock ${files_to_unlock}
		fi
   else
   #for older git-lfs we need to unlock each file individually
      for f in $files_to_unlock
      do
        if [[ "${force}" = "TRUE" ]]
      	then
        	git lfs unlock --force ${f}
        else
        	git lfs unlock ${f}
        fi
      done
   fi
fi

