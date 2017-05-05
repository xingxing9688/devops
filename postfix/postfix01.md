#centos 6 下postfix 配置
1. 使用虚拟用户发送邮件
   创建虚拟用户  
    

  1.2 vim /etc/postfix/main.cf
   queue_directory = /var/spool/postfix
   command_directory = /usr/sbin
   daemon_directory = /usr/libexec/postfix
   data_directory = /var/lib/postfix
   mail_owner = postfix
   myhostname = mail.palmjob.net
   mydomain = palmjob.net
   myorigin = $mydomain
   inet_interfaces = all
   inet_protocols = all
   unknown_local_recipient_reject_code = 550
   mynetworks = 127.0.0.0/8
   alias_maps = hash:/etc/aliases
   alias_database = hash:/etc/aliases
 
  
   debug_peer_level = 2
   debugger_command =
	 PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
	 ddd $daemon_directory/$process_name $process_id & sleep 5
   sendmail_path = /usr/sbin/sendmail.postfix
   newaliases_path = /usr/bin/newaliases.postfix
   mailq_path = /usr/bin/mailq.postfix
   setgid_group = postdrop
   html_directory = no
   manpage_directory = /usr/share/man
   sample_directory = /usr/share/doc/postfix-2.6.6/samples
   readme_directory = /usr/share/doc/postfix-2.6.6/README_FILES
   
   #smtp 认证
   smtpd_sasl_auth_enable = yes
   broken_sasl_auth_clients = yes
   smtpd_sasl_type = dovecot
   smtpd_sasl_path = private/auth
   smtpd_sasl_security_options = noanonymous
   smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated,reject_unauth_destination
   
   #虚拟用户认证
   virtual_mailbox_domains = proxy:mysql:/etc/postfix/sql/mysql_virtual_domains_maps.cf
   virtual_alias_maps =
     proxy:mysql:/etc/postfix/sql/mysql_virtual_alias_maps.cf,
     proxy:mysql:/etc/postfix/sql/mysql_virtual_alias_domain_maps.cf,
     proxy:mysql:/etc/postfix/sql/mysql_virtual_alias_domain_catchall_maps.cf
   virtual_mailbox_maps =
     proxy:mysql:/etc/postfix/sql/mysql_virtual_mailbox_maps.cf,
     proxy:mysql:/etc/postfix/sql/mysql_virtual_alias_domain_mailbox_maps.cf
   virtual_mailbox_base = /data/mail/
   virtual_create_maildirsize = yes
   virtual_mailbox_extended = yes
   virtual_mailbox_limit_maps = mysql:/etc/postfix/sql/mysql_virtual_mailbox_limit_maps.cf
   virtual_mailbox_limit_override = yes
   virtual_maildir_limit_message = Sorry, the user's maildir has overdrawn his diskspace quota, please try again later.
   virtual_overquota_bounce = yes
   virtual_uid_maps = static:1000
   virtual_gid_maps = static:1000
   virtual_transport = virtual
  
   
   2. dovecot 配置
     listen = *
     protocols = imap pop3
     disable_plaintext_auth = no
     ssl = no
     auth_mechanisms = plain login
     mail_access_groups = vmail
     default_login_user = vmail
     first_valid_uid = 1000
     first_valid_gid = 1000
     mail_location = maildir:/data/mail/%d/%n

     userdb {
        driver = sql
        args = /etc/dovecot/dovecot-sql.conf
      }

      passdb {
         driver = sql
         args = /etc/dovecot/dovecot-sql.conf
      }

       service auth {
           unix_listener /var/spool/postfix/private/auth {
           group = postfix
           mode = 0660
           user = postfix
       }
         user = root
       }
        service imap-login {
        process_min_avail = 1
        user = vmail
       }   
