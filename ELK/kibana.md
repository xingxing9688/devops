## kibana 
    
    kibana是一个开源的分析和可视化平台，可以使用kibana来搜索，查看存储在elasticsearch索引中的数据并与其进行交互。可以进行高级数据分析，图表 表格和地图展示数据。 
    


### 安装
    
    1. rpm 安装
     rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
    
     /etc/yum.repos.d/kibana.repo 
     [kibana-6.x]
     name=Kibana repository for 6.x packages
     baseurl=https://artifacts.elastic.co/packages/6.x/yum
     gpgcheck=1
     gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
     enabled=1
     autorefresh=1
     type=rpm-md
    
     
     yum install kibana
     
     
      docker 运行 oss版本不预装x-pack 功能
      docker.elastic.co/kibana/kibana-oss:6.2.4  
      
      

     
### 配置kibana 
     
     1. 配置文件中kibana.yml 
     server.name    kibana 
     server.host    "0"
     elasticsearch.url   http://elasticsearch:9200  
     
     2. 访问kibana  web 管理工作台
     默认是通过5601端口进行访问 
     
     3. 设置index pattern 
        
       我们需要为kibana 配置一个index pattern 来匹配es 中的索引名称，默认是logstash-*,匹配es 中的数据，同时还需要配置一个time-field  name, 那个field 是time 
         
     
          
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     