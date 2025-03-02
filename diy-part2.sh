#!/bin/bash
# 清除旧配置
rm -f ./.config*
touch .config

# 1️⃣ 目标架构（x86_64）
echo "CONFIG_TARGET_x86=y" >> .config
echo "CONFIG_TARGET_x86_64=y" >> .config
echo "CONFIG_TARGET_ROOTFS_EXT4FS=y" >> .config
echo "CONFIG_TARGET_ROOTFS_SQUASHFS=y" >> .config
echo "CONFIG_GRUB_IMAGES=y" >> .config
echo "CONFIG_GRUB_EFI_IMAGES=y" >> .config

# 2️⃣ 调整 Root 分区大小（默认 256MB，增加到 1024MB）
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config

# 3️⃣ 启用 Swap（512MB 防止 OOM）
echo "CONFIG_PACKAGE_block-mount=y" >> .config
echo "CONFIG_PACKAGE_f2fs-tools=y" >> .config
echo "CONFIG_PACKAGE_kmod-fs-f2fs=y" >> .config

# 4️⃣ 启用 CPU 频率管理（优化 Ryzen 5 3600 省电 & 性能）
echo "CONFIG_CPU_FREQ_GOV_POWERSAVE=y" >> .config
echo "CONFIG_CPU_FREQ_GOV_ONDEMAND=y" >> .config
echo "CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y" >> .config
echo "CONFIG_CPU_FREQ_GOV_PERFORMANCE=y" >> .config
echo "CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y" >> .config

# 5️⃣ 启用 LuCI 界面 & Netgear 主题
echo "CONFIG_PACKAGE_luci=y" >> .config
echo "CONFIG_PACKAGE_luci-base=y" >> .config
echo "CONFIG_PACKAGE_luci-theme-netgear=y" >> .config

# 6️⃣ 科学上网（Passwall / WireGuard）
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
echo "CONFIG_PACKAGE_v2ray-core=y" >> .config
echo "CONFIG_PACKAGE_xray-core=y" >> .config
echo "CONFIG_PACKAGE_trojan=y" >> .config
echo "CONFIG_PACKAGE_naiveproxy=y" >> .config
echo "CONFIG_PACKAGE_luci-app-wireguard=y" >> .config
echo "CONFIG_PACKAGE_wireguard-tools=y" >> .config
echo "CONFIG_PACKAGE_kmod-wireguard=y" >> .config

# 7️⃣ 启用 ZeroTier / Frp / Tailscale（内网穿透）
echo "CONFIG_PACKAGE_luci-app-zerotier=y" >> .config
echo "CONFIG_PACKAGE_luci-app-upnp=y" >> .config
echo "CONFIG_PACKAGE_luci-app-vpn-policy-routing=y" >> .config
echo "CONFIG_PACKAGE_tailscale=y" >> .config
echo "CONFIG_PACKAGE_frpc=y" >> .config

# 8️⃣ 启用 NAT 加速（CTF / FullCone NAT）
echo "CONFIG_PACKAGE_kmod-fast-classifier=y" >> .config
echo "CONFIG_PACKAGE_kmod-shortcut-fe=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-fullconenat=y" >> .config

# 9️⃣ 启用 SQM QoS（流量优化 & Ping 低延迟）
echo "CONFIG_PACKAGE_luci-app-sqm=y" >> .config
echo "CONFIG_PACKAGE_sqm-scripts=y" >> .config
echo "CONFIG_PACKAGE_bbr=y" >> .config

# 🔟 启用 AdGuardHome + SmartDNS（DNS 加速 & 去广告）
echo "CONFIG_PACKAGE_adguardhome=y" >> .config
echo "CONFIG_PACKAGE_luci-app-adguardhome=y" >> .config
echo "CONFIG_PACKAGE_luci-app-smartdns=y" >> .config
echo "CONFIG_PACKAGE_smartdns=y" >> .config

# 1️⃣1️⃣ 启用存储共享（Samba / NFS / FTP）
echo "CONFIG_PACKAGE_samba4-server=y" >> .config
echo "CONFIG_PACKAGE_nfs-utils=y" >> .config
echo "CONFIG_PACKAGE_vsftpd=y" >> .config

# 1️⃣2️⃣ 启用流量监控 & 端口转发
echo "CONFIG_PACKAGE_luci-app-nlbwmon=y" >> .config
echo "CONFIG_PACKAGE_luci-app-vnstat=y" >> .config
echo "CONFIG_PACKAGE_luci-app-upnp=y" >> .config

# 1️⃣3️⃣ 启用 IPv6 支持
echo "CONFIG_PACKAGE_ipv6helper=y" >> .config
echo "CONFIG_PACKAGE_kmod-ipv6=y" >> .config
echo "CONFIG_PACKAGE_kmod-sit=y" >> .config
echo "CONFIG_PACKAGE_odhcp6c=y" >> .config
echo "CONFIG_PACKAGE_odhcpd-ipv6only=y" >> .config

# 1️⃣4️⃣ 启用硬件 AES 加密（加速 Shadowsocks / WireGuard）
echo "CONFIG_PACKAGE_kmod-crypto-hw=y" >> .config
echo "CONFIG_PACKAGE_kmod-crypto-aes=y" >> .config
echo "CONFIG_PACKAGE_kmod-crypto-ecb=y" >> .config

# 1️⃣5️⃣ 设定默认主题
echo "CONFIG_PACKAGE_luci-theme-netgear=y" >> .config

# 1️⃣6️⃣ 保存配置
make olddefconfig < /dev/null

echo "✅ diy-part2.sh 执行完成！"
