#! /bin/sh
cur_date="`date +%Y_%m_%d_%H_%M`"
if [ ! -d "/var/backup" ]; then
  mkdir -p /var/backup
fi

# clean backup workdir
rm -rf /var/backup/influx/fpmiot/*
# run the backup command
influxd backup -portable -database fpmiot /var/backup/influx/fpmiot

# zip the backup files
cd /var/backup/influx/fpmiot
tar -zcvf /var/backup/influx/$cur_date.fpmiot.tar.gz .
cp /var/backup/influx/$cur_date.fpmiot.tar.gz /var/backup/influx/fpmiot.tar.gz
chmod 777 -R /var/backup/influx
