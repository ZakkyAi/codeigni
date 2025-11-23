FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install intl zip

RUN a2enmod rewrite
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set Apache DocumentRoot ke folder public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Ubah konfigurasi Apache agar DocumentRoot menjadi /public
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/public!g' /etc/apache2/apache2.conf

# Copy semua kode
COPY . /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader

# Jalankan sesuai port Railway
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
