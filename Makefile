NAME = Demo

.PHONY: all setup build start stop status logs restart

all: setup build start
restart: stop start
rebuild: build restart

PROJECTDIR := $(shell /bin/bash -c pwd)

setup:
		virtualenv .docker_env && ./.docker_env/bin/pip install -r reqs/docker.txt
		touch .env

build:
		@docker/scripts/docker-compose build

start:
		@docker/scripts/docker-compose up -d --remove-orphans

stop:
		@docker/scripts/docker-compose down

status:
		@docker/scripts/docker-compose ps

logs:
		@docker/scripts/docker-compose logs

kill:
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/kill.sh

create_table:
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/create_table.sh $(table)
