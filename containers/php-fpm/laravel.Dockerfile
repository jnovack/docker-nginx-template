FROM php:7.1-fpm-alpine

# Set up HEALTHCHECK
RUN apk add --update --no-cache fcgi && \
    echo "ping.path = /php-fpm/ping" > /usr/local/etc/php-fpm.d/healthcheck.conf && \
    echo "pm.status_path = /php-fpm/status" >> /usr/local/etc/php-fpm.d/healthcheck.conf

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
    CMD \
    SCRIPT_NAME=/ping \
    SCRIPT_FILENAME=/ping \
    REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

# main()
RUN apk add --update --no-cache \
        build-base \
        autoconf \
        libtool \
        libxml2-dev

RUN docker-php-ext-configure pdo_mysql

RUN pecl config-set php_ini /usr/local/etc/php/php.ini && \
    pecl install igbinary && \
    pecl clear-cache

RUN docker-php-ext-enable igbinary

RUN docker-php-ext-install pdo_mysql soap

RUN docker-php-source delete

# Customization
#   * Remove access logging for php-fpm
#   * Add error logging for php-fpm
#   * Change processes to 'ondemand'
#   * Only listen on IPv4 sockets
#   * Set max_children up a lil' higher
ADD data/php.ini /usr/local/etc/php/php.ini
RUN sed -i '/access.log/d' /usr/local/etc/php-fpm.d/docker.conf && \
    sed -i 's/pm = dynamic/pm = ondemand/' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/listen = \[::\]:9000/listen=0.0.0.0:9000/' /usr/local/etc/php-fpm.d/zz-docker.conf && \
    sed -i 's/max_children = 5/max_children = 10/' /usr/local/etc/php-fpm.d/www.conf