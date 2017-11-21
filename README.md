Demo for the DevOps [Evening event](https://artjoker.ua/ru/big-brain-club-devops/)

### Demo App

`demo.py` is a http server which binds to port 8000 and returning the list of tables in the specific mysql database.

#### Configuration

App gets its configuration via envrimoment variables:

| Variable        | Description       |
| --------------- | ----------------- |
| DEMO_MYSQL_HOST | mysql server host |
| DEMO_MYSQL_PORT | mysql server port |
| DEMO_MYSQL_DB   | mysql database    |
| DEMO_MYSQL_USER | mysql user        |
| DEMO_MYSQL_PASS | mysql user pass   |


### How to start an app

1. `make setup` - prepare your env for the demo
2. `make build` - build demo App Docker Image
3. `make start` - start the App

or just `make`

### How to debug it

1. `make logs` - show the logs
2. `make status` - show the status of containers
3. `make kill` - restart the App


