#! /bin/sh
influx -execute 'drop database fpmiot'
influxd restore -portable -database fpmiot /var/backup/influx/fpmiot