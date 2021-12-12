# Initial Configuration
FROM alpine:3.14.3

COPY IG-7.1.1.zip /var/tmp/frig.zip

RUN unzip /var/tmp/frig.zip -d /var/tmp/

COPY rootscripts/*.sh  /var/tmp/identity-gateway/

# Runtime deployment
FROM adoptopenjdk/openjdk11-openj9:x86_64-alpine-jdk-11.0.11_9_openj9-0.26.0-slim

ENV OPENIG_BASE /opt/frig/instance/data

WORKDIR /opt/frig

COPY --from=0 /var/tmp/identity-gateway /opt/frig/

RUN apk add --no-cache tini bash curl jq && \
    addgroup -g 11111 -S forgerock && \
    adduser -h /opt/frig -G forgerock -D -u 11111 forgerock && \
    mkdir -p /opt/frig/instance/data/config && \
    chown -R forgerock:forgerock /opt/frig && \
    chmod 755 /opt/frig/*.sh

USER 11111

COPY --chown=forgerock:forgerock config/*  /opt/frig/instance/data/config/

ENTRYPOINT  ["/opt/frig/docker-entrypoint.sh"]
CMD ["start"]