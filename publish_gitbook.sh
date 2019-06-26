#!/bin/bash
# 执行前 先手动把md-source的更新push到GitHub上去
# 后期在完善脚本 判断是否有更新 自动push到md-source分支上
#git checkout md-source
#git pull origin md-source
cd doc/book

gitbook install
# install the plugins and build the static site
gitbook build

cd ../..

# checkout to the gh-pages branch
# git stash
git checkout master

# pull the latest updates
git pull origin master


if [[ "$?" != "0" ]]; then
    exit 1
fi
# copy the static site files into the current directory.
/usr/bin/cp -rf doc/book/_book/* .

# add all files
git add --all

# commit
git commit -a -m "Update docs"

# push to the origin
git push origin master

# checkout to the master branch
git checkout md-source
