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

git clone https://github.com/jerrykuku/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config
git clone https://github.com/kenzok78/luci-app-adguardhome
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages && mvdir openwrt-passwall-packages
git clone --depth=1 -b main https://github.com/fw876/helloworld && mvdir helloworld
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall
git clone --depth 1 https://github.com/kenzok8/wall && mv -n wall/adguardhome wall/filebrowser ./ ; rm -rf wall
git clone --depth 1 https://github.com/Lienol/openwrt-package && mv -n openwrt-package/luci-app-filebrowser ./ ; rm -rf openwrt-package
svn export https://github.com/xiangfeidexiaohuo/extra-ipk/trunk/patch/wall-luci/luci-app-vssr ./luci-app-vssr
svn export https://github.com/xiangfeidexiaohuo/extra-ipk/trunk/patch/wall-luci/lua-maxminddb ./lua-maxminddb
git clone https://github.com/ophub/luci-app-amlogic amlogic && mv -n amlogic/luci-app-amlogic ./;rm -rf amlogic
git clone https://github.com/sbwml/luci-app-alist openwrt-alist && mv -n openwrt-alist/*alist ./ ; rm -rf openwrt-alist
svn export https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman ./luci-app-dockerman
svn export https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash ./luci-app-openclash
git clone https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/luci-app-linkease ./ ; rm -rf nas-packages-luci
git clone https://github.com/linkease/nas-packages && mv -n nas-packages/multimedia/ffmpeg-remux ./ ; rm -rf nas-packages
git clone https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/linkease ./ ; rm -rf nas-packages
wget -O ./long https://raw.githubusercontent.com/hkpc/openit/main/long

rm -rf ./*/.git & rm -rf ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore
