#!/bin/bash 
# centos 7 下php 的编译
#php 编译安装
#php 安装所需要的包
yum install libmcrypt  
yum install -y gcc gcc-c++  make zlib zlib-devel pcre pcre-devel  libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel openssl openssl-devel 
yum install libXpm-devel  libtidy-devel   curl-devel  db4-devel expat-devel libxslt libxslt-devel libxml2 libxml2-devel  curl  
yum install libjpeg-devel  install libpng-devel gmp-devel net-snmp-devellibxslt-devel sqlite-devel aspell-devel
yum install   libX11-devel libXext-devel libXt-devel
yum install libxslt* -y
yum install -y libmcrypt-devel
yum install mhash
yum install namp 


#install libiconv  libiconv-devel 
wget https://forensics.cert.org/cert-forensics-tools-release-el7.rpm
rpm -Uvh cert-forensics-tools-release*rpm
yum --enablerepo=forensics install libiconv  libiconv-devel -y 
yum install -y icu libicu libicu-devel
./configure --prefix=/application/php --with-mysql --with-mhash --with-mcrypt  --with-libxml-dir --with-openssl \
--with-zlib  --with-curl --with-xmlrpc --with-libxml-dir  --with-pcre-dir --with-gd --with-jpeg-dir --with-png-dir \
--with-xpm-dir --with-freetype-dir  --with-gmp --with-iconv  --with-pear --with-xsl --enable-ftp --enable-bcmath \
--with-bz2  --enable-inline-optimization --with-gettext --enable-zend-signals --enable-exif --enable-fpm \
--enable-ftp --enable-gd-native-ttf --enable-gd-jis-conv --enable-intl --enable-mbstring  --enable-sockets \
--enable-zip --enable-soap --enable-short-tags --enable-mbstring --enable-sysvshm  --enable-sysvmsg --enable-sysvsem \
--enable-pcntl --enable-wddx --enable-opcache --with-gmp  --with-imap-ssl --enable-fpm  --with-xsl  --enable-shmop \
--enable-mysqlnd   --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd
make 
make install 
# 添加系统环境变量
环境配置     
export PATH=$PATH:/application/php/bin:$PATH

cp　/opt/php-5.6.29/php.ini-production  /application/php/lib/ 
ln -s /application/php/lib/php.ini-production  /application/php/lib/php.ini

# php　添加到centos7 启动脚
cp /opt/php-5.6.29/sapi/fpm/php-fpm.service   /usr/lib/systemd/system/

# 拷贝之后需要修改脚本路径

[Unit]
Description=The PHP FastCGI Process Manager
After=syslog.target network.target

[Service]
Type=simple
PIDFile=/var/run/php-fpm.pid
ExecStart=/application/php/sbin/php-fpm --nodaemonize --fpm-config /application/php/etc/php-fpm.conf
ExecReload=/bin/kill -USR2 $MAINPID

[Install]
WantedBy=multi-user.target


systemctl daemon-reload
systemctl restart php-fpm 
