FROM nginx:1.13.0-alpine

RUN mkdir -p /usr/src/companies/dist
RUN mkdir -p /usr/src/messenger/dist
RUN mkdir -p /usr/src/landing/dist

COPY config/default.conf /etc/nginx/conf.d/
