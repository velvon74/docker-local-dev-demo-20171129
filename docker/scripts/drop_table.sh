#!/bin/sh

export MYSQL_PWD=${DEMO_MYSQL_PASS}
mysql \
  -h ${DEMO_MYSQL_HOST} \
  -P ${DEMO_MYSQL_PORT} \
  -u ${DEMO_MYSQL_USER} \
  ${DEMO_MYSQL_DB} \
  -e "DROP TABLE $1"
 
