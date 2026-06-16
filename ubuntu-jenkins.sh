#!/bin/bash
sudo apt update

sudo apt install -y openjdk-21-jdk

sudo update-alternatives --set java /usr/lib/jvm/java-21-openjdk-amd64/bin/java

sudo update-alternatives --set javac /usr/lib/jvm/java-21-openjdk-amd64/bin/javac

java -version

sudo mkdir -p /etc/apt/keyrings

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

sudo apt install -y jenkins

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo mkdir -p /var/tmp_disk
sudo chmod 1777 /var/tmp_disk
sudo mount --bind /var/tmp_disk /tmp
echo '/var/tmp_disk /tmp none bind 0 0' | sudo tee -a /etc/fstab
sudo systemctl mask tmp.mount
df -h /tmp
sudo systemctl restart jenkins
sudo systemctl status jenkins

sudo systemctl status jenkins
jenkins --version

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
