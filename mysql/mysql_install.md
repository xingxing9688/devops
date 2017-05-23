# mysql 5.7.17
## 创建用户 
    groupadd mysql
    useradd -r -g mysql mysql
    yum install ncurses-devel  -y 
    
    wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.18.tar.gz 
## 编译参数    
    time cmake \
    -DCMAKE_INSTALL_PREFIX=/application/mysql \
    -DSYSCONFDIR=/etc \
    -DMYSQL_DATADIR=/data/mysql \
    -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock \
    -DMYSQL_USER=mysql \
    -DEXTRA_CHARSETS=all  \
    -DWITH_READLINE=1 \
    -DDOWNLOAD_BOOST=1 \
    -DWITH_BOOST=../boost_1_59_0/ \
    -DWITH_EMBEDDED_SERVER=1 \
    -DENABLED_LOCAL_INFILE=1 \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DDEFAULT_CHARSET=utf8  \
    -DDEFAULT_COLLATION=utf8_general_ci 

    make 
    make install 

# 拷贝启动脚本
    cp support-files/mysql.server  /etc/init.d/
# 配置文件
    cp support-files/my-default.cnf /etc/my.cnf
    systemctl enable mysql 
# 初始化脚本
     mysqld --initialize-insecure --user=mysql --user=mysql --basedir=/application/mysql --datadir=/data/mysql
