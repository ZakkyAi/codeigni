FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    zip unzip git curl \
    && docker-php-ext-install mysqli pdo pdo_mysql

RUN a2enmod rewrite

# Apache config
RUN printf "<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>\n" \
> /etc/apache2/sites-available/000-default.conf

# Copy project
COPY . /var/www/html
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install vendor (WAJIB untuk CI4)
RUN composer install --no-dev --optimize-autoloader

# Permission
RUN chmod -R 775 writable \
    && chown -R www-data:www-data writable

EXPOSE 80
