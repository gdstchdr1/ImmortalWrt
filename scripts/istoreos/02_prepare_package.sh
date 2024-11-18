#!/bin/bash

. ../scripts/funcations.sh

### 基础部分 ###
# 使用 O2 级别的优化
sed -i 's/Os/O2/g' include/target.mk
# 更新 Feeds
./scripts/feeds update -a
./scripts/feeds install -a

### FIREWALL ###
# custom nft command
patch -p1 < ../patch/firewall/100-openwrt-firewall4-add-custom-nft-command-support.patch
# patch LuCI 以支持自定义 nft 规则
pushd feeds/luci
patch -p1 < ../../../patch/firewall/04-luci-add-firewall4-nft-rules-file.patch
popd

### 替换准备 ###
cp -rf ../openwrt-apps ./package/new
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,frp,shadowsocks-libev,v2raya}
rm -rf feeds/luci/applications/{luci-app-frps,luci-app-frpc,luci-app-v2raya,luci-app-dockerman}
rm -rf feeds/packages/utils/coremark

### 获取额外的 LuCI 应用和依赖 ###
# 添加 default settings
cp -f ../patch/default-settings/istoreos/zzz-default-settings ./package/istoreos-files/files/etc/uci-defaults/
# Golang
rm -rf ./feeds/packages/lang/golang
cp -rf ../openwrt_pkg_ma/lang/golang ./feeds/packages/lang/golang
# 预编译 node
rm -rf feeds/packages/lang/node
cp -rf ../node feeds/packages/lang/node
# Docker 容器
cp -rf ../dockerman/applications/luci-app-dockerman feeds/luci/applications/luci-app-dockerman
sed -i '/auto_start/d' feeds/luci/applications/luci-app-dockerman/root/etc/uci-defaults/luci-app-dockerman
pushd package/feeds/luci/luci-app-dockerman
docker_2_services
popd

# 预配置一些插件
mkdir -p files
cp -rf ../files/{etc,root,cpufreq/*,sing-box/*} files/

find ./ -name *.orig | xargs rm -f
find ./ -name *.rej | xargs rm -f

exit 0
