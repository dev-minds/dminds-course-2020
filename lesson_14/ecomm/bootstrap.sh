#!/bin/bash 

# configure hosts file for our internal network
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd  

useradd ansible ; echo ansible | passwd ansible --stdin

chmod 700 /etc/sudoers
echo "ansible   ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
chmod 0440 /etc/sudoers 
 
sudo yum install net-tools -y
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

Running ...
sleep 10s

HOSTBOX=`hostname`
IPADDR=`ifconfig eth1 | awk '$1=="inet" {print $2}'`
#hst_file=`ifconfig Auto_eth0 | awk '$1=="inet" {print $2}' | awk -F : '{print $2}'`

# ====================== Expect Ip Address ====================== #
echo -e "$HOSTBOX has ipaddress -> : $IPADDR"
#echo -e "$hst_file   $HOST" >> /etc/hosts 

sudo /sbin/reboot

