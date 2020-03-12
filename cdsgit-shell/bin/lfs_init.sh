#!/bin/bash
#setup a repo for using LFS locks

repodir=$(realpath $1)
cd $repodir

git ls-files --error-unmatch $file &> /dev/null

if [ $? -eq 0 ]
then
	#install lfs for user in this repo only
	#git checkout is needed to trigger lockable files to be read-only
	git lfs install --local && git checkout .
	#solve x509: certificate signed by unknown authority error:
	git config http.sslverify false
	#check locks before push:
	git config lfs.https://dev-gitlab.cryptoquantique.com/rbennell/GIT_TEST.git/info/lfs.locksverify true
	#ensure locked files are read-only
	git config lfs.setlockablereadonly true
else
	echo "Not a git repo!"
fi