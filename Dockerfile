FROM nginx:1.13.0-alpine

RUN mkdir -p /usr/src/app/dist

COPY config/default.conf /etc/nginx/conf.d/
