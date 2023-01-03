PROJECT_DIR = srcs

include $(PROJECT_DIR)/.env
export $(shell sed 's/=.*//' $(PROJECT_DIR)/.env)

$(info $(VOLUME_DIR))

run up:
	docker compose --project-directory $(PROJECT_DIR) up --build -d --remove-orphans

stop down:
	docker compose --project-directory $(PROJECT_DIR) down

clean:
	docker stop $$(docker ps -qa) 2> /dev/null || exit 0
	docker rm $$(docker ps -qa) 2> /dev/null || exit 0

iclean:
	docker rmi -f $$(docker images -qa) 2> /dev/null || exit 0

fclean: clean iclean

.PHONY: run up stop down clean iclean fclean
