# Swarm Infrastructure

This repo describes the infrastructure I'm using for my personal projects

## Overview

A single DigitalOcean droplet runs:

- NGINX server
- Postgres database
- Docker swarm
- Docker registry

## Docker Swarm

Docker swarm hosts the application containers ([example](https://github.com/MattSegal/link-sharing-site/)) as 'stacks', generated from a docker-compose file. Web containers publish a static port for NGINX.

To deploy an application

    ./deploy.sh $APP_NAME

## Docker Registry

To run a docker registry on the host VM

	docker run -d -p 5000:5000 --name registry registry:2

It uses a docker volume somewhere to store the built containers. Hopefully this doesn't chew through all my disk space.

### NGINX

NGINX is installed on the host server. It uses static port mapping to route requests to containers.
HTTPS is enabled via NGINX using the LetsEncrypt certbot for the certificate

Create cert

    certbot --nginx -d memories.ninja
    openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 4096

Renew expiring cert

    certbot renew

To flush dns cache

    sudo /etc/init.d/dns-clean restart
    sudo /etc/init.d/networking force-reload

### Database:

Postgres is installed on the host server. Each service has its own database.

To acces psql

	su - postgres
	psql

To restore a database dump

    pg_restore -n public --clean -j 2 -d $DB_NAME -p $DB_PORT -h $DB_HOST -U $DB_USER --no-owner $BACKUP_SQL_FILE

## Ansible

Ansible config lives in `ansible/`

Ansible currently configures postgres and NGINX on the host server.

To encrypt secrets:

	./scripts/encrypt-secrets.sh

To configure the docker host VM with secrets

    ./scripts/configure.sh

To take database backups

    ./scripts/backup.sh

## To Do

- Try make secrets a traversible data structure
- Add docker install to Ansible
- Add docker swarm setup
- Add docker registry service to Ansible
- Setup non shitty automated build / deploy pipelines for projects
