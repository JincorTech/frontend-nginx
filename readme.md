# Frontend NGINX service
This service is used to redirect requests across frontend-applications.
It also contains configuration and scripts for ICO/Beta landings deployment (with letsencrypt certbot).

## Project structure:

* `config/includes` - configurations that are shared between other configs (ssl/non-ssl)
* `config/sites` - non-ssl configurations
* `config/ssl` - ssl configurations

## Available configurations:

1. frontend/stage - frontend for "Companies" service. Currently, it's configured to route between 3 applications:

* `/` - landing page
* `/cmp` - companies domain application
* `/msg` - messenger domain application

2. Landings:

* `ico.jincor.com` - ICO landing.
* `jincor.com` - Beta landing.
* `www.jincor.com` - redirects to jincor.com
* `api.jincor.com` - reverse proxy for companies backend.

## How to

1. Create new Dockerfile if necessary.
1. Create a config at `config/sites` directory.
1. Also create ssl config if necessary at `config/ssl`. If you use certbot specify following paths to key and certificate chain:
ssl_certificate    /etc/letsencrypt/live/your.domain.com/fullchain.pem;
ssl_certificate_key    /etc/letsencrypt/live/your.domain.com/privkey.pem;
1. If you plan to use lets encrypt include `/etc/nginx/includes/acme.inc.conf` in your non-ssl config.
1. Symlink non-ssl config to `/etc/nginx/sites-available` in Dockerfile.
1. Build container.
1. This and next items are only required to enable SSL! Run:
`certbot certonly --webroot -w /var/apps/acme -d your.domain.com -m your@email.com -n --agree-tos`
1. rm non-ssl symlink from `/etc/nginx/sites-available`
1. Symlink ssl config to `/etc/nginx/sites-available`
1. Reload nginx: `nginx -s reload`