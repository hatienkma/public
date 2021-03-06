#!/bin/bash

IP_LIST="1.1.1.1 2.2.2.2 3.3.3.3"

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
done

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT


# Save All Rule
service iptables save
service iptables restart
