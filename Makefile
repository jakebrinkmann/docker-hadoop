#-----------------------------------------------------------------------------
# Makefile
#
# Simple makefile for creating a development instance 
#-----------------------------------------------------------------------------
.PHONY: build up down j-master j-slave

build:
	docker build -t hadoop-base ./base/
up: 
	docker-compose up -d
down:
	docker-compose down
j-master:
	docker exec -it hadoop-master /bin/bash
j-slave:
	docker exec -it hadoop-slave1 /bin/bash

