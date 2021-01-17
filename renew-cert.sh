#!/bin/bash

COMPOSE="/usr/local/bin/docker-compose --no-ansi"

cd /home/ec2-user/nibble_group/
$COMPOSE run certbot certonly  && $COMPOSE kill -s SIGHUP webserver
