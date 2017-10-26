## ansible 

### 1. centos 上安装ansible  
    yum install epel-release  -y
    yum install ansible   -y 
### 2. 配置 
####   2.1 配置ansible 

    vim /etc/ansible/hosts 
    例子:
    k8s-master ansible_ssh_host=10.39.1.35         ansible_ssh_user=root  ansible_ssh_pass="password" 
   
    http://www.ansible.com.cn/docs/intro_inventory.html#inventoryformat 
   
    #拷贝文件
    ansible k8s -m copy -a 'src=/ansible/virt7.repo dest=/etc/yum.repos.d/'



##### 2.1.1 拷贝秘钥    
    ansible test -m copy -a 'src=~/.ssh/id_rsa.pub dest=~' -k
    ansible test -a 'ls' -k 
    ansible test -m shell -a 'mkdir -p .ssh'
    ansible test -m shell -a 'cat ~/id_rsa.pub >>  ~/.ssh/authorized_keys' -k
    ansible test -m shell -a 'cat .ssh/authorized_keys'

    方法二：
    ansible all -m authorized_key -a "user=ubuntu key='{{ lookup('file','~/.ssh/id_rsa.pub')}}'  path='/ubuntu/.ssh/authorized_keys' manage_dir=no" --ask-pass -c paramiko

    