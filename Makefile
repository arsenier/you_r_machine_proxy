include .env

docker-run:
	docker-compose up -d

db-install:
	docker-compose exec pgsql createdb -U sail ms_courses
	docker-compose exec ms.courses php artisan migrate
	docker-compose exec pgsql createdb -U sail ms_auth
	docker-compose exec ms.auth php artisan migrate --seed

passport-install:
	docker-compose exec ms.auth php artisan passport:install

install:
	make docker-run
	make db-install
	make passport-install

remove:
	docker-compose down
	docker volume rm api-gateway_apppgsql
