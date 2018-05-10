FROM alpine:3.6
USER root

RUN curl https://getcaddy.com | bash -s personal

RUN mkdir /caddy-data

VOLUME [ "/root/.caddy" ]

COPY ./Caddyfile /etc/Caddyfile

ENTRYPOINT ["caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
