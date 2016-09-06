# saltstack-haproxy-keepalived
你可以通过Saltstack自动化安装及配置Haproxy和Keepalived

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
systemctl stop firewalld && systemctl disable firewalld

# Installation, configuration and startup services
yum -y install epel-release
yum -y install salt-master salt-minion

cp -prf /root/saltstack-haproxy-keepalived/config/* /etc/salt/
cp -prf /root/saltstack-haproxy-keepalived/salt /srv/

systemctl start salt-master
systemctl start salt-minion

# salt查看salt-minion认证
salt-key
# salt同意salt-minion认证
salt-key -A	# -A:同意所有

# Use saltstack
salt '*' test.ping
salt '*' state.highstate
