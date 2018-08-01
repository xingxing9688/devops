

### kafka  
    
    
    
    
    
    
    log.flush.interval.ms=1000                 每隔1秒钟时间，刷数据到磁盘 
    log.retention.hoiirs=72                    日志保留策略,按小时算，默认168小时
     num.partitions=1                          分区数  
     num.network.threads =4                    broker处理消息最大线程数，为CPU核数
     num.io.threads =8                         broker处理磁盘IO的线程数，为CPU 2倍
     
     
     