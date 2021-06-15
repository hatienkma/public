#!/bin/bash

IP_LIST="207.246.75.203 113.20.119.96 113.185.43.165 183.81.101.28"

iptables -F
iptables -X
iptables -Z

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -d 127.0.0.0/8 -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

for iplist in $IP_LIST
do
iptables -A INPUT -s $iplist -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -s $iplist -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -s $iplist -p tcp --dport 8345 -j ACCEPT
iptables -A INPUT -s $iplist -p tcp --dport 3306 -j ACCEPT
done

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT


# Save All Rule
service iptables save
service iptables restart
