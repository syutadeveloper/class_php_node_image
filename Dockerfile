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

# Установка sass
RUN npm install -g sass

# install xdebug
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug

COPY php.ini /usr/local/etc/php

# Вклбчно apache rewrite
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

# установка composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
