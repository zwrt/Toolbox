#!/bin/bash

shopt -s extglob
rm -rfv !(LICENSE|README.md|packages.sh)
shopt -u extglob

function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

git clone --depth 1 https://github.com/kenzok8/small-package && \
cd small-package && \
mv -n luci-app-adguardhome \
      luci-app-argon-config \
      luci-app-homeproxy \
      luci-app-linkease \
      luci-app-nikki \
      luci-app-openclash \
      luci-app-passwall \
      luci-app-quickstart \
      luci-app-ssr-plus \
      luci-app-store ../ && \
cd .. && \
rm -rf small-package

rm -rf ./*/.git & rm -rf ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore
