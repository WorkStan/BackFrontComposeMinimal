FROM php:8.1-fpm-alpine

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

RUN apk --update add wget \
  git \
  curl \
  libpq-dev \
  libpng-dev \
  libxml2-dev \
  zip \
  unzip

RUN rm /var/cache/apk/*

RUN docker-php-ext-install pdo pdo_pgsql pgsql exif pcntl bcmath gd

WORKDIR /app
