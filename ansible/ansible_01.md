1. centos 上安装ansible  
    yum install epel-release  -y
    yum install ansible   -y 
2. 配置 
  2.1 配置ansible 

   vim /etc/ansible/hosts 
   例子:
   k8s-master ansible_ssh_host=10.39.1.35  ansible_ssh_user=root  ansible_ssh_pass="password" 
   http://www.ansible.com.cn/docs/intro_inventory.html#inventoryformat 
   
   #拷贝文件
    ansible k8s -m copy -a 'src=/ansible/virt7.repo dest=/etc/yum.repos.d/'

    

