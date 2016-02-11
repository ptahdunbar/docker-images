FROM mysql:5.7

LABEL VERSION=1.3.0

MAINTAINER Pirate Dunbar <yarr@piratedunbar.com>

EXPOSE 3306

COPY ./mysql-run.sh /mysql-run.sh
RUN chmod +x /mysql-run.sh

CMD ["./mysql-run.sh"]
