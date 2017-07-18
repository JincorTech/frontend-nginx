FROM smebberson/alpine-nginx

ADD ./config/nginx.conf /etc/nginx/

ARG CONF_PATTERN=frontend*
ENV CONF_PATTERN ${CONF_PATTERN}


COPY ./config/sites/${CONF_PATTERN} /etc/nginx/sites-available/

VOLUME /var/apps/cmp
VOLUME /var/apps/msg
VOLUME /var/apps/landing
VOLUME /var/apps/ico

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && adduser -D -S -G www-data -H -u 82 -s /bin/bash www-data \
    && rm /etc/nginx/conf.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443
