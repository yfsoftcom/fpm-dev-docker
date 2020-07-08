all: chmod docker-dev
chmod:
	sudo chmod 777 -R conf/*/data
docker-dev:
	docker-compose -f docker-compose.dev.yml up --build -d