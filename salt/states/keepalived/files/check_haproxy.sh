#!/bin/bash

check_mlb() {
if [ $(ps -C haproxy --no-header | wc -l) -eq 0 ]; then
    service haproxy restart
    sleep 2
    if [ $(ps -C haproxy --no-header | wc -l) -eq 0 ]; then
        systemctl stop keepalived
    fi
fi
}

check_network() {

lb_vip={{ VIP }}
flag=true

ping -c 2 -W 2 $lb_vip &>/dev/null 
if [ ! $? -eq 0 ]; then
    ping -c 2 -W 2 $lb_vip &>/dev/null
fi
STA=$?
if [ $STA -eq 0 ]; then
    flag=true
else
    flag=false
fi 

if [ $flag == false ]; then
    systemctl stop keepalived
fi
}

check_network
check_mlb
