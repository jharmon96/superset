#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -e

##############################################
#######    Setup superset databases    #######
##############################################
apt-get update
apt-get install postgresql-client -y

echo "Creating superset primary database..."
# Create backend database if it doesn't already exist
export PGPASSWORD=${POSTGRES_PASSWORD}; psql -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USER} -d postgres <<-EOSQL
    SELECT 'CREATE DATABASE superset_primary' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'superset_primary')
EOSQL
echo "SELECT 'CREATE DATABASE superset_primary' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'superset_primary')\gexec" \
| psql -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USER} -d postgres
echo "Database created or already exists"

echo "Creating superset secondary database..."
# Create backend database if it doesn't already exist
export PGPASSWORD=${POSTGRES_PASSWORD}; psql -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USER} -d postgres <<-EOSQL
    SELECT 'CREATE DATABASE superset_secondary' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'superset_secondary')
EOSQL
echo "SELECT 'CREATE DATABASE superset_secondary' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'superset_secondary')\gexec" \
| psql -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USER} -d postgres
echo "Database created or already exists"

##############################################
##########   Init superset tables   ##########
##############################################
superset db upgrade

superset fab create-admin \
    --username admin \
    --firstname Superset \
    --lastname Admin \
    --email admin@superset.com \
    --password ${SUPERUSER_PASSWORD}


##############################################
############    Start superset    ############
##############################################
superset init
