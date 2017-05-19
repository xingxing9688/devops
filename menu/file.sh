#!/bin/bash
stty susp ^@#$  #屏蔽Crtl +z
stty intr ^@$#  #屏蔽Ctrl +c
stty quit ^*#$  #屏蔽Ctrl +l
RETVAL=0
NAME=$(whiptail --title "Test Free-form Input Box" --inputbox "What is your pet's name?" 10 60  3>&1 1>&2 2>&3)
exitstatus=$?  
if [ $exitstatus = 0 ]; then  
   echo "Your pet name is:" $NAME 
   if [ "$NAME"  =  `cat /opt/name` ];then  
      PASSWORD=$(whiptail --title "Password" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)
      exitstatus=$?
      if [ $exitstatus = 0 ]; then
         echo "Your password is:" $PASSWORD
        if [ "$PASSWORD" = `cat /opt/passwd` ];then 
          OPTION=$(whiptail --title "enncloud rancher " --menu "server list" 30 60 18  `cat /opt/menu.sh` 3>&1 1>&2 2>&3) 
          exitstatus=$?
          if [ $exitstatus = 0 ]; then
             echo "You choose the server." $OPTION
             if [ "$OPTION" -le "5" ];then 
               ip=`head -$OPTION /opt/ip.txt | tail -1`
               user=root
               ssh -i /key/enc.key $user@$ip
             else 
               ip=`head -$OPTION /opt/ip.txt | tail -1`
               user=root
               ssh -i /key/demo.key $user@$ip
            fi 
           else
                echo "You chose Cancel."
           fi               
        else
              echo "You chose Cancel."
        fi 
      else  
        exit 1 
      fi       
   else
    echo "You chose Cancel."
   fi     
else
    echo "You chose Cancel."
fi 


exit $RETVAL




