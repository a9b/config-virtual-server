#!/bin/sh
now=`date "+%Y-%m-%d %H:%M:%S"`
echo ${now} > /tmp/end

# apachのvirtualhostを適用
ln -s /etc/httpd/sites-available/default /etc/httpd/sites-enabled/
service httpd restart
