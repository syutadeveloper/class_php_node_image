FROM php:8.3-apache

WORKDIR /var/www/html

# Обновите список пакетов и установите необходимые библиотеки и инструменты.
# Установите расширения PHP в конце.
# docker-php-ext-install - это скрипт, включенный в официальный PHP Docker image
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    nodejs \
    npm \
    yarn \
    libonig-dev \

  && apt-get clean \
  && docker-php-ext-install zip pdo_mysql mysqli 

# install xdebug
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug

COPY php.ini /usr/local/etc/php
