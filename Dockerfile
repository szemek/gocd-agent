FROM phusion/baseimage:0.9.22

ENV TERM xterm

RUN apt-get update -qq && apt-get install -y build-essential

RUN echo "deb https://download.gocd.io /" > /etc/apt/sources.list.d/gocd.list
RUN curl https://download.gocd.io/GOCD-GPG-KEY.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y openjdk-8-jre-headless
RUN apt-get install -y go-agent
RUN apt-get install -y git
RUN su - go -c 'mkdir -p /var/go/.ssh'
RUN su - go -c 'ssh-keyscan github.com > /var/go/.ssh/known_hosts'

ADD files/etc/my_init.d/01_gocd_agent.sh /etc/my_init.d/01_gocd_agent.sh
RUN chmod 0755 /etc/my_init.d/01_gocd_agent.sh

ADD files/etc/my_init.d/02_ssh_key.sh /etc/my_init.d/02_ssh_key.sh
RUN chmod 0755 /etc/my_init.d/02_ssh_key.sh

# Python
RUN apt-get install -y python-minimal

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# PHP
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y --force-yes php7.0-common php7.0-cli php7.0-cgi php7.0-intl php7.0-fpm php7.0-mysql php7.0-curl php7.0-xml php7.0-bcmath php7.0-mcrypt php7.0-mbstring php7.0-gd

CMD ["/sbin/my_init"]
