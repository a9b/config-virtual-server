#!/bin/sh
# timezone
#cp -p /usr/share/zoneinfo/Japan /etc/localtime
ln -f /usr/share/zoneinfo/Japan /etc/localtime
hwclock --localtime --hctosys

now=`date "+%Y-%m-%d %H:%M:%S"`
echo ${now} > /tmp/start

# iptables off
/sbin/iptatbles -F
/sbin/service iptables stop
/sbin/chkconfig iptables off

# ネットワーク監視
yum -y install tcpdump

# HTTP立ち上げ
#yum -y install tcpdump
