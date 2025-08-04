FROM alpine:3.21

RUN apk update && apk add --no-cache python3

WORKDIR /site

COPY index.html .

EXPOSE 8000

CMD ["python3", "-m", "http.server", "8000"]