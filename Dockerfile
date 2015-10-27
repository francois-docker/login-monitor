FROM debian:jessie
MAINTAINER François Billant <fbillant@gmail.com>

RUN apt-get update && \
apt-get install -y \
heirloom-mailx

COPY login_monitor.sh /root/login_monitor.sh
RUN chmod +x /root/login_monitor.sh

CMD ["/root/login_monitor.sh"]

