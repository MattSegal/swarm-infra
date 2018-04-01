# Swarm Infrastructure

This repo describes the infrastructure I'm using for my personal projects

## Overview

A single DigitalOcean droplet runs:

- NGINX server
- Postgres database
- Docker swarm
- Docker registry

## Docker Registry

To run a docker registry

	docker run -d -p 5000:5000 --name registry registry:2

It uses a docker volume somewhere to store the built containers. Hopefully this doesn't chew through all my disk space.

## Docker Swarm

Docker swarm hosts the application containers as 'stacks', generated from a docker-compose file. Web containers publish a static port for NGINX.

To deploy an application

	    ./deploy.sh $APP_NAME

### NGINX

NGINX is installed on the host server. It uses static port mapping to route requests to containers.

### Database:

Postgres is installed on the host server. Each service has its own database. Backups are taken daily and stored in S3.

To acces psql

	su - postgres
	psql


## Ansible

Ansible config lives in `ansible/`

Ansible currently configures postgres and NGINX on the host server.

To encrypt secrets:

	./encrypt-secrets.sh

To deploy with secrets

    ./configure.sh
