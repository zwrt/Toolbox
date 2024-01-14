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

git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/kenzok78/luci-app-adguardhome
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages && mvdir openwrt-passwall-packages
git clone --depth=1 -b main https://github.com/fw876/helloworld && mvdir helloworld
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall && mv -n openwrt-passwall/luci-app-passwall ./ ; rm -rf openwrt-passwall
git clone --depth 1 https://github.com/kenzok8/wall && mv -n wall/adguardhome wall/filebrowser ./ ; rm -rf wall
git clone --depth 1 https://github.com/Lienol/openwrt-package && mv -n openwrt-package/luci-app-filebrowser ./ ; rm -rf openwrt-package
git clone --depth 1 https://github.com/xiangfeidexiaohuo/extra-ipk && mv -n extra-ipk/patch/wall-luci/luci-app-vssr ./ ; rm -rf extra-ipk
git clone --depth 1 https://github.com/xiangfeidexiaohuo/extra-ipk && mv -n extra-ipk/patch/wall-luci/lua-maxminddb ./ ; rm -rf extra-ipk
git clone --depth 1 https://github.com/ophub/luci-app-amlogic amlogic && mv -n amlogic/luci-app-amlogic ./;rm -rf amlogic
git clone --depth 1 https://github.com/sbwml/luci-app-alist openwrt-alist && mv -n openwrt-alist/*alist ./ ; rm -rf openwrt-alist
git clone --depth 1 https://github.com/lisaac/luci-app-dockerman && mv -n luci-app-dockerman/applications/luci-app-dockerman ./ ; rm -rf luci-app-dockerman
git clone --depth 1 -b dev https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./ ; rm -rf OpenClash
git clone --depth 1 https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/luci-app-linkease ./ ; rm -rf nas-packages-luci
git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/multimedia/ffmpeg-remux ./ ; rm -rf nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/linkease ./ ; rm -rf nas-packages
wget -O ./Sub1.txt https://raw.githubusercontent.com/hkpc/V2ray-Configs/main/Sub1.txt

rm -rf ./*/.git & rm -rf ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore
