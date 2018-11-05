FROM jenkins/jenkins:lts
USER root

RUN \
    echo "Updating apt sources." && \
    apt-get -qq update && \
    echo "Installing required packages." && \
    apt-get -qq install \
        apt-transport-https \
        ca-certificates \
        curl \
        groff \
        postgresql-client \
        software-properties-common

RUN \
    echo "Adding Docker apt key." && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN \
    echo "Installing Docker Community Edition." && \
    apt-get -qq update && \
    apt-get -qq install docker-ce

RUN \
    echo "Installing Docker Compose." && \
    curl \
        -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` \
        -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN \
    echo "Installing AWS CLI." && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip3 install awscli

RUN mkdir -p /var/build
USER jenkins
