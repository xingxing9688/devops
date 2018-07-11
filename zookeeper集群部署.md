### Zookeeper 简介 
    
    zookeeper 分布式服务框架Apache Hadoop 的子项目，它主要是用来解决分布式应用中经常遇到的一些数据管理问题，如:统一命名服务、状态同步服务、集群管理、分布式应用配置项的管理。 
    
    zookeeper角色
    | 角色	      | 描述	           |
    |:------------- |:---------------:| 
    | 领导者(Leader) | 领导者负责投票的发起和决议，更新系统状态 |
    | 学习者(Learner)|跟随者(Follower)|Follower用于接收客户请求并向客户端返回结果，在选主过程中参与投票   
                    |观察者(ObServer)|observer 可以接收客户端连接，将写请求转发给leader 节点，但observer 不参数投票过程，只同步leader 的状态，observer的目的是为了扩展系统，提高读取速度              
    |客户端(cliient) |请求发起方       |					 
    
### zookeeper 的网络结构
     zookeeper 的工作集群可以简单分成两类，一个是leader，唯一一个，其余都是follower
     1. leader 和follower 是互相通信的，对于zk系统的数据都是保存在内存里面的，同样也会备份一份在磁盘上，
     2. 如果leader 挂了，zk集群会重新选举，在毫秒级别就会重新选举出一个leaer，
     3. 集群中除非有一半以上的zk 节点挂了，zk service 才不可用
### Zookeeper 设计目的
     1. 最终一致性: client 不论连接到哪个Server，展示给它都是同一个视图，这是zookeeper 最重要的性能。
     2. 可靠性:具有简单、健壮、良好的性能，如果消息m被到一台服务器接受，那么它将被所有的服务器接受
     3. 实时性: zookeerper 保证客户端将在一个时间间隔范围内获得服务器的更新信息，或者服务器失效的信息。但由于网络延时等原因，zookeeper 不能保证两个客户端能同时得到更新的数据，如果需要最新的数据，应该在读取数据之前用sync()接口，
     4. 原子性: 更新只能成功或者失败，没有中间状态
     5. 顺序性: 包括全局有序和偏序两种;全局有序是指如果在一台服务器上消息a在消息b前发布，则在所有Server 上消息a 都将在消息b前被发布；偏序是指如果一个消息b 在消息a后被同一个发送者发布，a必将排在b 前面。
     
### zookeeper工作原理
    zookeeper 的核心是广播，这个机制保证了各个Server 之间的同步。实现这个机制的协议叫做zab 协议。
    zab 协议有两种，它们分别是恢复模式(选主)和广播模式(同步)。当服务启动或者领导者崩溃后，zab 就进入了恢复模式，当领导者被选举出来，且大多数server 完成了和leader 的状态同步以后，恢复模式就结束了。状态同步保证了leader 和server 就有相同的系统状态，为了保证事务的顺序一致性，zookeeper 采用了递增的事务id来标识事务。 
     
     每个Server 在工作过程中有三种状态:
     
     LOOKING:当前Server不知道leader是谁，正在搜寻
     LEADING:当前Server 即为选举出来的leader 
     FOLLOWING: leader 已经选举出来，当前Server与之同步
       
### 配置hosts 
     vim  /etc/hosts 
          10.39.15.13     kafka-node1 
          10.39.15.15     kafka-node2
          10.39.15.16     kafka-node3 
          
### 解压
     tar xvf zookeeper-3.4.11.tar.gz -C /application/ 
     
### 修改配置文件
    
     mv zoo_sample.cfg zoo.cfg 
     vim zoo.cfg 
      tickTime=2000 #服务器之间或客户端与服务器的单次心跳检测时间间隔，单位为毫秒
      initLimit=10  #集群中leader服务器与follower服务器第一次连接最多次数
      syncLimit=5   #leader 与follower 之间发送和应答时间，如果该follower 在设置的时间内不能与leader 进行通信，那么此follower被视为不可用
      dataDir=/data/zookeeper  保存数据的目录
      clientPort=2181  客户端连接zk 的服务器端口，zk 会监听这个端口，接受客户端的访问请求
      server.1=kafka-node1:2888:3888
      server.2=kafka-node2:2888:3888
      server.3=kafka-node3:2888:3888       
                
      mkdir /data/zookeeper  -p      
      
### 建立zookeeper节点标识文件myid 
    host1 下输入
     echo "1" > /data/zookeeper/myid     
    host2 下输入
     echo "2" > /data/zookeeper/myid     
    host3 下输入
     echo "3" > /data/zookeeper/myid  
 
### 修改环境变量
   
    vim  /etc/profile 
    export ZOOKEEPER_HOME=/data/zookeeper/zookeeper-3.4.7
    export PATH=$ZOOKEEPER_HOME/bin:$PATH 
    
    
### Zookeeper 常见配置
    
    tickTime: CS通信心跳数；以毫秒为单位，可以使用默认配置
    initLimit: LF初始通信时限；
    syncLimit: LF同步通信时限；数值不宜过高
    dataDir:   数据文件目录
    dataLogDir: 日志文件目录
    clientPort: 客户端连接端口
    server.N:  服务器名称与地址(服务编号，服务地址，LF通信端口，选举端口)
    
    高级配置
    gloabalOutstandingLimit: 最大请求堆积属，默认1000；
    preAllocSize:预分配的Transaction  log 空间大小
    snapCount:每秒进行snapCount 次事务日志输出后，触发一次快照
    maxClientCnxns: 最大并发客户端数
    forceSync: 是否提交事务的同时同步磁盘；
    leaerServers:是否禁止leader 读功能
    traceFile: 是否记录所有请求的log 
    
### 启动
     zkServer.sh   start  启动服务
     zkServer.sh   status 查看状态    
        
### 挂载外存储
     parted -s /dev/vdc mklabel msdos 
     parted -s /dev/vdc mkpart primary 0 100%
     mkfs.xfs /dev/vdc1 
     
     
        
     
     
         
    
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
        