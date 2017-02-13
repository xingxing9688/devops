#!/bin/bash 
#xingxing 
#2016.11 

#install 
yum_update ()
 {
  yum update -y && yum -y  install gcc*  openssl  openssl-devel prel-devel perl     wget    curl-devel curl  lrzsz  git vim -y 
  systemctl disable firewalld
  systemctl status firewalld 
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



#iptables -t nat -I POSTROUTING -s 192.168.8.0/24 -j SNAT --to-source 192.168.8.1  


yum_update

sshd_config
echo "sshd_config"



