FROM alpine:3.7

# Get HTTPS support
RUN apk update \
    && apk add wget ca-certificates \
    && update-ca-certificates

ENV OS=linux \
    ARCH=amd64 \
    PLUGINS=http.jwt,http.nobots,http.ratelimit,http.realip,tls.dns.cloudflare

# Install Caddy server
RUN mkdir -p /usr/local/src/caddy \
    && wget "https://caddyserver.com/download/${OS}/${ARCH}?plugins=${PLUGINS}&license=personal" -O /tmp/caddy.tar.gz \
    && tar -C /usr/local/src/caddy -xvzf /tmp/caddy.tar.gz \
    && chmod +x /usr/local/src/caddy/caddy \
    && ln -s /usr/local/src/caddy/caddy /usr/local/bin/caddy

VOLUME [ "/root/.caddy" ]

COPY ./Caddyfile /etc/Caddyfile

EXPOSE 80 443

ENTRYPOINT ["caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
