NAME = Demo

.PHONY: all create_table login logs kill setup start status stop

all: setup build start
restart: stop start
rebuild: build restart

PROJECTDIR := $(shell /bin/bash -c pwd)

build:
		@docker/scripts/docker-compose build

create_table:
		@docker/scripts/docker-compose exec --user app demo sh /app/code/docker/scripts/create_table.sh $(table)

login:
		@docker/scripts/docker-compose exec --user app demo sh

logs:
		@docker/scripts/docker-compose logs

kill:
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/kill.sh

setup:
		virtualenv .docker_env && ./.docker_env/bin/pip install -r reqs/docker.txt
		touch .env

start:
		@docker/scripts/docker-compose up -d --remove-orphans

status:
		@docker/scripts/docker-compose ps

stop:
		@docker/scripts/docker-compose down
