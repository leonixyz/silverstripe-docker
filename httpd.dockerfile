FROM php:8.1.19-apache

ARG MY_UID
ARG MY_GID

RUN apt update -y

RUN apt install -y libicu-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install -j$(nproc) intl

RUN apt install -y zlib1g-dev libpng-dev
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure mysqli
RUN docker-php-ext-install -j$(nproc) mysqli

RUN a2enmod rewrite

RUN usermod -u $MY_UID www-data
RUN groupmod -g $MY_GID www-data

COPY httpd/httpd.conf /etc/apache2/sites-available/000-default.conf