ARG VERSION=8.0

FROM php:${VERSION}-fpm

COPY php.ini /usr/local/etc/php/conf.d/app.ini
COPY fpm.conf /usr/local/etc/php-fpm.d/

RUN apt-get update
RUN apt-get install -y libpq-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev libicu-dev libzip-dev && rm -rf /var/lib/apt/lists/*

# Configure and install PostgreSQL PDO extensions
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo pdo_pgsql pgsql
# Configure and install MySQL PDO extensions
RUN docker-php-ext-configure pdo_mysql
RUN docker-php-ext-install pdo_mysql
# Configure and install GD extension
RUN docker-php-ext-configure gd
RUN docker-php-ext-install gd
# Install zip and exif
RUN docker-php-ext-install zip exif
# Install Intl extension
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
# Install Redis extension
RUN pecl install -o -f redis && rm -rf /tmp/pear
RUN docker-php-ext-enable redis

# Install Composer
COPY install-composer.sh .
RUN chmod +x install-composer.sh
RUN ./install-composer.sh
RUN rm ./install-composer.sh

# Configure non-root user.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

WORKDIR /var/www
