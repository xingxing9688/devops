tomcat 优化
vim   /bin/catalina.sh
JAVA_HOME=/usr/program/jdk1.8.0_102
CATALINA_HOME=/usr/program/tomcat
CATALINA_OPTS="-server -Xms512m -Xmx512m -XX:PermSize=256m -XX:MaxPermSize=358m"
CATALINA_PID=$CATALINA_HOME/catalina.pid

添加以上４点就可以了,也可以参考官网
tomcat 8 　https://tomcat.apache.org/tomcat-8.0-doc/config/


tomcat 日志切割


