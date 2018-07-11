### kafka基础
    kafka 是一个分布式消息发布订阅系统，它最初由linkedln 公司基于独特的设计实现为一个分布式的提交日志系统，之后成为Apache 项目的一部分，kafka 系统快速、可扩展并且可持久化。它的分区特性，可复制和可容错都是其不错的特性。
    
    Apache kafka 与传统消息系统相比，有以下不同:
    1. 它被设计为一个分布式系统，易于向外扩展
    2. 它同时为发布和订阅提供高吞吐量；
    3. 它支持多订阅者，当失败时能自动平衡消费者
    4. 它将消息持久化到磁盘，因此可用于批量消费，
    
    kafka 所使用的基本术语！
    topic 
    kafka将消息种子(Feed)分门别类，每一类的消息称之为话题(Topic)
    producer 
    发布消息的对象称之为话题生产者(kafka topic producer)
    Consumer 
    订阅消息并处理发布的消息种子的对象称之为话题消费者(consumers)
    broker 
    已发布的消息保存在一组服务器中称之为kafka 集群，集群中每一个服务器都是一个代理，消费者可以订阅一个或多个话题并从Broker 拉数据从而消费这些已发布的消息

### 安装kafka
     tar xvf kafka_2.12-1.0.0.tgz -C  /application/
     
### 配置kafka     
    
    vim  /application/kafka_2.12-1.0.0/config/server.properties 
    broker.id=1
    # 每一个broker 在集群中唯一标识，在改变ip 地址，不改变broker.id的话不会影响consumers 
    
    num.network.threads =3
    # broker 处理消息的最大线程数
    
    num.io.threads =8
    #  broker处理磁盘IO 的线程数，数值应该大于你的硬盘数 
    
    zookeeper.connect=10.39.15.13:2181,10.39.15.15:2181,10.39.15.16:2181  
    ........
    拷贝到其他两个节点修改broker.id=2/3 就行

### 修改分片
    kafka-topics.sh --alter --zookeeper localhost:2181 --topic k8s-log --partitions 9
    
    

    
### 启动kafka
    node1 启动    
    kafka-server-start.sh  -daemon /application/kafka_2.12-1.0.0/config/server.properties 
    node2 启动
    node3 启动
    
    关闭kafka-server-stop.sh 
    
    
### kafka 查看消费
          
    
### 安装logstash   
     
    rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch    
     
    cat  <<EOF   >/etc/yum.repos.d/logstash.repo
    [logstash-5.x]
    name=Elastic repository for 5.x packages
    baseurl=https://artifacts.elastic.co/packages/5.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md
    EOF
     
    指定版本号安装   yum install logstash-5.4.3  
    
### 配置logstash  
     创建配置文件 
     vim  /etc/logstash/conf.d/filebeat.conf 
     input {
    kafka {
        bootstrap_servers => "10.39.15.13:9092,10.39.15.15:9092,10.39.15.16:9092"
        topics => "k8s-log"
        consumer_threads => 5
        decorate_events => true
        codec => "json"
     }
  
    }

    output {
    if [type] == "k8s-log" {
        elasticsearch {
            hosts => ["10.39.15.2:9200","10.39.15.10:9200","10.39.15.5:9200"]
            codec => "json"
            index => "filebeat-%{+YYYY.MM.dd}"
        }
     }
    }
  
### filebeat 配置文件修改
    
    output.kafka:
    hosts: ["10.39.15.13:9092","10.39.15.15:9092","10.39.15.16:9092"]
    topic: k8s-log
    partition.round_robin:
      reachable_only: false
    required_acks: 1
    compression: gzip
    max_message_bytes: 1000000
    

    
    
      
      
    
    
    
    
     
          
       
    
    