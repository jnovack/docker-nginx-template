.PHONY: keys build up down logs all test
.DEFAULT_GOAL := all

CONTAINER?=
DOMAIN?=docker.local

all: test up logs

keys:
	openssl req -x509 -nodes -newkey rsa:4096 -keyout config/key.pem -out config/certificate.pem -days 720 -subj "/C=US/ST=Pennsylvania/L=Bensalem/O=DEVELOPMENT/OU=parx Casino/CN=${DOMAIN}"

customize:
	@sed -i '' "s/docker-nginx-template/${DOMAIN}/" README.md
	@sed -i '' "s/docker-nginx-template/${DOMAIN}/" docker-compose.override.yml.sample
	@sed -i '' "s/docker-nginx-template/${DOMAIN}/" docker-compose.yml
	@cp docker-compose.override.yml.sample docker-compose.override.yml
	@rm -rf .git/
	@echo "Please modify docker-compose.override.yml with your personalizations."

build:
	docker-compose rm -sfv ${CONTAINER} || true
	docker-compose up --build -d ${CONTAINER}

up:
	docker-compose up -d ${CONTAINER}

down:
	docker-compose rm -sfv ${CONTAINER} || true

logs:
	docker-compose logs -f

restart:
	docker-compose restart ${CONTAINER} || true

exec:
	docker-compose exec ${CONTAINER} /bin/sh || true

test:
	@test -f config/key.pem || (echo "ERROR: key.pem does not exist." && exit 1)
	@test -f config/certificate.pem || (echo "ERROR: certificate.pem does not exist." && exit 1)
	@test -f config/website.conf || (echo "ERROR: website.conf does not exist." && exit 1)