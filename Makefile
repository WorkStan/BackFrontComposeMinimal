fresh-install-laravel: down clear-backend-folder laravel-clone-new init

composer-install-laravel: down-clear clear-backend-folder pull build up laravel-composer-new permissions

clear-backend-folder:
	sudo rm -rf ./backend && mkdir backend

laravel-composer-new:
	docker compose run --rm backend-php-cli composer create-project laravel/laravel .

laravel-clone-new:
	git clone git@github.com:laravel/laravel.git ./backend

init: down-clear pull build up app-init
test: app-test

up:
	docker compose up -d

down:
	docker compose down --remove-orphans

pull:
	docker compose pull

build:
	docker compose build --pull

down-clear:
	docker compose down --remove-orphans --volumes

app-init: composer-install copy-env key-generate permissions

migrate:
	docker compose run --rm backend-php-cli php artisan migrate

composer-install:
	docker compose run --rm backend-php-cli composer install

composer-dump:
	docker compose run --rm backend-php-cli composer dump-autoload

copy-env:
	[ -f ./backend/.env ] || cp backend/.env.example backend/.env

key-generate:
	docker compose run --rm backend-php-cli php artisan key:generate

permissions:
	sudo chmod -R ug+rwx backend/storage backend/bootstrap/cache
	sudo chgrp -R 82 backend/storage backend/bootstrap/cache

app-test:
	docker compose run --rm backend-php-cli php artisan test
