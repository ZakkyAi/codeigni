FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    zip unzip git curl \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Enable mod_rewrite
RUN a2enmod rewrite

# Set Apache DocumentRoot ke folder public CodeIgniter 4
RUN echo '<VirtualHost *:80>
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Copy project ke container
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Permission folder CI4
RUN chmod -R 775 writable \
    && chown -R www-data:www-data writable

EXPOSE 80
