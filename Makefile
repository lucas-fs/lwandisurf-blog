migrate:
	docker-compose -f docker-compose-dev.yml exec web python manage.py migrate

makemigrations:
	docker-compose -f docker-compose-dev.yml exec web python manage.py makemigrations

collectstatic:
	docker-compose -f docker-compose-dev.yml exec web python manage.py collectstatic --no-input --clear
	docker-compose -f docker-compose-dev.yml exec web chmod -R 777 staticfiles/

createsuperuser:
	docker-compose -f docker-compose-dev.yml exec web python manage.py createsuperuser

media_permissions:
	docker-compose -f docker-compose-dev.yml exec web chmod -R 777 mediafiles/

stack_up:
	docker-compose -f docker-compose-dev.yml up -d

stack_down:
	docker-compose -f docker-compose-dev.yml down -v

stack_ps:
	docker-compose -f docker-compose-dev.yml ps

stack_logs:
	docker-compose -f docker-compose-dev.yml logs -f

logs_web:
	docker-compose -f docker-compose-dev.yml logs -f web

logs_db:
	docker-compose -f docker-compose-dev.yml logs -f db

logs_ui:
	docker-compose -f docker-compose-dev.yml logs -f ui

db_backup:
	docker-compose -f docker-compose-dev.yml exec db backup.sh

db_restore:
	docker-compose -f docker-compose-dev.yml exec db restore.sh

prod_deploy:
	docker-compose -f docker-compose-prod.yml down -v
	/bin/sleep 3
	docker-compose -f docker-compose-prod.yml up -d --build

prod_deploy-nc:
	docker-compose -f docker-compose-prod.yml down -v
	/bin/sleep 3
	docker-compose -f docker-compose-prod.yml build --no-cache web
	docker-compose -f docker-compose-prod.yml build --no-cache nginx
	docker-compose -f docker-compose-prod.yml up -d

prod_down:
	docker-compose -f docker-compose-prod.yml down -v

prod_createsuperuser:
	docker-compose -f docker-compose-prod.yml exec web python manage.py createsuperuser

reset_postgres_data:
	sudo rm -r volumes/postgres/
	sudo mkdir -p volumes/postgres/

# build_web:
# 	docker-compose -f docker-compose-dev.yml build --no-cache web

# build_db:
# 	docker-compose -f docker-compose-dev.yml build --no-cache db

# build_all:
# 	docker-compose -f docker-compose-dev.yml build --no-cache web
# 	docker-compose -f docker-compose-dev.yml build --no-cache db
