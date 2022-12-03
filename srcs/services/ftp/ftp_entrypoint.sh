#! /usr/bin/env sh

set -e

# Make a new user & give a password
id $FTP_USER > /dev/null 2>&1 || adduser -DH $FTP_USER -G www-data
passwd $FTP_USER -d $FTP_PASSWD

# Give permission to write to the group, www-data,
# such that the $FTP_USER may upload files to the server.
chmod g+w /home/$FTP_USER/ftp

# Execute FTP server
echo -e '\n\n"Building a dream from your memory is the easiest way of losing your grasp on what’s real and what is a dream."\nFTP IS UP!\n\n'
exec tini -- vsftpd /etc/vsftpd/vsftpd.conf
