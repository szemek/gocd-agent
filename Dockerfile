FROM phusion/baseimage:0.9.22

ENV TERM xterm

RUN apt update -qq && apt install -y build-essential

RUN echo "deb https://download.gocd.io /" > /etc/apt/sources.list.d/gocd.list
RUN curl https://download.gocd.io/GOCD-GPG-KEY.asc | apt-key add -
RUN apt update
RUN apt install -y openjdk-8-jre-headless
RUN apt install -y go-agent
RUN apt install -y git wget htop ncdu tree unzip mysql-client
RUN su - go -c 'mkdir -p /var/go/.ssh'
RUN su - go -c 'ssh-keyscan github.com > /var/go/.ssh/known_hosts'

ADD files/etc/my_init.d/*.sh /etc/my_init.d/
RUN chmod 0755 /etc/my_init.d/*.sh

# Python
RUN apt install -y python-minimal

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
RUN yarn global add bower gulp

# PHP
RUN add-apt-repository ppa:ondrej/php
RUN apt update
RUN apt install -y --force-yes php7.0-common php7.0-cli php7.0-cgi php7.0-intl php7.0-fpm php7.0-mysql php7.0-curl php7.0-xml php7.0-bcmath php7.0-mcrypt php7.0-mbstring php7.0-gd php7.0-zip

CMD ["/sbin/my_init"]
