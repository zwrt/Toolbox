#!/bin/bash
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
mv -n nikki \
      taskd \
      linkease \
      linkmount \
      quickstart \
      luci-lib-taskd \
      luci-app-nikki \
      luci-app-store \
      luci-lib-xterm \
      luci-app-quickstart \
      luci-app-linkease ../ && \
cd .. && \
rm -rf small-package

rm -rf ./*/.git & rm -rf ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore
wget -O ./hosts https://raw.githubusercontent.com/zwrt/hosts/refs/heads/main/hosts
wget -O ./IPTV.m3u https://raw.githubusercontent.com/zwrt/IPTV/refs/heads/Files/IPTV.m3u
