#!/bin/sh
set -e

FTP_USR=ftpuser
FTP_PWD=$(cat /run/secrets/ftp_password.txt)

adduser -h /var/www/wordpress -s /bin/false -D ${FTP_USR}
echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd
adduser ${FTP_USR} root

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
