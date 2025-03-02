#!/bin/bash
# 确保进入 OpenWRT 源码目录
if [ -d "lede" ]; then
    cd lede
else
    echo "Error: 'lede' directory not found!"
    exit 1
fi

# 1️⃣ 拉取额外插件
git clone --depth=1 https://github.com/fw876/helloworld package/helloworld
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone --depth=1 https://github.com/kenzok8/openwrt-packages package/kenzok8

# 2️⃣ 替换默认 Netgear 主题
rm -rf package/lean/luci-theme-argon
git clone --depth=1 https://github.com/i028/luci-theme-netgear package/luci-theme-netgear

# 3️⃣ 修改默认 IP（避免和旁路由 10.0.0.1 冲突）
sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate

# 4️⃣ 设置默认网关和 DNS（指向旁路由 10.0.0.1）
sed -i 's/gateway=.*/gateway="10.0.0.1"/g' package/base-files/files/bin/config_generate
sed -i 's/dns=.*/dns="10.0.0.1"/g' package/base-files/files/bin/config_generate

# 5️⃣ 修改 OpenWRT 主机名
sed -i 's/hostname=.*/hostname="OpenWRT-Test"/g' package/base-files/files/bin/config_generate

# 6️⃣ 预设 WiFi 名称和密码
uci set wireless.default_radio0.ssid='OpenWRT-Test'  # 2.4G WiFi
uci set wireless.default_radio0.key='12345678'  # 2.4G WiFi 密码
uci set wireless.default_radio0.encryption='psk2'  # WPA2
uci set wireless.default_radio1.ssid='OpenWRT-Test-5G'  # 5G WiFi
uci set wireless.default_radio1.key='12345678'  # 5G WiFi 密码
uci set wireless.default_radio1.encryption='psk2'
uci commit wireless

# 7️⃣ 修改 SSH 端口（22 -> 2222）
sed -i 's/option Port 22/option Port 2222/g' package/network/services/dropbear/files/dropbear.config

# 8️⃣ 关闭 DHCP（避免和旁路由冲突）
uci set dhcp.lan.ignore=1
uci commit dhcp

echo "✅ diy-part1.sh 执行完成！"
