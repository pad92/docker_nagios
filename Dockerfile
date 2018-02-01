FROM debian:jessie
LABEL maintainer="jean.milot"

EXPOSE 22

RUN apt-get update && apt-get install -y \
    apt-utils \
    wget \
    build-essential \
    libgd2-xpm-dev \
    openssl \
    libssl-dev \
    xinetd \
    apache2-utils \
    unzip \
    openssh-server \
    curl \
    less \
    vim \
    && apt-get clean

RUN cd /usr/local/src && wget https://downloads.sourceforge.net/project/nagios/nagios-4.x/nagios-4.3.4/nagios-4.3.4.tar.gz && tar xf nagios-4.3.4.tar.gz

RUN useradd nagios && groupadd nagcmd && usermod -a -G nagcmd nagios

RUN cd /usr/local/src/nagios-4.3.4/ && ./configure --with-nagios-group=nagios --with-command-group=nagcmd && make all && make install && make install-commandmode && make install-init && make install-config
RUN cd /usr/local/src && wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz && tar xf nagios-plugins-2.2.1.tar.gz
RUN cd /usr/local/src/nagios-plugins-2.2.1 && ./configure --with-nagios-user=nagios --with-nagios-group=nagios --prefix=/usr/local/nagios/ && make && make install
RUN rm /usr/local/src/*tar.gz

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN mkdir -p ~nagios/.ssh && chmod 700 ~nagios/.ssh
ADD ssh/ /home/nagios/.ssh/
ADD nagios/ /usr/local/nagios/etc/
RUN chown nagios: ~nagios -R && chown nagios: /usr/local/nagios/etc/* -R



RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;

RUN systemctl set-default multi-user.target

RUN systemctl enable ssh && systemctl enable nagios

CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]
