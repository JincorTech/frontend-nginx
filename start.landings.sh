#!/usr/bin/with-contenv sh
sed 's@API_HOST@'"$API_HOST"'@' /etc/nginx/templates/api.jincor.com.tpl.conf > /etc/nginx/includes/api.jincor.com.inc.conf
exec nginx;