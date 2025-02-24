FROM php:8.2-apache

# Abilita mod_rewrite per Apache
RUN a2enmod rewrite

# Installazione estensioni PHP aggiuntive (modifica secondo necessità)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip mysqli pdo pdo_mysql

# Copia la configurazione personalizzata di PHP
COPY php.ini /usr/local/etc/php/php.ini

# Imposta la directory di lavoro
WORKDIR /var/www/html