FROM alpine:3.6
USER root

RUN apk add --no-cache curl

RUN curl https://getcaddy.com | sh -s personal

RUN mkdir /caddy-data

VOLUME [ "/root/.caddy" ]

COPY ./Caddyfile /etc/Caddyfile

ENTRYPOINT ["caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
