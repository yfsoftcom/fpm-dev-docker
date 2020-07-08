all: init chmod docker-dev

init: 
	mkdir -p conf/mongo/data
	mkdir -p conf/pg/data
	mkdir -p conf/redis/data

chmod:
	sudo chmod 777 -R conf/*/data
	
docker-dev:
	docker-compose -f docker-compose.dev.yml up --build -d