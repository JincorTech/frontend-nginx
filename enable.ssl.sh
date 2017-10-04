#!/bin/bash
certbot certonly --webroot -w /var/apps/acme -d jincor.com -d www.jincor.com -d api.jincor.com -m tech@jincor.com -n --agree-tos

rm /etc/nginx/sites-available/api.jincor.com.conf
rm /etc/nginx/sites-available/www.jincor.com.conf
rm /etc/nginx/sites-available/jincor.com.conf

ln -s /etc/nginx/ssl/api.jincor.com.ssl.conf /etc/nginx/sites-available/api.jincor.com.ssl.conf
ln -s /etc/nginx/ssl/www.jincor.com.ssl.conf /etc/nginx/sites-available/www.jincor.com.ssl.conf
ln -s /etc/nginx/ssl/jincor.com.ssl.conf /etc/nginx/sites-available/jincor.com.ssl.conf
nginx -s reload
