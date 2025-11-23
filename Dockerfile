FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    zip unzip git curl libicu-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql intl

RUN a2enmod rewrite

# Apache DocumentRoot
RUN printf "<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>\n" \
> /etc/apache2/sites-available/000-default.conf

# Copy source
COPY . /var/www/html
WORKDIR /var/www/html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Permission
RUN chmod -R 775 writable \
    && chown -R www-data:www-data writable

EXPOSE 80
