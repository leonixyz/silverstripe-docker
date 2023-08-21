# Silverstripe + MariaDB + Traefik in Docker

This is a minimal setup for installing Silverstripe in a dockerized environment

## Setup

1) change domain name from `example.test` to anything else in `docker-compose.yml` and `conf/traefik/base.yml`
2) copy `.env.example` to `.env` and edit appropriately
3) `sudo docker compose up` should do the bootstrapping

## Running composer

Composer is installed in `silverstripe-init` image. Can be executed therein already mounting the volumes appropriately:
```
sudo docker compose run --rm -it silverstripe-init sh
```

## Troubleshooting

### silverstripe-init

Container image `silverstripe-init` might fail upon first run, because it tries to pull down a composer version that does not match the installed PHP packages. In such case, upgrade PHP to match the composer version

### upgrade PHP

The dockerfile for `silverstripe-init` holds a reference to the PHP version used for bootstrapping, and `silverstripe-httpd` is based on the official PHP image from dockerhub, which must be updated as well. If a PHP project is already installed in `./src`, then also the `composer.json` file might have a reference to the PHP version.
