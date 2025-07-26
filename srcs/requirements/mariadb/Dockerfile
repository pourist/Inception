FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir /var/run/mysqld && chmod 777 /var/run/mysqld

RUN echo -e "[mysqld]\nskip-host-cache\nskip-name-resolve\nbind-address=0.0.0.0" > /etc/my.cnf.d/docker.cnf \
    && sed -i 's|skip-networking|skip-networking=0|' /etc/my.cnf.d/mariadb-server.cnf

COPY requirements/mariadb/tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER mysql
CMD ["docker-entrypoint.sh"]
