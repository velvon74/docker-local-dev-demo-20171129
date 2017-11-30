NAME = Demo

.PHONY: all create_table login logs kill setup start status stop

all: ## setup && build && start
all: setup build start

build: ## Build App Docker Images
	  @echo Starting docker build
		@docker/scripts/docker-compose build

create_table: ## Create table using arg "name"
		@echo Creating a table
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/create_table.sh $(name)

help: ## Show this help.
		@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

login: ## Run shell inside App container
		@echo Logging inside App container
		@docker/scripts/docker-compose exec demo sh

logs: ## Show container logs
		@echo Showing docker logs
		@docker/scripts/docker-compose logs

kill: ## Restart App
		@echo Restarting the App
		@docker/scripts/docker-compose exec demo sh /app/code/docker/scripts/kill.sh

rebuild: ## build && restart
rebuild: build restart

restart: ## stop && start
restart: stop start

setup: ## Setup local dev env
		@echo Preparing localhost, keep calm
		virtualenv .docker_env && ./.docker_env/bin/pip install -r reqs/docker.txt
		touch .env

start: ## Start local dev env
		@echo Starting your Docker development environment
		@docker/scripts/docker-compose up -d --remove-orphans

status: ## Local dev env status
		@echo Hey, what is going on?
		@docker/scripts/docker-compose ps

stop: ## Stop local dev env
		@echo Stopping the App
		@docker/scripts/docker-compose down

clean: ## Delete Docker images
		@echo Stopping the App
		@docker/scripts/docker-compose down
		@echo Deleting Docker images
		@docker/scripts/docker-compose rm --force

