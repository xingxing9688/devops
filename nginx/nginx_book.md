1. http 响应码
   2xx: 成功
   3xx: 重定向
   4xx: 客户端错误
   5xx: 服务器错误
2. http: 80/tcp 
      tcp 三次握手,四次断开
      keepalive: (长链接,保持链接)
           时间:timeout 
           数量: 
      cookie: 
         session保持;
	    反均衡
	    session 无可用
         session复制
	    服务器资源消耗过大
	    网络资源
	 session服务器
	    服务器自身的HA 

	 基于cookie均衡;  
3. IO模型
    同步阻塞
    同步非阻塞
    IO复用
    事件通知

