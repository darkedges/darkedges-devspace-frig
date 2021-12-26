# Initial Configuration
FROM alpine:3.14.3

COPY IG-7.1.1.zip /var/tmp/frig.zip

RUN unzip /var/tmp/frig.zip -d /var/tmp/

COPY rootscripts/*.sh  /var/tmp/identity-gateway/

# Runtime deployment
FROM eclipse-temurin:11.0.13_8-jre-alpine

ENV OPENIG_BASE /opt/frig/instance/data

WORKDIR /opt/frig

COPY --from=0 /var/tmp/identity-gateway /opt/frig/

RUN apk add --no-cache tini bash curl jq && \
    addgroup -g 11111 -S forgerock && \
    adduser -h /opt/frig -G forgerock -D -u 11111 forgerock && \
    mkdir -p /opt/frig/instance/data && \
    chown -R forgerock:forgerock /opt/frig && \
    chmod 755 /opt/frig/*.sh

USER 11111

COPY --chown=forgerock:forgerock instance /opt/frig/instance/data/

ENTRYPOINT  ["/opt/frig/docker-entrypoint.sh"]
CMD ["start"]
