FROM php:8.2-apache

# Install Intl + Zip + Git
RUN apt-get update && apt-get install -y \
    libicu-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install intl zip

# Enable rewrite
RUN a2enmod rewrite

# Copy project
COPY . /var/www/html

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader
