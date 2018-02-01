# docker_nagios
Dockerfile for nagios with systemd


Build :
docker build -t jmilot/jessie_nagios 

Start :
docker run -d --name systemd --security-opt seccomp=unconfined --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro jmilot/jessie_nagios
