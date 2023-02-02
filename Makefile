PROJECT_DIR = srcs

include $(PROJECT_DIR)/.env
export $(shell sed 's/=.*//' $(PROJECT_DIR)/.env)

DATA_DIRS = $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)

ifeq ($(shell uname), Linux)
SUDO=sudo
else
SUDO=
endif

run up: $(DATA_DIRS)
	docker compose --project-directory $(PROJECT_DIR) up --build -d --remove-orphans

stop down:
	docker compose --project-directory $(PROJECT_DIR) down

$(DATA_DIRS):
	mkdir -p $@

clean:
	docker stop $$(docker ps -qa) 2> /dev/null || exit 0
	docker rm $$(docker ps -qa) 2> /dev/null || exit 0

iclean:
	docker rmi -f $$(docker images -qa) 2> /dev/null || exit 0

fclean: clean iclean
	docker builder prune

ffclean: fclean
	$(SUDO) rm -rf $(VOLUME_DIR)
	docker volume rm $$(docker volume ls -q) 2> /dev/null || exit 0

re: down
	$(SUDO) rm -rf $(VOLUME_DIR)
	$(MAKE) up

rere: fclean re

.PHONY: run up stop down clean iclean fclean
