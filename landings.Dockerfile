FROM smebberson/alpine-nginx

VOLUME /var/apps/cmp
VOLUME /var/apps/msg
VOLUME /var/apps/landing
VOLUME /var/apps/ico
VOLUME /var/apps/acme/.well-known

ADD ./config/nginx.conf /etc/nginx/
ADD ./enable.ssl.sh /etc/nginx/
RUN chmod +x /etc/nginx/enable.ssl.sh

COPY ./config/includes /etc/nginx/includes
COPY ./config/sites /etc/nginx/sites
COPY ./config/ssl /etc/nginx/ssl

RUN mkdir /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites/api.jincor.com.conf /etc/nginx/sites-available/api.jincor.com.conf
RUN ln -s /etc/nginx/sites/ico.jincor.com.conf /etc/nginx/sites-available/ico.jincor.com.conf
RUN ln -s /etc/nginx/sites/www.jincor.com.conf /etc/nginx/sites-available/www.jincor.com.conf
RUN ln -s /etc/nginx/sites/jincor.com.conf /etc/nginx/sites-available/jincor.com.conf

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && apk add --no-cache openssl \
    && apk add --no-cache certbot \
    && adduser -D -S -G www-data -H -u 82 -s /bin/bash www-data \
    && rm /etc/nginx/conf.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

RUN openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 4096

EXPOSE 80 443
