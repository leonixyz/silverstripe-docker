FROM php:8.3-apache

ARG MY_UID
ARG MY_GID

RUN apt update -y

RUN apt install -y libicu-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install -j$(nproc) intl

RUN apt install -y zlib1g-dev libpng-dev libjpeg62-turbo-dev libfreetype-dev
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure mysqli
RUN docker-php-ext-install -j$(nproc) mysqli

RUN a2enmod rewrite

RUN usermod -u $MY_UID www-data
RUN groupmod -g $MY_GID www-data

RUN echo "upload_max_filesize = 32M" > $PHP_INI_DIR/conf.d/upload_max_filesize.ini
RUN echo "post_max_size = 32M" > $PHP_INI_DIR/conf.d/post_max_size.ini
