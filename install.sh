#!/bin/bash 
#xingxing 
#2016.11 

#install 
yum_update ()
 {
  yum update && yum -y  install gcc*  openssl  openssl-devel prel-devel perl     wget    curl-devel curl  lrzsz  git 
  systemctl disable firewalld 
  systemctl  stop  firewalld 
 } 

# set ssh 
sshd_config()
 {
  sed -i 's/#Port 22/Port 8022/'  /etc/ssh/sshd_config
  sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/'  /etc/ssh/sshd_config
  #sed -i 's/PermitRootLogin yes/PermitRootLogin no/'  /etc/ssh/sshd_config
 }   

docker_install()
 {
  yum -y install docker 
  systemctl start docker
  systemctl enable docker 
 }

useradd ()
{
 useradd wangxingxing && usermod -G wheel wangxingxing  
 su - wangxingxing 
 mkdir .ssh && chmod 700 .ssh && cd .ssh
 sudo wget https://raw.githubusercontent.com/xingxing9688/system/master/authorized_keys -P /home/wangxingxing/.ssh/
 sudo chmod 644 /home/wangxingxing/.ssh/authorized_keys 
}
yum_update
sshd_config
#docker_install
useradd


