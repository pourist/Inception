FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash gettext

RUN mkdir -p /run/mysqld && chmod 777 /run/mysqld

COPY tools/ /docker-entrypoint-init/

ENTRYPOINT ["/docker-entrypoint-init/init.sh"]

CMD ["mysqld"]
