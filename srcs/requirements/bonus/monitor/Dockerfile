FROM alpine:3.21

RUN apk update && apk add --no-cache netdata

EXPOSE 19999

CMD ["/usr/sbin/netdata", "-D"]
