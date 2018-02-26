FROM alpine:3.6
LABEL maintainer="Pascal A. <pascalito@gmail.com>" \
      org.label-schema.url="https://github.com/pad92/docker_nagios/blob/master/README.md" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url="https://github.com/pad92/docker_nagios.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="Ansible on alpine docker image" \
      org.label-schema.schema-version="1.0"

RUN apk --update add \
        nagios \
        nagios-plugins \
        nagios-plugins-mrtg \ 
        nagios-plugins-smtp \ 
        nagios-plugins-icmp \ 
        nagios-plugins-snmp \ 
        nagios-plugins-log \ 
        nagios-plugins-disk_smb \ 
        nagios-plugins-ups \ 
        nagios-plugins-dhcp \ 
        nagios-plugins-breeze \ 
        nagios-plugins-ircd \ 
        nagios-plugins-tcp \ 
        nagios-plugins-uptime \ 
        nagios-plugins-cluster \ 
        nagios-plugins-swap \ 
        nagios-plugins-mysql \ 
        nagios-plugins-time \ 
        nagios-plugins-ldap \ 
        nagios-plugins-nt \ 
        nagios-plugins-ping \ 
        nagios-plugins-by_ssh \ 
        nagios-plugins-dns \ 
        nagios-plugins-mrtgtraf \ 
        nagios-plugins-disk \ 
        nagios-plugins-wave \ 
        nagios-plugins-mailq \ 
        nagios-plugins-real \ 
        nagios-plugins-rpc \ 
        nagios-plugins-ifoperstatus \ 
        nagios-plugins-users \ 
        nagios-plugins-procs \ 
        nagios-plugins-ide_smart \ 
        nagios-plugins-nwstat \ 
        nagios-plugins-http \ 
        nagios-plugins-fping \ 
        nagios-plugins-dig \ 
        nagios-plugins-radius \ 
        nagios-plugins-sensors \ 
        nagios-plugins-hpjd \ 
        nagios-plugins-ifstatus \ 
        nagios-plugins-overcr \ 
        nagios-plugins-nagios \ 
        nagios-plugins-all \ 
        nagios-plugins-ntp \ 
        nagios-plugins \ 
        nagios-plugins-dbi \ 
        nagios-plugins-pgsql \ 
        nagios-plugins-ssh \ 
        nagios-plugins-load \ 
        nagios-plugins-dummy \ 
        nagios-plugins-file_age \
        busybox

USER nagios
CMD /usr/sbin/nagios /etc/nagios/nagios.cfg
