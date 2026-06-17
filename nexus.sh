#!/bin/bash

sudo yum update -y

sudo yum install -y java-17-amazon-corretto wget tar

java -version

sudo mkdir -p /app
cd /app

wget https://download.sonatype.com/nexus/3/nexus-3.79.1-04-linux-x86_64.tar.gz

tar -xzf nexus-3.79.1-04-linux-x86_64.tar.gz

mv nexus-3.79.1-04 nexus

id nexus &>/dev/null || sudo useradd nexus

mkdir -p /app/sonatype-work

chown -R nexus:nexus /app/nexus
chown -R nexus:nexus /app/sonatype-work

sed -i 's/#run_as_user=""/run_as_user="nexus"/g' /app/nexus/bin/nexus

sed -i 's/Xms2703m/Xms512m/' /app/nexus/bin/nexus.vmoptions
sed -i 's/Xmx2703m/Xmx512m/' /app/nexus/bin/nexus.vmoptions

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

grep -q "/swapfile" /etc/fstab || echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

free -h

cat > /etc/systemd/system/nexus.service <<EOF
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
Restart=on-failure
TimeoutSec=600

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl enable nexus

systemctl start nexus

sleep 60

systemctl status nexus --no-pager

ss -tulnp | grep 8081

echo "Waiting for Nexus initialization..."
sleep 120

cat /app/sonatype-work/nexus3/admin.password
systemctl status nexus
ss -tulnp | grep 8081
free -h
