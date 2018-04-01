#Infra

This repo describes the infrastructure I'm using for my personal projects

##Overview

Requires minikube and kubectl as described in https://github.com/kubernetes/minikube

Use minikube as the local docker registry

	minikube start
	eval $(minikube docker-env)
	docker build -t reddit_web .

to run a docker registry

	docker run -d -p 5000:5000 --name registry registry:2


pod
	- group of co-located containers

	kubectl apply -f ~/code/reddit/deployment.yml
	kubectl get deployments
	kubectl get pods
	kubectl describe pod XXXXX
	kubectl logs XXXXXX
	kubectl exec -it XXXXX -- bash
	kubectl delete deployment,svc reddit
	curl $(minikube ip):31704


###Elastic Container Service:

This server is configured using Amazon's point-and click interface.

- size: t2.micro (~$10 / mo)
- ami: whatever amazon wants
- ip: 13.210.35.9
- id: wizard.pem
- vpc: vpc-9816a7ff
- subnet: subnet-6bd4a50c
- internal ip: 10.0.1.31
- container repo: 535254746276.dkr.ecr.ap-southeast-2.amazonaws.com
    - reddit

    ssh -i ~/.ssh/wizard.pem ec2-user@13.210.35.9



###NGINX

NGINX is installed on the EC2 instance that hosts ECS. It uses static port mapping to route requests to containers:

```
SERVICE 	EXTERNAL PORT	INTERNAL PORT 	CONTAINER PORT

reddit		80				8000			8000
```

###Database:

This is an EC2 t2.nano image.

- size: t2.nano (~$5 / mo)
- storage: 8GB SSD
- ami: Ubuntu 16.04
- ip: 13.55.127.139
- vpc: vpc-9816a7ff
- subnet: subnet-6bd4a50c
- internal ip: 10.0.1.135
- id: wizard.pem

    ssh root@13.55.127.139

To acces psql

	su - postgres
	psql


##Ansible

Ansible config lives in `ansible/`

Ansible current deploys postgres to the db server and NGINX to the ECS server.

To encrypt secrets:

    cp secrets.secret.yml secrets.yml
    ansible-vault encrypt secrets.yml --vault-password-file ~/.vault-pass.txt

To deploy with secrets

    ./deploy.sh
