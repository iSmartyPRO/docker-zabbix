#!/bin/bash
source .env

echo "Creating database: ${DEPLOY_DATABASE_NAME}"
mysql -u${DEPLOY_DATABASE_USER} -p${DEPLOY_DATABASE_PASS} -h ${DEPLOY_DATABASE_IP} -e "CREATE DATABASE ${DEPLOY_DATABASE_NAME} CHARACTER SET utf8 COLLATE utf8_bin;"

echo "Creating user: ${MYSQL_USER}"
mysql -u${DEPLOY_DATABASE_USER} -p${DEPLOY_DATABASE_PASS} -h ${DEPLOY_DATABASE_IP} -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

echo "Assigning permissions to user"
mysql -u${DEPLOY_DATABASE_USER} -p${DEPLOY_DATABASE_PASS} -h ${DEPLOY_DATABASE_IP} -e "GRANT ALL PRIVILEGES ON ${DEPLOY_DATABASE_NAME}.* TO '${MYSQL_USER}'@'%';"

echo "Flush privileges"
mysql -u${DEPLOY_DATABASE_USER} -p${DEPLOY_DATABASE_PASS} -h ${DEPLOY_DATABASE_IP} -e -e "FLUSH PRIVILEGES;"