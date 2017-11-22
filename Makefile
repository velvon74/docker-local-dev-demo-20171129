NAME = Demo

.PHONY: all create_table login logs kill setup start status stop

all: setup build start
restart: stop start
rebuild: build restart

PROJECTDIR := $(shell /bin/bash -c pwd)

build:
	  @echo Starting docker build
		@docker/scripts/docker-compose build

create_table:
		@echo Creating a table
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/create_table.sh $(name)

login:
		@echo Logging inside App container
		@docker/scripts/docker-compose exec demo sh

logs:
		@echo Showing docker logs
		@docker/scripts/docker-compose logs

kill:
		@echo Restarting the App
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/kill.sh

setup:
		@echo Preparing localhost, keep calm
		virtualenv .docker_env && ./.docker_env/bin/pip install -r reqs/docker.txt
		touch .env

start:
		@echo Starting your Docker development environment
		@docker/scripts/docker-compose up -d --remove-orphans

status:
		@echo Hey, what is going on?
		@docker/scripts/docker-compose ps

stop:
		@echo Stopping the App
		@docker/scripts/docker-compose down
