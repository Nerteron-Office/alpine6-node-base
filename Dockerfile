FROM mhart/alpine-node:16

ENV BaseInstallationDir /var/service

RUN apk update && apk add curl make gcc g++ git python3 dnsmasq
RUN echo -e '#!/bin/ash\n ash "$@"' > /bin/bash && chmod +x /bin/bash
RUN npm install -g eyeos-run-server
RUN npm install -g eyeos-tags-to-dns
RUN npm cache clean --force
RUN echo "user=root" > /etc/dnsmasq.conf
RUN curl -L https://releases.hashicorp.com/serf/0.8.2/serf_0.8.2_linux_amd64.zip -o serf.zip
RUN unzip ./serf.zip && mv serf /usr/bin/ && rm ./serf.zip
RUN apk update && apk del curl make gcc g++ git python3
RUN rm -r /etc/ssl /var/cache/apk/*
