FROM alpine:3.21

RUN apk update && apk add --no-cache nginx openssl

COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf
COPY ./requirements/nginx/conf/default.conf /etc/nginx/conf.d/default.conf

COPY ./requirements/nginx/tools/ppour-ba.42.fr.crt /etc/nginx/ssl/ppour-ba.42.fr.crt
COPY ./requirements/nginx/tools/ppour-ba.42.fr.key /etc/nginx/ssl/ppour-ba.42.fr.key

RUN mkdir -p /var/www/wordpress && \
    mkdir -p /run/nginx && \
    chmod -R 755 /var/www/wordpress

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
