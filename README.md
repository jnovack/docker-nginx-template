# docker-nginx-template

* nginx v1.13-alpine
* php-fpm v7.1-alpine
* storage (alpine:v3.5)

## Preparation

### make keys

Prior to building the containers, you must generate a self-signed certificate to use for the website.  This WILL throw errors in your browser, but should not hinder your development.

```
make keys
```

### make template

To deploy this template, you must pass the domain name of the new application.

```
make DOMAIN=[www.docker.local] template
```

WARNING: This will destroy the `.git/` subdirectory.

#### SSL Client Certificates

If you need SSL Client Certificate verification, you will need a CA certificate and CRL file within `config/`.

```
make DOMAIN=[www.docker.local] opt-ssl
```

#### Laravel

A Laravel instance requires a storage container and some php modules installed, we can easily set that up.

```
make DOMAIN=[www.docker.local] opt-laravel
```

### override production

The `make template` script automatically renamed `docker-compose.override.yml.sample` to `docker-compose.override.yml`. Modify it to your environment.

NOTE: Do not modifying `docker-compose.yml` directly. Doing so will cause conflicts on each update of the repository.  Make all your `docker-compose.yml` changes to your local `docker-compose.override.yml` file.  More information can be found here: https://docs.docker.com/compose/extends/

## Upgrading

If you pull new files, you can either upgrade the entire stack:

```
make build
```

Or, you may just want to upgrade a specific service:

```
make CONTAINER=nginx build
```

## Management

### make test

Pre-flight check.

### make logs

Tail the logs of all containers.

### make CONTAINER=[name] restart

Restart a specific container.

### make CONTAINER=[name] exec

Execute /bin/sh into a specific container.
