#!/bin/bash

echo "[+] 正在修改 LuCI 菜单显示名称..."

# 修改 FileBrowser 菜单项
sed -i 's/msgid "FileBrowser"/msgid "FileBrowser"\nmsgstr "本机文件"/' \
    feeds/luci/applications/luci-app-filebrowser/po/zh_Hans/filebrowser.po

# 修改 DDNS-Go 菜单项
sed -i 's/msgid "DDNS-Go"/msgid "DDNS-Go"\nmsgstr "动态域名"/' \
    feeds/luci/applications/luci-app-ddns-go/po/zh_Hans/ddns-go.po

# 修改 Vlmcsd KMS 菜单项
sed -i 's/msgid "Vlmcsd KMS 服务器"/msgid "Vlmcsd KMS 服务器"\nmsgstr "KMS 激活"/' \
    feeds/luci/applications/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po

# 修改 acme 菜单项
sed -i 's/msgid "ACME"/msgid "ACME"\nmsgstr "证书申请"/' \
    feeds/luci/applications/luci-app-acme/po/zh_Hans/acme.po

echo "[+] LuCI 菜单名称已修改完成。"
