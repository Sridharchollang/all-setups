#! /bin/bash
#Launch an instance with port 9000 and t2.medium

cd /opt/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
unzip sonarqube-8.9.6.50800.zip
yum install java-17-amazon-corretto -y
alternatives --set java /usr/lib/jvm/java-17-amazon-corretto.x86_64/bin/java
sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
useradd sonar
chown sonar:sonar sonarqube-8.9.6.50800 -R
chmod 777 sonarqube-8.9.6.50800 -R
su - sonar -c "sh /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start"

#run this on server manually to check status
#sh /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh status
#echo "user=admin & password=admin"
