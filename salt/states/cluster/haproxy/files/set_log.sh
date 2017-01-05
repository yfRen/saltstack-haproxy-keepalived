#!/bin/bash

mkdir /var/log/haproxy
touch /var/log/haproxy/haproxy.log
chmod a+w /var/log/haproxy/haproxy.log
sed -i '/$ModLoad imudp/s/^#//' /etc/rsyslog.conf
sed -i '/$UDPServerRun 514/s/^#//' /etc/rsyslog.conf
sed -i '/local7.*                                                \/var\/log\/boot.log/alocal0.*                                                \/var\/log\/haproxy\/haproxy.log' /etc/rsyslog.conf
sed -i 's/SYSLOGD_OPTIONS=""/SYSLOGD_OPTIONS="-r -m 0 -c 2"/' /etc/sysconfig/rsyslog
systemctl restart rsyslog
