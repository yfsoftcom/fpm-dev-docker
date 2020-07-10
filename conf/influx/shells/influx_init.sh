#! /bin/sh

# find more info https://docs.influxdata.com/influxdb/v1.7/tools/shell/
echo "create db fpmiot"
influx -execute 'CREATE DATABASE fpmiot'