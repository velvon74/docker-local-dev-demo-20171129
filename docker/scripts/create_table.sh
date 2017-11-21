#!/bin/sh

export MYSQL_PWD=${DEMO_MYSQL_PASS}
echo "create table $1 (a int)" | mysql \
  -h ${DEMO_MYSQL_HOST} \
  -P ${DEMO_MYSQL_PORT} \
  -u ${DEMO_MYSQL_USER} \
  ${DEMO_MYSQL_DB}
