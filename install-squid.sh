echo 'fs.file-max = 65535' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sudo tee -a /etc/security/limits.conf << EOF
*               hard    nofile          65535
*               soft    nofile          65535
root            hard    nofile          65535
root            soft    nofile          65535
EOF

sudo sed -i '/DefaultLimitNOFILE/c DefaultLimitNOFILE=65535' /etc/systemd/*.conf
sudo systemctl daemon-reexec

# 查看系统限制
cat /proc/sys/fs/file-max

# 查看用户硬限制
ulimit -Hn

# 查看用户软限制
ulimit -Sn


apt-get update
apt install squid -y
wget -O "/etc/squid/squid.conf" "https://raw.githubusercontent.com/a990215520/squid_builder/main/squid.conf"
service squid restart
service squid status