
#/bin/bash 

#mysql  install 
mysql_version=mysql-5.6.38
#[dir]
if [ ! -d "/data" ];then
   mkdir /data
fi

if [ ! -d "/run/mysqld" ];then
   mkdir /run/mysqld
fi

yum -y install make gcc-c++ cmake bison-devel  ncurses-devel perl autoconf
groupadd mysql
useradd mysql -g mysql -M -s /sbin/nologin

tar xvf    /tmp/$mysql_version.tar.gz  -C  /tmp ; cd /tmp/$mysql_version
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/data/mysql \
-DSYSCONFDIR=/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1\
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci
make && make install

## mysql config
chown -R root:mysql /usr/local/mysql/
chown -R mysql:mysql /data/mysql
echo "export PATH=$PATH:/usr/local/mysql/bin"   >> /etc/profile
source /etc/profile
cd  /usr/local/mysql
cp support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld
chkconfig mysqld on
./scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/data/mysql --no-defaults --user=mysql
systemctl restart mysqld

