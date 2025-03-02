#!/bin/bash
# 进入 OpenWRT 源码目录
cd lede

# 1️⃣ 拉取额外插件
git clone --depth=1 https://github.com/fw876/helloworld package/helloworld
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone --depth=1 https://github.com/kenzok8/openwrt-packages package/kenzok8

# 2️⃣ 替换默认 Argon 主题
rm -rf package/lean/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 3️⃣ 修改默认 IP 地址（改为 192.168.50.5）
sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 4️⃣ 删除不必要的软件包（如果你不需要）
# rm -rf package/lean/luci-app-eqos  # 删除流量均衡插件
# rm -rf package/lean/luci-app-qbittorrent  # 删除 BT 下载器

# 5️⃣ 给 Shell 脚本加执行权限
chmod +x diy-part1.sh
