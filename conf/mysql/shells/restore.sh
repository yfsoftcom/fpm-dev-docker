#! /bin/sh

DB_NAME=${arg1:="fpm_open_iot"}

mysql -u root -p741235896 $DB_NAME < /var/backup/mysql/latest.sql