FROM nginx:1.13-alpine

# Set up HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
    CMD \
    curl -f http://localhost/php-fpm/ping || exit 1

RUN apk add --no-cache curl

# main()
ADD data/nginx.conf /etc/nginx/nginx.conf
ADD data/default.conf /etc/nginx/conf.d/default.conf