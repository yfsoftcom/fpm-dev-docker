all: init chmod docker-dev

init: 
	mkdir -p conf/mongo/data
	mkdir -p conf/pg/data
	mkdir -p conf/redis/data
	mkdir -p conf/influx/data
	mkdir -p conf/influx/backup
	mkdir -p conf/mysql/data
	mkdir -p conf/mysql/backup

chmod:
	sudo chmod 777 -R conf/*/data
	
docker-dev:
	docker-compose -f docker-compose.dev.yml up --build -d

docker-iot:
	docker-compose -f docker-compose.iot.yml up --build -d

shut-dev:
	docker-compose -f docker-compose.dev.yml down

shut-iot:
	docker-compose -f docker-compose.iot.yml down

backup-mysql:
	docker exec mysqlserver bash -c "cd /var && ./backup.sh fpm_open_iot"

backup-influx:
	docker exec influxdb bash -c "backupinflux.sh"

init-influx:
	docker exec influxdb bash -c "influx_init.sh"

restore-mysql:
	docker exec mysqlserver bash -c "cd /var && ./restore.sh fpm_open_iot"

restore-influx:
	docker exec influxdb bash -c "restoreinflux.sh"

init-influx:
	docker exec influxdb bash -c "influx_init.sh"